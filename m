Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265865AbSLIRrk>; Mon, 9 Dec 2002 12:47:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265885AbSLIRrk>; Mon, 9 Dec 2002 12:47:40 -0500
Received: from ronispc.Chem.McGill.CA ([132.206.205.91]:45976 "EHLO
	ronispc.chem.mcgill.ca") by vger.kernel.org with ESMTP
	id <S265865AbSLIRrh>; Mon, 9 Dec 2002 12:47:37 -0500
From: David Ronis <ronis@ronispc.chem.mcgill.ca>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <15860.55555.185055.901097@ronispc.chem.mcgill.ca>
Date: Mon, 9 Dec 2002 12:55:15 -0500
To: ronis@onsager.chem.mcgill.ca
Cc: Marc-Christian Petersen <m.c.p@wolk-project.de>,
       linux-kernel@vger.kernel.org,
       David Ronis <ronis@ronispc.chem.mcgill.ca>
Subject: Re: build failure in 2.4.20
In-Reply-To: <15860.54084.694635.159603@ronispc.chem.mcgill.ca>
References: <15860.46389.654483.692231@ronispc.chem.mcgill.ca>
	<200212091809.57622.m.c.p@wolk-project.de>
	<15860.54084.694635.159603@ronispc.chem.mcgill.ca>
X-Mailer: VM 7.07 under Emacs 21.2.1
Reply-To: ronis@onsager.chem.mcgill.ca
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I wrote:

[snip]
 > I'm using GNU ld version 2.13 and objdump -i shows that binary is
 > allowed.  I tried changing the instances of -oformat binary to
 > --oformat=binary in arch/i386/Makefile, but the changes seem to be
 > ignored, which is strange.
 > 

It certainly is, I was changing the makefile in one directory tree and
running make bzImage in another.  Changing -oformat binary to
--oformat=binary fixes this probem and bzImage is now built.

David
