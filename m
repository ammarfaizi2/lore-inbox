Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288484AbSANAk6>; Sun, 13 Jan 2002 19:40:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S288460AbSANAkA>; Sun, 13 Jan 2002 19:40:00 -0500
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:9485 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S288449AbSANAjk>; Sun, 13 Jan 2002 19:39:40 -0500
Subject: Re: [2.4.17/18pre] VM and swap - it's really unusable
To: skraw@ithnet.com (Stephan von Krawczynski)
Date: Mon, 14 Jan 2002 00:50:54 +0000 (GMT)
Cc: zippel@linux-m68k.org (Roman Zippel), alan@lxorguk.ukuu.org.uk (Alan Cox),
        rml@tech9.net (Robert Love), ken@canit.se (Kenneth Johansson),
        arjan@fenrus.demon.nl, landley@trommello.org (Rob Landley),
        linux-kernel@vger.kernel.org
In-Reply-To: <200201140033.BAA04292@webserver.ithnet.com> from "Stephan von Krawczynski" at Jan 14, 2002 01:33:02 AM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E16PvKx-00005L-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Tell me honestly that the idea behind this patch is not _crap_. You   
> can only make this basic idea work if you patch a tremendous lot of   
> those conditional_schedules() through the kernel. We already saw it   
> starting off in some graphics drivers, network drivers. Why not just  
> all of it? You will not be far away in the end from the 'round 4000 I 
> already stated in earlier post.                                       

There are very few places you need to touch to get a massive benefit. Most
of the kernel already behaves extremely well.

> So I understand you agree somehow with me in the answer to "what idea 
> is really better?"...                                                 

Do you want a clean simple solution or complex elegance ? For 2.4 I definitely
favour clean and simple. For 2.5 its an open debate
