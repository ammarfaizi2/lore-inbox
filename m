Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261874AbULGSQT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261874AbULGSQT (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 7 Dec 2004 13:16:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261877AbULGSQT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 7 Dec 2004 13:16:19 -0500
Received: from viking.sophos.com ([194.203.134.132]:21767 "EHLO
	viking.sophos.com") by vger.kernel.org with ESMTP id S261874AbULGSQH
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 7 Dec 2004 13:16:07 -0500
MIME-Version: 1.0
X-MIMETrack: S/MIME Sign by Notes Client on Tvrtko Ursulin/Dev/UK/Sophos(Release 5.0.12
  |February 13, 2003) at 07/12/2004 18:15:57,
	Serialize by Notes Client on Tvrtko Ursulin/Dev/UK/Sophos(Release 5.0.12  |February
 13, 2003) at 07/12/2004 18:15:57,
	Serialize complete at 07/12/2004 18:15:57,
	S/MIME Sign failed at 07/12/2004 18:15:57: The cryptographic key was not
 found,
	Serialize by Router on Mercury/Servers/Sophos(Release 6.5.2|June 01, 2004) at
 07/12/2004 18:16:04,
	Serialize complete at 07/12/2004 18:16:04
To: tvrtko.ursulin@sophos.com
Cc: linux-kernel@vger.kernel.org, viro@parcelfarce.linux.theplanet.co.uk
Subject: Re: 2.6 path_lookup bug?
X-Mailer: Lotus Notes Release 5.0.12   February 13, 2003
Message-ID: <OF30663992.199E166B-ON80256F63.006421A3-80256F63.0064586F@sophos.com>
From: tvrtko.ursulin@sophos.com
Date: Tue, 7 Dec 2004 18:16:02 +0000
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>Hi,
>
>What would you expect to happen if one called:
>
>path_lookup("foo:/bar", &nd); ?
>
>I suspect there is something fishy going on there because when I do that
>"/bar" gets destabilised and soon afterwards, another lookup on it will
>BUG at dcache.c:276.

dcache.h:276, sorry about that!


