Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265191AbUBOU22 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 15 Feb 2004 15:28:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265193AbUBOU22
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 15 Feb 2004 15:28:28 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:63966 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S265191AbUBOU21
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 15 Feb 2004 15:28:27 -0500
Message-ID: <402FD643.4040307@pobox.com>
Date: Sun, 15 Feb 2004 15:27:47 -0500
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4) Gecko/20030703
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Mihai RUSU <dizzy@roedu.net>
CC: Jon Smirl <jonsmirl@yahoo.com>, lkml <linux-kernel@vger.kernel.org>
Subject: Re: libata patch
References: <20040214160254.19491.qmail@web14902.mail.yahoo.com> <Pine.LNX.4.58L0.0402151138140.7324@ahriman.bucharest.roedu.net>
In-Reply-To: <Pine.LNX.4.58L0.0402151138140.7324@ahriman.bucharest.roedu.net>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Mihai RUSU wrote:
> -----BEGIN PGP SIGNED MESSAGE-----
> Hash: SHA1
> 
> Hi
> 
> Hmm, I hit the same problem (only once so far) on 2.6.2 vanilla. While I 
> was installing one of my first SATA systems, on ICH5, I hit the same thing 
> (some error in kernel log regardning DMA and the SATA hdd seemed frozen, 
> the only commands working were those cached in RAM already). Hope this 
> helps :) (sorry I couldnt do more, it only happened once so far).

Can you try 2.6.3-rc3?  The questionable patch is not in 2.6.2 vanilla, 
FWIW.

If you could fill out a bug report at http://bugzilla.kernel.org/ and 
include "lspci -vvv" and "dmesg" output, that would be useful.

	Jeff


