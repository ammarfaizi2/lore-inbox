Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261175AbULHKfY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261175AbULHKfY (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 8 Dec 2004 05:35:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261179AbULHKfY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 8 Dec 2004 05:35:24 -0500
Received: from viking.sophos.com ([194.203.134.132]:30218 "EHLO
	viking.sophos.com") by vger.kernel.org with ESMTP id S261175AbULHKfT
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 8 Dec 2004 05:35:19 -0500
MIME-Version: 1.0
X-MIMETrack: S/MIME Sign by Notes Client on Tvrtko Ursulin/Dev/UK/Sophos(Release 5.0.12
  |February 13, 2003) at 08/12/2004 10:34:58,
	Serialize by Notes Client on Tvrtko Ursulin/Dev/UK/Sophos(Release 5.0.12  |February
 13, 2003) at 08/12/2004 10:34:58,
	Serialize complete at 08/12/2004 10:34:58,
	S/MIME Sign failed at 08/12/2004 10:34:58: The cryptographic key was not
 found,
	Serialize by Router on Mercury/Servers/Sophos(Release 6.5.2|June 01, 2004) at
 08/12/2004 10:35:19,
	Serialize complete at 08/12/2004 10:35:19
To: tvrtko.ursulin@sophos.com
Cc: linux-kernel@vger.kernel.org, viro@parcelfarce.linux.theplanet.co.uk
Subject: Re: 2.6 path_lookup bug?
X-Mailer: Lotus Notes Release 5.0.12   February 13, 2003
Message-ID: <OFF2F20386.498518D5-ON80256F64.0039E79A-80256F64.003A29AD@sophos.com>
From: tvrtko.ursulin@sophos.com
Date: Wed, 8 Dec 2004 10:35:17 +0000
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>What would you expect to happen if one called:
>>
>>path_lookup("foo:/bar", &nd); ?
>>
>>I suspect there is something fishy going on there because when I do that
>>"/bar" gets destabilised and soon afterwards, another lookup on it will
>>BUG at dcache.c:276.
>
>dcache.h:276, sorry about that!

Ooops, my fault, please ignore the thread!

I was doing an unconditional path_release even if path_lookup failed. 

Sorry once more!


