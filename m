Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262409AbVAKUJv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262409AbVAKUJv (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 11 Jan 2005 15:09:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262571AbVAKUJu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 11 Jan 2005 15:09:50 -0500
Received: from av5-2-sn3.vrr.skanova.net ([81.228.9.114]:13776 "EHLO
	av5-2-sn3.vrr.skanova.net") by vger.kernel.org with ESMTP
	id S262409AbVAKUIJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 11 Jan 2005 15:08:09 -0500
To: Laurent CARON <lcaron@apartia.fr>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Unable to burn DVDs
References: <41E2F823.1070608@apartia.fr>
From: Peter Osterlund <petero2@telia.com>
Date: 11 Jan 2005 21:08:06 +0100
In-Reply-To: <41E2F823.1070608@apartia.fr>
Message-ID: <m3wtujafvd.fsf@telia.com>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.3
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Laurent CARON <lcaron@apartia.fr> writes:

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
> Needless to say it works fine with 2.6.9

According to the Mt Fuji spec, 4/08/03 means:

        LOGICAL UNIT COMMUNICATION CRC ERROR (ULTRA-DMA/32)

I don't know what could be causing this error though.

-- 
Peter Osterlund - petero2@telia.com
http://web.telia.com/~u89404340
