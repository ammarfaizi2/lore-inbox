Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266298AbUAHV0a (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 8 Jan 2004 16:26:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266299AbUAHV0a
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 8 Jan 2004 16:26:30 -0500
Received: from moutng.kundenserver.de ([212.227.126.171]:55017 "EHLO
	moutng.kundenserver.de") by vger.kernel.org with ESMTP
	id S266298AbUAHV03 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 8 Jan 2004 16:26:29 -0500
From: Christian Borntraeger <kernel@borntraeger.net>
To: bluefoxicy@linux.net, linux-kernel@vger.kernel.org
Subject: Re: Oops 0002
Date: Thu, 8 Jan 2004 22:26:21 +0100
User-Agent: KMail/1.5.4
References: <20040108184935.BD5E3E4B8@sitemail.everyone.net>
In-Reply-To: <20040108184935.BD5E3E4B8@sitemail.everyone.net>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200401082226.21209.kernel@borntraeger.net>
X-Provags-ID: kundenserver.de abuse@kundenserver.de auth:5a8b66f42810086ecd21595c2d6103b9
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

john moser wrote:
> icebox regression # ./memkmemport_test
> Testing denied write of /dev/mem... : FAILED
[...]
> Oops: 0002 [#3]

You started this testcase as root? I think writing to /dev/kmem as root is 
working as designed.
Having an oops after this artificial memory corruption is quite normal.
Your oops is only interesting if this happens with a non-root user.


cheers

Christian

