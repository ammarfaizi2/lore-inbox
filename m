Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264174AbTKSXIT (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 19 Nov 2003 18:08:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264178AbTKSXIT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 19 Nov 2003 18:08:19 -0500
Received: from mrout2.yahoo.com ([216.145.54.172]:55635 "EHLO mrout2.yahoo.com")
	by vger.kernel.org with ESMTP id S264174AbTKSXIS (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 19 Nov 2003 18:08:18 -0500
Message-ID: <3FBBF7BF.5040108@bigfoot.com>
Date: Wed, 19 Nov 2003 15:07:43 -0800
From: Erik Steffl <steffl@bigfoot.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i386; en-US; rv:1.3) Gecko/20030312
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Re: notes on 2.4 -> 2.6 upgrade with a Serial ATA root
References: <20031119225425.GF24852@BL4ST>
In-Reply-To: <20031119225425.GF24852@BL4ST>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Eric Wong wrote:
> When using the 2.4.22-xfs kernel (Knoppix -> Debian installation), our
> SATA root drive shows up as /dev/hdg, but under 2.6, it's now a SCSI
> device, /dev/sda.  It took us a while to figure out what was wrong until
> we finally got a serial line and were able to read the boot message
> outputs.
> 
> This is the error message we got originally _before_ we appended
> "root=/dev/sda3" to our command-line:
> 
> VFS: Cannot open root device "2203" or unknown-block(34,3)
> Please append a correct "root=" boot option
> 
> I have a feeling this will take a lot of SATA users by surprise, so
> hopefully it'll be documented from now on.

   you can use SATA drives as scsi drives on 2.4.x kernels too (I use it 
with 2.4.21-ac4), actually at least in my case it's better because when 
I try to use it as IDE drive the system freezes (during probing IDE, 
right after it prints out the info about disks).

	erik


