Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315709AbSGNKEz>; Sun, 14 Jul 2002 06:04:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315720AbSGNKEy>; Sun, 14 Jul 2002 06:04:54 -0400
Received: from ns.suse.de ([213.95.15.193]:60945 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id <S315709AbSGNKEy>;
	Sun, 14 Jul 2002 06:04:54 -0400
Date: Sun, 14 Jul 2002 12:07:46 +0200
From: Dave Jones <davej@suse.de>
To: Kai Germaschewski <kai@tp1.ruhr-uni-bochum.de>
Cc: Thunder from the hill <thunder@ngforever.de>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [Q] Objects with EXPORT_NO_SYMBOLS
Message-ID: <20020714120746.D28859@suse.de>
Mail-Followup-To: Dave Jones <davej@suse.de>,
	Kai Germaschewski <kai@tp1.ruhr-uni-bochum.de>,
	Thunder from the hill <thunder@ngforever.de>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <Pine.LNX.4.44.0207131610320.3331-100000@hawkeye.luckynet.adm> <Pine.LNX.4.44.0207131841430.6108-100000@chaos.physics.uiowa.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44.0207131841430.6108-100000@chaos.physics.uiowa.edu>
User-Agent: Mutt/1.3.22.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jul 13, 2002 at 06:44:43PM -0500, Kai Germaschewski wrote:
 > On Sat, 13 Jul 2002, Thunder from the hill wrote:
 > 
 > > Should an object which explicitly defines EXPORT_NO_SYMBOLS be listed in 
 > > export-objs? If not, then I just found some candidates...
 > 
 > In 2.5, there shouldn't be any source which has an "EXPORT_NO_SYMBOLS"  
 > line, if so just delete it.

Unless a driver author is sharing the same source between 2.4/2.5
Adding a (harmless) EXPORT_NO_SYMBOLS to 2.5 source would be preferable
to wrapping it in a kernel version ifdef.

        Dave

-- 
| Dave Jones.        http://www.codemonkey.org.uk
| SuSE Labs
