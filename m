Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261297AbREUMeZ>; Mon, 21 May 2001 08:34:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261336AbREUMeQ>; Mon, 21 May 2001 08:34:16 -0400
Received: from router-100M.swansea.linux.org.uk ([194.168.151.17]:58383 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S261297AbREUMeB>; Mon, 21 May 2001 08:34:01 -0400
Subject: Re: [kbuild-devel] Re: CML2 design philosophy heads-up
To: rml@tech9.net (Robert "M." Love)
Date: Mon, 21 May 2001 13:29:25 +0100 (BST)
Cc: mharris@opensourceadvocate.org (Mike "A." Harris),
        jes@sunsite.dk (Jes Sorensen), jcowan@reutershealth.com (John Cowan),
        esr@thyrsus.com, linux-kernel@vger.kernel.org,
        kbuild-devel@lists.sourceforge.net
In-Reply-To: <990446886.1097.1.camel@phantasy> from "Robert "M." Love" at May 21, 2001 08:08:03 AM
X-Mailer: ELM [version 2.5 PL3]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E151ooP-0003i0-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> i mean how in 2.2 the Makefile must search out for gcc, kgcc, gcc-2.95,
> gcc-2.91 etc. what is the cml2 parser going to do? search for my python2

This isnt a CML2 related problem. 

Problem 1: 
	People who don't like the CML2 description

Problem 2:
	People who don't like python

Problem 3:
	People who don't like the tool design

Problem 4:
	People who don't have python2 


#1 is the important item
#2 is fixed by rewriting tools in C
#3 is fixed by writing alternative tools using CML2 - and if you cant its a bug
   in the CML2 language
#4 is probably one for the LDPS/LSB and vendor people to discuss so we have an
official path for python2

