Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131629AbRAXShZ>; Wed, 24 Jan 2001 13:37:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132566AbRAXShQ>; Wed, 24 Jan 2001 13:37:16 -0500
Received: from ikar.t17.ds.pwr.wroc.pl ([156.17.210.253]:520 "HELO
	ikar.t17.ds.pwr.wroc.pl") by vger.kernel.org with SMTP
	id <S131629AbRAXShE>; Wed, 24 Jan 2001 13:37:04 -0500
Date: Wed, 24 Jan 2001 19:35:25 +0100
From: Arkadiusz Miskiewicz <misiek@pld.ORG.PL>
To: linux-kernel@vger.kernel.org
Subject: Re: vfat <-> vfat copying of ~700MB file, so slow!
Message-ID: <20010124193525.A28379@ikar.t17.ds.pwr.wroc.pl>
Mail-Followup-To: Arkadiusz Miskiewicz <misiek@pld.ORG.PL>,
	linux-kernel@vger.kernel.org
In-Reply-To: <20010124131431.A19957@ikar.t17.ds.pwr.wroc.pl> <997u6tsn18dp9u1h97q4j5jc9a2amn1nsp@i-vic.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-2
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: Mutt/1.2.5i
In-Reply-To: <997u6tsn18dp9u1h97q4j5jc9a2amn1nsp@i-vic.net>; from bradf@i-vic.net on Wed, Jan 24, 2001 at 12:23:03PM -0600
X-URL: http://www.t17.ds.pwr.wroc.pl/~misiek/ipv6/
X-Operating-System: Linux dark 4.0.20 #119 Tue Jan 16 12:21:53 MET 2001 i986 pld
Organization: Polish(ed) Linux Distribution Team
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On/Dnia Wed, Jan 24, 2001 at 12:23:03PM -0600, Brad Felmey wrote/napisa³(a)
> > I/O support  =  0 (default 16-bit)
> 
> hdparm -c1 /dev/hda, or are you running in 16-bit mode on purpose?
no purpose. Setting this can only speed up all operations a bit but it doesn't
change nothing in vfat <-> vfat copying. It still slows down while copying.

> Brad Felmey

-- 
Arkadiusz Mi¶kiewicz, AM2-6BONE    [ PLD GNU/Linux IPv6 ]
http://www.t17.ds.pwr.wroc.pl/~misiek/ipv6/   [ enabled ]
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
