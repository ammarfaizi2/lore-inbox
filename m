Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261325AbULSTi4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261325AbULSTi4 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 19 Dec 2004 14:38:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261332AbULSTi4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 19 Dec 2004 14:38:56 -0500
Received: from main.gmane.org ([80.91.229.2]:29138 "EHLO main.gmane.org")
	by vger.kernel.org with ESMTP id S261325AbULSTiy (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 19 Dec 2004 14:38:54 -0500
X-Injected-Via-Gmane: http://gmane.org/
To: linux-kernel@vger.kernel.org
From: Ari Pollak <aripollak@gmail.com>
Subject: Re: VIA SATA I/O errors
Date: Sun, 19 Dec 2004 14:38:20 -0500
Message-ID: <cq4lc3$94g$1@sea.gmane.org>
References: <cpsb8p$gsd$1@sea.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: atlantis.ccs.neu.edu
User-Agent: Mozilla Thunderbird 0.9 (X11/20041124)
X-Accept-Language: en-us, en
In-Reply-To: <cpsb8p$gsd$1@sea.gmane.org>
X-Enigmail-Version: 0.89.0.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Just for the record (in case people see this in the archive and wonder 
what the solution was) - the drive has had a steadily shorter uptime 
over the past few days. When I re-ran WD diagnostics, it finally found a 
problem with the drive, so I'm going to be exchanging it and hopefully a 
new drive will fix the problem.

Ari Pollak wrote:
> Hi.
> I have an Athlon64 machine running kernel 2.6.10-rc3 (but this problem 
> has happened on 2.6.9-ac7 as well) with a VIA VT6420 SATA controller. 
> Every few days (the problem is not chronologically consistent) and/or 
> when there's heavy disk usage,  the main SATA disk (a Western Digital 
> model WDC WD1200JD-00G) will just completely stop responding to any I/O, 
> and a lot of SCSI error messages will be output to the console. After a 
> few instances of this happening (which requires a hard power-off, then 
> power-on.. just hitting the reset button causes the SATA controller not 
> to recognize the drive on boot), I finally managed to capture some of 
> the kernel messages, since somehow I could still read one of my log 
> files (cached in memory, I guess). The same set of errors just keep 
> repeating over and over. I also believe there was an ext3 error that 
> showed up on the console and not in the log, but I assume this is not an 
> ext3 problem anyway. The partial log file and the output of lspci -vvv 
> are attached. I have no idea whether this is a software or hardware 
> problem. Running Western Digital's diagnostics on the drive turned up no 
> errors. If anyone has seen this problem before and it turned out to be 
> hardware-related, I'd like to find out exactly which component is the 
> culprit.
> 
> Thanks in advance,
> Ari

