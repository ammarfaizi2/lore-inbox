Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261538AbTKLUcr (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 12 Nov 2003 15:32:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261539AbTKLUcr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 12 Nov 2003 15:32:47 -0500
Received: from mpc-26.sohonet.co.uk ([193.203.82.251]:63719 "EHLO
	moving-picture.com") by vger.kernel.org with ESMTP id S261538AbTKLUcq
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 12 Nov 2003 15:32:46 -0500
Message-ID: <3FB298F0.7030604@moving-picture.com>
Date: Wed, 12 Nov 2003 20:32:48 +0000
From: James Pearson <james-p@moving-picture.com>
User-Agent: Mozilla/5.0 (Windows; U; Win98; en-US; rv:1.4) Gecko/20030624 Netscape/7.1 (ax)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Charles Mason <mason@csit.fsu.edu>, linux-kernel@vger.kernel.org
Subject: Re: HFS bug
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-Disclaimer: This email and any attachments are confidential, may be legally
X-Disclaimer: privileged and intended solely for the use of addressee. If you
X-Disclaimer: are not the intended recipient of this message, any disclosure,
X-Disclaimer: copying, distribution or any action taken in reliance on it is
X-Disclaimer: strictly prohibited and may be unlawful. If you have received
X-Disclaimer: this message in error, please notify the sender and delete all
X-Disclaimer: copies from your system.
X-Disclaimer: 
X-Disclaimer: Email may be susceptible to data corruption, interception and
X-Disclaimer: unauthorised amendment, and we do not accept liability for any
X-Disclaimer: such corruption, interception or amendment or the consequences
X-Disclaimer: thereof.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> This may or may not be a bug, but I figured that sending out the message
> would do better good than not sending one out at all:
> 
> when I run the command:
> 
> # mount -t hfs /dev/scd0 /mnt/cdrom 
> 
> The kernel gives an Oops that traces back to line buffer.c:2555 (kernel
> version 2.4.23-pre1). I'd attach the Oops output, but I'm on a remote
> machine now.

You could try something like:

mount -r -t hfs -o loop /dev/scd0 /mnt/cdrom

Or, have a look at Roman Zippel's new HFS+/HFS driver at:

http://www.ardistech.com/hfsplus/

James Pearson


