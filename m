Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281458AbRL0OKc>; Thu, 27 Dec 2001 09:10:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281648AbRL0OKW>; Thu, 27 Dec 2001 09:10:22 -0500
Received: from adsl-64-109-89-110.dsl.chcgil.ameritech.net ([64.109.89.110]:48216
	"EHLO localhost.localdomain") by vger.kernel.org with ESMTP
	id <S281458AbRL0OKO>; Thu, 27 Dec 2001 09:10:14 -0500
Message-Id: <200112271409.fBRE9kR19806@localhost.localdomain>
X-Mailer: exmh version 2.4 06/23/2000 with nmh-1.0.4
To: Dave Jones <davej@suse.de>
cc: James Bottomley <James.Bottomley@HansenPartnership.com>,
        torvalds@transmeta.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH: NEW ARCHITECTURE FOR 2.5] support for NCR voyager 
 343x/345x/4100/51xx architecture
In-Reply-To: Message from Dave Jones <davej@suse.de> 
   of "Mon, 24 Dec 2001 01:10:43 +0100." <Pine.LNX.4.33.0112240106490.17860-100000@Appserv.suse.de> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Thu, 27 Dec 2001 08:09:45 -0600
From: James Bottomley <James.Bottomley@HansenPartnership.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

davej@suse.de said:
> I'd be *so* much happier to see your patch with setup-voyager.c, and a
> single ifdef in setup.c wrapping setup_voyager() or the likes.

> On another related topic, the bootmem stuff in setup.c would be so
> much nicer to be split into a bootmem.c imho.

> This would also make sharing the x86 bootmem code with the x86-64
> bootmem code a lot simpler. 

Separation is clearly a better way to go.  I'll see what I can do (and whether 
I can take the visw along too). Where is the x86-64 code?  I haven't seen it 
since 2.4.13-ac8.

James Bottomley


