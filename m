Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318722AbSIPAdr>; Sun, 15 Sep 2002 20:33:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318725AbSIPAdr>; Sun, 15 Sep 2002 20:33:47 -0400
Received: from mk-smarthost-4.mail.uk.tiscali.com ([212.74.114.40]:53513 "EHLO
	mk-smarthost-4.mail.uk.tiscali.com") by vger.kernel.org with ESMTP
	id <S318722AbSIPAdq>; Sun, 15 Sep 2002 20:33:46 -0400
X-Mailer: exmh version 2.5 07/13/2001 (debian 2.5-1) with nmh-1.0.4+dev
To: Pavel Machek <pavel@ucw.cz>
cc: James Blackwell <jblack@linuxguru.net>, linux-kernel@vger.kernel.org,
       hch@infradead.org
Subject: Re: [PATCH] IRQ patch for Toshiba Char Driver in 2.5.34 
In-Reply-To: Message from Pavel Machek <pavel@ucw.cz> 
   of "Sun, 15 Sep 2002 22:02:02 +0200." <20020915200202.GA15744@atrey.karlin.mff.cuni.cz> 
References: <20020909115956.GA23290@comet> <20020911112938.A25726@infradead.org> <20020915154248.GA3647@elf.ucw.cz> <20020915213009.A53847@ucw.cz> <20020915195328.GA60517@comet>  <20020915200202.GA15744@atrey.karlin.mff.cuni.cz> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Mon, 16 Sep 2002 00:39:04 +0100
From: Jonathan Buzzard <jonathan@buzzard.org.uk>
Message-Id: <E17qiyn-0001ZK-00@jelly.buzzard.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



pavel@ucw.cz said:
> It would be nice to make it preempt/smp safe, through. [SMP notebooks
> are not so unreasonable; think p4 hyperthreading]. 

They are here. The code that is protected by cli() and friends does not
run on any anything more fancy than a Pentium. As I recall nothing but
mobile P90 in a Portage 610CT and a mobile P120 in a Tecra 700CDT/CDS.

JAB.

-- 
Jonathan A. Buzzard                 Email: jonathan@buzzard.org.uk
Northumberland, United Kingdom.       Tel: +44(0)1661-832195


