Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315746AbSFPAAh>; Sat, 15 Jun 2002 20:00:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315758AbSFPAAg>; Sat, 15 Jun 2002 20:00:36 -0400
Received: from host194.steeleye.com ([216.33.1.194]:60174 "EHLO
	pogo.mtv1.steeleye.com") by vger.kernel.org with ESMTP
	id <S315746AbSFPAAg>; Sat, 15 Jun 2002 20:00:36 -0400
Message-Id: <200206160000.g5G00PX24105@localhost.localdomain>
X-Mailer: exmh version 2.4 06/23/2000 with nmh-1.0.4
To: Dave Jones <davej@suse.de>, James Bottomley <James.Bottomley@SteelEye.com>,
        James Bottomley <James.Bottomley@HansenPartnership.com>,
        Andrey Panin <pazke@orbita1.ru>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH: NEW SUBARCHITECTURE FOR 2.5.21] support for NCR voyager 
 (3/4/5xxx series)
In-Reply-To: Message from Andrey Panin <pazke@orbita1.ru> 
   of "Fri, 14 Jun 2002 17:41:52 +0400." <20020614134152.GA1293@pazke.ipt> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Sat, 15 Jun 2002 20:00:25 -0400
From: James Bottomley <James.Bottomley@SteelEye.com>
X-AntiVirus: scanned for viruses by AMaViS 0.2.1 (http://amavis.org/)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

pazke@orbita1.ru said:
> "Latest" (2.4.17) visws patch which i'm planning to convert for 2.5,
> uses function MP_processor_info() from generic mpparse.c. May be it
> makes sence to move to some generic file ? 

OK, I moved mpparse back into kernel (and gated it on CONFIG_X86_MPPARSE).  It 
probably makes sense to split it up so that you only get the piece you need 
for visws.

I've also done the mach-* renames by popular request.  The new patch is at:

http://www.hansenpartnership.com/voyager/files/arch-split-2.5.21-II.diff

and also in the bitkeeper repository:

http://linux-voyager.bkbits.net/arch-split-2.5

James


