Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317159AbSFBJ6E>; Sun, 2 Jun 2002 05:58:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317160AbSFBJ6D>; Sun, 2 Jun 2002 05:58:03 -0400
Received: from pc2-redb4-0-cust125.bre.cable.ntl.com ([213.107.133.125]:22774
	"HELO opel.itsolve.co.uk") by vger.kernel.org with SMTP
	id <S317159AbSFBJ6D>; Sun, 2 Jun 2002 05:58:03 -0400
Date: Sun, 2 Jun 2002 10:52:29 +0100
From: Mark Zealey <mark@zealos.org>
To: linux-kernel@vger.kernel.org
Subject: X colour corruption when switching between X and tdfxfb in 2.4.19-pre8-ac1
Message-ID: <20020602095229.GA4068@itsolve.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.25i
X-Operating-System: Linux sunbeam 2.4.19-pre8-ac1 
X-Homepage: http://zealos.org/
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

When switching between X in 24 bit tdfx mode and my frame-buffer consoles in 32
bit mode using the tdfxfb driver, my X session goes very weird, all the colours
turn very light, i can just about make out the color differences, but it is
hard. This switching worked fine with the exact same setup in 2.4.17 but does
not work now in 2.4.19-pre8-ac1+preempt. Does anyone have ideas on what may be
causing this corruption? to me it seems like some pallet data is being
overwritten but there is no pallet in 24 or 32 bit mode, i thought...

The card is a voodoo banshee running at 1024x768 in both cases.

-- 

Mark Zealey (aka JALH on irc.openprojects.net: #zealos and many more)
mark@zealos.org; mark@itsolve.co.uk

UL++++>$ G!>(GCM/GCS/GS/GM) dpu? s:-@ a17! C++++>$ P++++>+++++$ L+++>+++++$
!E---? W+++>$ !w--- r++ !t---?@ !X---?  !R- !tv b+ G+++ e>+++++ !h++* r!-- y--
