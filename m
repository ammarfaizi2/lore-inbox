Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S310378AbSCLDoI>; Mon, 11 Mar 2002 22:44:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S310381AbSCLDn6>; Mon, 11 Mar 2002 22:43:58 -0500
Received: from host194.steeleye.com ([216.33.1.194]:47620 "EHLO
	pogo.mtv1.steeleye.com") by vger.kernel.org with ESMTP
	id <S310378AbSCLDnp>; Mon, 11 Mar 2002 22:43:45 -0500
Message-Id: <200203120343.g2C3hdr12734@localhost.localdomain>
X-Mailer: exmh version 2.4 06/23/2000 with nmh-1.0.4
To: linux-kernel@vger.kernel.org
cc: James.Bottomley@HansenPartnership.com
Subject: Re: [RFC] modularization of i386 setup_arch and mem_init in 2.4.18 
In-Reply-To: Message from James Bottomley <James.Bottomley@HansenPartnership.com> 
   of "Mon, 11 Mar 2002 11:51:29 EST." <200203111651.g2BGpUF06663@localhost.localdomain> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Mon, 11 Mar 2002 22:43:39 -0500
From: James Bottomley <James.Bottomley@HansenPartnership.com>
X-AntiVirus: scanned for viruses by AMaViS 0.2.1 (http://amavis.org/)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I've completed the split into generic visw and voyager.  The base abstraction 
stuff is at:

http://www.hansenpartnership.com/voyager/files/split-2.5.6.diff
http://www.hansenpartnership.com/voyager/files/split-2.5.6.BK

And the voyager stuff which goes on top is at:

http://www.hansenpartnership.com/voyager/files/voyager-2.5.6.diff
http://www.hansenpartnership.com/voyager/files/voyager-2.5.6.BK

There are now no voyager ifdefs anywhere in the arch/i386 directories (there 
are still one or two in the asm-i386, though).

That's all I need to do for this split up if anyone else would like to pick it 
up.

James


