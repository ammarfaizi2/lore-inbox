Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317461AbSFHWFU>; Sat, 8 Jun 2002 18:05:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317462AbSFHWFT>; Sat, 8 Jun 2002 18:05:19 -0400
Received: from air-2.osdl.org ([65.201.151.6]:9229 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id <S317461AbSFHWFS>;
	Sat, 8 Jun 2002 18:05:18 -0400
Date: Sat, 8 Jun 2002 15:01:13 -0700 (PDT)
From: "Randy.Dunlap" <rddunlap@osdl.org>
X-X-Sender: <rddunlap@dragon.pdx.osdl.net>
To: Ravikiran G Thirumalai <kiran@in.ibm.com>
cc: <linux-kernel@vger.kernel.org>
Subject: Re: question: i/o port 0x61 on x86 archs
In-Reply-To: <20020608165147.A16911@in.ibm.com>
Message-ID: <Pine.LNX.4.33L2.0206081458560.28858-100000@dragon.pdx.osdl.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 8 Jun 2002, Ravikiran G Thirumalai wrote:

| I have a question regdg do_nmi routine in x86; what does location 0x61
| from inb(0x61) do? Is it something very well known in intel archs?

Yes, see any Intel PIIX or ICH chipset spec.
I'm looking at the 82801BA I/O Controller Hub 2 (ICH2)
spec., section 9.7.1.

Port 0x61 is the NMI status and control register.

-- 
~Randy

