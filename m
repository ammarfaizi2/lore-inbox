Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262764AbVAKAIg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262764AbVAKAIg (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 10 Jan 2005 19:08:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262541AbVAKAGU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 10 Jan 2005 19:06:20 -0500
Received: from pfepa.post.tele.dk ([195.41.46.235]:7963 "EHLO
	pfepa.post.tele.dk") by vger.kernel.org with ESMTP id S262595AbVAJXvF
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 10 Jan 2005 18:51:05 -0500
Subject: Re: Unable to burn DVDs
From: Kasper Sandberg <lkml@metanurb.dk>
To: Laurent CARON <lcaron@apartia.fr>
Cc: LKML Mailinglist <linux-kernel@vger.kernel.org>
In-Reply-To: <41E2F823.1070608@apartia.fr>
References: <41E2F823.1070608@apartia.fr>
Content-Type: text/plain
Date: Tue, 11 Jan 2005 00:50:59 +0100
Message-Id: <1105401059.13327.0.camel@localhost>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

same thing happens to me!

On Mon, 2005-01-10 at 22:48 +0100, Laurent CARON wrote:
> Hello,
> 
> I recently upgraded to 2.6.10 and tried (today) to burn a dvd with 
> growisofs.
> 
> It seems there is a problem
> 
> Here is the output
> 
> 
> # growisofs -Z /dev/scd0 -R -J ~/foobar
> 
> WARNING: /dev/scd0 already carries isofs!
> About to execute 'mkisofs -R -J /root/sendmail.mc | builtin_dd 
> of=/dev/scd0 obs=32k seek=0'
> INFO:ingISO-8859-15 character encoding detected by locale settings.
>         Assuming ISO-8859-15 encoded filenames on source filesystem,
>         use -input-charset to override.
> Total translation table size: 0
> Total rockridge attributes bytes: 252
> Total directory bytes: 0
> Path table size(bytes): 10
> /dev/scd0: "Current Write Speed" is 4.1x1385KBps.
> :-[ WRITE@LBA=0h failed with SK=4h/ASC=08h/ACQ=03h]: Input/output error
> :-( write failed: Input/output error
> 
> 
> Needless to say it works fine with 2.6.9
> 
> Am I missing something?
> 
> Thanks
> 
> Laurent
> 

