Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S269009AbRG3QrO>; Mon, 30 Jul 2001 12:47:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S269007AbRG3QrE>; Mon, 30 Jul 2001 12:47:04 -0400
Received: from [212.204.66.1] ([212.204.66.1]:57871 "EHLO myway.myway.de")
	by vger.kernel.org with ESMTP id <S269008AbRG3Qqw>;
	Mon, 30 Jul 2001 12:46:52 -0400
Message-Id: <200107301646.SAA07105@myway.myway.de>
From: "Daniela Engert" <dani@ngrt.de>
To: "Kurt Garloff" <garloff@suse.de>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Date: Mon, 30 Jul 2001 18:47:00 +0200 (CDT)
Reply-To: "Daniela Engert" <dani@ngrt.de>
X-Mailer: PMMail 2.00.1500 for OS/2 Warp 4.05
In-Reply-To: <20010730154458.C4859@pckurt.casa-etp.nl>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Subject: Re: VIA KT133A / athlon / MMX
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org
Original-Recipient: rfc822;linux-kernel-outgoing

Hi Kurt!

On Mon, 30 Jul 2001 15:44:58 +0200, Kurt Garloff wrote:

Just for reference: these are the values taken from my main machine
(Epox EP8KTA2, VIA KT133) with the latest BIOS:

>> [54:6]=Probe Next Tag State T1	0=disable   1=enable
>Main suspect. (Should be 0)

Set to 1 here.

>> [54:0]=Fast Write-to-Read	0=disable   1=enable
>Third candidate. (Should be 0)

Set to 1 here.

>> [68:4]=DRAM Data Latch Delay	0=Latch     1=Delay latch
>Second candidate (Should be 1)

Set to 1 here.

>> [68:2]=Burst Refresh(4 times)	0=disable   1=enable
>Fourth candidate (Should be 0?)

Set to 0 here.

>> [6B:5]=Fast Read to Write t-a	0=disable   1=enable
>Should this one match 54:0 (third candidate)?

Set to 0 here.

>> [6B:1]=Virtual Channel-DRAM	0=disable   1=enable
>Strange, why does this one differ between the configs.

Set to 0 here.

Unfortunately, this machine doesn't run Linux...

Ciao,
  Dani


