Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261380AbUDTAIj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261380AbUDTAIj (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 19 Apr 2004 20:08:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261396AbUDTAIj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 19 Apr 2004 20:08:39 -0400
Received: from us01smtp1.synopsys.com ([198.182.44.79]:31738 "EHLO
	boden.synopsys.com") by vger.kernel.org with ESMTP id S261380AbUDTAIh
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 19 Apr 2004 20:08:37 -0400
Message-Id: <200404200008.i3K08Zvs018948@radium.internal.synopsys.com>
Date: Mon, 19 Apr 2004 17:08:35 -0700 (PDT)
From: Venkata Ravella <Venkata.Ravella@synopsys.com>
Reply-To: Venkata Ravella <Venkata.Ravella@synopsys.com>
Subject: Re: Automount/NFS issues causing executables to appear corrupted
To: raven@themaw.net
Cc: linux-kernel@vger.kernel.org, Ramki.Balasubramanium@synopsys.COM,
       ab@californiadigital.com, hpa@zytor.com, autofs@linux.kernel.org
MIME-Version: 1.0
Content-Type: TEXT/plain; charset=us-ascii
Content-MD5: +FBRoMmHSN9ox+1AV41ZHg==
X-Mailer: dtmail 1.3.0 @(#)CDE Version 1.5 SunOS 5.9 sun4u sparc 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


autofs version is autofs-3.1.7-21

I also have one new update. We started seeing similar problem on
the system running the kernel 2.4.18-e.12smp which has the same
version(3.1.7-21) of autofs as well.

This may or may not be an autofs problem but, restarting autofs
fixes this problem temporarily.


>
>Please cc autofs questions to the list at autofs@linux.kernel.org.
>
>On Sun, 18 Apr 2004, Venkata Ravella wrote:
>
>> 
>> The current kernel we use is default 7.2 kernel with two modifications:
>> 1) BM patch applied to extend address space for a single process to 3.6GB
>> 2) mnt patch applied to allow upto 1024 nfs mount points
>> 
>> uname -r output:
>> 2.4.7-10mntBMsmp
>
>What autofs version?
>
>To be honest it's a bit hard to see how this is an autofs issue.
>Mind, having said that, ....
>
>Ian

