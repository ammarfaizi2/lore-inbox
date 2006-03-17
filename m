Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751228AbWCQJzL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751228AbWCQJzL (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 17 Mar 2006 04:55:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751283AbWCQJzL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 17 Mar 2006 04:55:11 -0500
Received: from smtp6.libero.it ([193.70.192.59]:6875 "EHLO smtp6.libero.it")
	by vger.kernel.org with ESMTP id S1751228AbWCQJzK (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 17 Mar 2006 04:55:10 -0500
From: <mtassinari@libero.it>
To: "'Samuel Masham'" <samuel.masham@gmail.com>
Cc: <linux-kernel@vger.kernel.org>
Subject: R: libata/sata errors on ich[?]/maxtor
Date: Fri, 17 Mar 2006 10:55:03 +0100
Message-ID: <!~!UENERkVCMDkAAQACAAAAAAAAAAAAAAAAABgAAAAAAAAAcm3p+dGrIEuKvCi2uAOJU8KAAAAQAAAANezXGJ110ECmqkLxIsGzkgEAAAAA@libero.it>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook, Build 10.0.6626
Importance: Normal
In-Reply-To: <93564eb70603162201l856be5al@mail.gmail.com>
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.2670
X-Scanned: with antispam and antivirus automated system at libero.it
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Samuel, All

> some value in adding my information here... I will be adding this to 
> redhats bugzilla ... soon ;)
>
>see: https://bugzilla.redhat.com/bugzilla/show_bug.cgi?id=185724
>
> What seems to happen is that mkfs will try and write to the drive 
> using the normal
>

from bugzilla:

>Writing inode tables:  733/1247        
>  
>....and then no more (actually since the update the block number we stick
on  
>has moved slightly)  

yes, we experimented the same absolutely reproducible behaviour, 
the system hangs - better, processes involving i/o hang - 
after a few timeouts and cannot be brought down other than hard resetting
it.
Our mileage can vary...

We use vanilla kernels on slackware-current distribution (see ver_linux in
previous post).

Tryed:
2.6.15
2.6.15.6
2.6.16-rc4
2.6.16-rc6

Mauro


