Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265766AbRGCSdM>; Tue, 3 Jul 2001 14:33:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265744AbRGCSdC>; Tue, 3 Jul 2001 14:33:02 -0400
Received: from isimail.interactivesi.com ([207.8.4.3]:18188 "HELO
	dinero.interactivesi.com") by vger.kernel.org with SMTP
	id <S265757AbRGCScs>; Tue, 3 Jul 2001 14:32:48 -0400
Date: Tue, 3 Jul 2001 13:32:36 -0500
From: Timur Tabi <ttabi@interactivesi.com>
To: Andi Kleen <ak@suse.de>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <oupelryykh5.fsf@pigdrop.muc.suse.de>
In-Reply-To: <9LUWoC.A.W3G.sIQQ7@dinero.interactivesi.com.suse.lists.linux.kernel> 
	Timur Tabi's message of "3 Jul 2001 01:29:40 +0200"
Subject: Re: pte_val(*pte) as lvalue
X-Mailer: The Polarbar Mailer; version=1.19a; build=73
Message-ID: <LScPx.A.XAF.H_gQ7@dinero.interactivesi.com>
X-AntiVirus: scanned for viruses by AMaViS 0.2.1 (http://amavis.org/)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

** Reply to message from Andi Kleen <ak@suse.de> on 03 Jul 2001 01:33:42 +0200

> Timur Tabi <ttabi@interactivesi.com> writes:
> 
> > 
> > What is the accepted way to assign an integer to a pte that works in 2.2 and
> > 2.4?
> 
> set_pte(pte, mk_pte( ... )) 

I'm not sure how to use mk_pte.  The first parameter is a struct page *, which
I don't have.  All I'm doing is modifying the PTE value.  I don't want to "make"
another one.


-- 
Timur Tabi - ttabi@interactivesi.com
Interactive Silicon - http://www.interactivesi.com

