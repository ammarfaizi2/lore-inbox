Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262133AbVBAWAy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262133AbVBAWAy (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 1 Feb 2005 17:00:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262137AbVBAWAy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 1 Feb 2005 17:00:54 -0500
Received: from main.gmane.org ([80.91.229.2]:17551 "EHLO ciao.gmane.org")
	by vger.kernel.org with ESMTP id S262133AbVBAWAq (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 1 Feb 2005 17:00:46 -0500
X-Injected-Via-Gmane: http://gmane.org/
To: linux-kernel@vger.kernel.org
From: Richard Hughes <ee21rh@surrey.ac.uk>
Subject: Re: Linux hangs during IDE initialization at boot for 30 sec
Date: Tue, 01 Feb 2005 20:22:15 +0000
Message-ID: <pan.2005.02.01.20.21.46.334334@surrey.ac.uk>
References: <200502011257.40059.brade@informatik.uni-muenchen.de>
Reply-To: ee21rh@surrey.ac.uk
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: host81-153-4-107.range81-153.btcentralplus.com
User-Agent: Pan/0.14.2 (This is not a psychotic episode. It's a cleansing moment of clarity.)
X-Gmane-MailScanner: Found to be clean
X-Gmane-MailScanner: Found to be clean
X-Gmane-MailScanner-SpamScore: ss
X-MailScanner-From: glk-linux-kernel@m.gmane.org
X-MailScanner-To: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 01 Feb 2005 12:57:33 +0100, Michael Brade wrote:

> Hi,
> 
> since at least kernel 2.6.9 I'm having a problem booting linux - it hangs 
> after this
> 
> Probing IDE interface ide0...
> hda: HITACHI_DK23DA-30, ATA DISK drive
> elevator: using anticipatory as default io scheduler
> ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
> Probing IDE interface ide1...
> hdc: TOSHIBA DVD-ROM SD-R2212, ATAPI CD/DVD-ROM drive
> ide1 at 0x170-0x177,0x376 on irq 15
> 
> After about 30 seconds everything continues fine with
> 
> hda: max request size: 128KiB
> 
> I found additional lines in the log just before the line above:

Same here on 2.6.11-rc2-bk3 using a *Toshiba* Satellite Pro A10.

messages can be found here:

http://hughsie.no-ip.com/write/kernel/messages

please ask if you need any more info.

Richard Hughes




