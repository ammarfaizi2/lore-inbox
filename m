Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S273303AbRIQBab>; Sun, 16 Sep 2001 21:30:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S273309AbRIQBaU>; Sun, 16 Sep 2001 21:30:20 -0400
Received: from p0011.as-l042.contactel.cz ([194.108.237.11]:12928 "EHLO
	ppc.vc.cvut.cz") by vger.kernel.org with ESMTP id <S273303AbRIQBaQ>;
	Sun, 16 Sep 2001 21:30:16 -0400
Date: Mon, 17 Sep 2001 02:58:26 +0200
From: Petr Vandrovec <vandrove@vc.cvut.cz>
To: Roberto Jung Drebes <drebes@inf.ufrgs.br>
Cc: linux-kernel@vger.kernel.org, alan@lxorguk.ukuu.org.uk
Subject: Re: Athlon: Try this (was: Re: Athlon bug stomping #2)
Message-ID: <20010917025826.E6825@ppc.vc.cvut.cz>
In-Reply-To: <E15icMH-0005H3-00@the-village.bc.nu> <Pine.GSO.4.21.0109161350370.20722-100000@jacui>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.GSO.4.21.0109161350370.20722-100000@jacui>
User-Agent: Mutt/1.3.20i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Sep 16, 2001 at 01:52:36PM -0300, Roberto Jung Drebes wrote:
> On Sun, 16 Sep 2001, Alan Cox wrote:
> > One way to test this hypthesis maybe to run dmidecode on the machines and
> > see if they report KT133 or KT133A. Its also possible some BIOS code does
> > blindly program bit 7 even tho its reserved and should have been kept
> > unchanged.
> 
> I'm not sure if this is the output you are talking about (I see no KT133
> strings on it) but here it goes (this motherboard uses KT133A and
> exhibits the bug):
> 
> Handle 0x0001
> 	DMI type 1, 25 bytes.
> 	System Information Block
> 		Vendor: VIA Technologies, Inc.
> 		Product: VT8363
> 		Version:  
> 		Serial Number:  

VT8363 is basic KT133. KT133A == VT8363A, at least according
to VT8363A datasheet...

> Handle 0x0002
> 	DMI type 2, 8 bytes.
> 	Board Information Block
> 		Vendor:  <http://www.abit.com.tw>
> 		Product: 8363-686A(KT7,KT7A,KT7A-RAID,KT7E)
> 		Version:  
> 		Serial Number:  

... but there are listed both KT133 and KT133A based motherboards, 
so maybe it is intentional?
				Best regards,
					Petr Vandrovec
					vandrove@vc.cvut.cz

