Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265140AbTBBIh2>; Sun, 2 Feb 2003 03:37:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265154AbTBBIh2>; Sun, 2 Feb 2003 03:37:28 -0500
Received: from pc2-cwma1-4-cust86.swan.cable.ntl.com ([213.105.254.86]:57230
	"EHLO irongate.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S265140AbTBBIh1>; Sun, 2 Feb 2003 03:37:27 -0500
Subject: Re: Defect (Bug) Report
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: "John W. M. Stevens" <john@betelgeuse.us>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <20030202011223.GC5432@morningstar.nowhere.lie>
References: <20030202011223.GC5432@morningstar.nowhere.lie>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Organization: 
Message-Id: <1044178961.16853.9.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.1 (1.2.1-2) 
Date: 02 Feb 2003 09:42:41 +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> So, to obtain further information, I would need some kind of ability
> to force an Oops . . . can this be done with SysReq hot keys?  There
> doesn't appear to be any indication that this is the case

If the system hardware hangs and I can think of at least one reason it 
might do exactly that then all bets are off

> For starters, I've gone in and activated Magic SysReq key (just in case),
> spinlock debugging (best guess as to reason of hang), and verbose BUG
> reporting (for luck!).
> 
> Any other suggestions, or recommendations to get more info?

Three starting points

1.  Run memtest86 on the box for a bit. I don't think its bad RAM however
2.  Plug in a PS/2 mouse if the box doesn't have one already. That avoids
a hardware flaw on the AMD that we don't current work around in software
3.  Check if 2.4.20 behaves the same way. I think it may fix your short
pauses but I don't think its going to fix the hang alas. It would be
useful to know however


