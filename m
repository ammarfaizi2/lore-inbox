Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288680AbSADQsn>; Fri, 4 Jan 2002 11:48:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S288681AbSADQsY>; Fri, 4 Jan 2002 11:48:24 -0500
Received: from [208.48.139.185] ([208.48.139.185]:47272 "HELO
	forty.greenhydrant.com") by vger.kernel.org with SMTP
	id <S288680AbSADQsP>; Fri, 4 Jan 2002 11:48:15 -0500
Date: Fri, 4 Jan 2002 08:48:07 -0800
From: David Rees <dbr@greenhydrant.com>
To: linux-kernel@vger.kernel.org
Subject: Re: ASUS KT266A/VT8233 board and UDMA setting
Message-ID: <20020104084807.A16446@greenhydrant.com>
Mail-Followup-To: David Rees <dbr@greenhydrant.com>,
	linux-kernel@vger.kernel.org
In-Reply-To: <20020104112834.A20724@suse.cz> <E16MSOG-0003ch-00@the-village.bc.nu> <20020104153721.E1331@niksula.cs.hut.fi>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20020104153721.E1331@niksula.cs.hut.fi>; from vherva@niksula.hut.fi on Fri, Jan 04, 2002 at 03:37:21PM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 04, 2002 at 03:37:21PM +0200, Ville Herva wrote:
> 
> We are still seeing what seems to be Via PCI corruption when using HPT370 on
> Abit-KT7-RAID. This is pretty high load (stream read/write two disks in
> parallel.) It appears as 90-160 byte disk corruption.
> 
> It has been reproduced on 2.2.18pre19 + ide, 2.2.20+ide and 2.4.15.
> 
> We now seem to have found a BIOS setting that cures this for 2.2.20+ide.
> The weird thing is that if we boot 2.2.21pre2+ide (pre2 includes the 2.4
> backported VIA fixes), the corruption occurs.
> 
> We'll try to diff lspci -vvxxx outputs and post a more detailed report
> shortly.

What's the BIOS setting?

-Dave
