Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267797AbTBKMZl>; Tue, 11 Feb 2003 07:25:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267801AbTBKMZl>; Tue, 11 Feb 2003 07:25:41 -0500
Received: from waldorf.cs.uni-dortmund.de ([129.217.4.42]:12747 "EHLO
	waldorf.cs.uni-dortmund.de") by vger.kernel.org with ESMTP
	id <S267797AbTBKMZj>; Tue, 11 Feb 2003 07:25:39 -0500
Message-Id: <200302111234.h1BCYqgS004257@eeyore.valparaiso.cl>
To: John Levon <levon@movementarian.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 2/4] oprofile update: CPU type as string 
In-Reply-To: Your message of "Tue, 11 Feb 2003 11:42:43 GMT."
             <20030211114243.GB57908@compsoc.man.ac.uk> 
Date: Tue, 11 Feb 2003 13:34:52 +0100
From: Horst von Brand <brand@jupiter.cs.uni-dortmund.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

John Levon <levon@movementarian.org> said:
> This patch updates the horrible enum for the logical CPU type with a
> string instead.

Better use "ia32/P4" and so on, "i386/P4" makes little sense ;-)

You could (should?) place the CPU ID into the model spec too...

BTW, if nobody (except masochistic kernel source readers) sees this stuff,
what is the point? An enum uses less space than a char * + the string.
-- 
Dr. Horst H. von Brand                   User #22616 counter.li.org
Departamento de Informatica                     Fono: +56 32 654431
Universidad Tecnica Federico Santa Maria              +56 32 654239
Casilla 110-V, Valparaiso, Chile                Fax:  +56 32 797513
