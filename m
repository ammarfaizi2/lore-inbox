Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266038AbTBPHHJ>; Sun, 16 Feb 2003 02:07:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266064AbTBPHHI>; Sun, 16 Feb 2003 02:07:08 -0500
Received: from smtp.actcom.co.il ([192.114.47.13]:8660 "EHLO
	lmail.actcom.co.il") by vger.kernel.org with ESMTP
	id <S266038AbTBPHHI>; Sun, 16 Feb 2003 02:07:08 -0500
Date: Sun, 16 Feb 2003 09:16:59 +0200
From: Muli Ben-Yehuda <mulix@mulix.org>
To: Robert Love <rml@tech9.net>
Cc: lkml <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] make jiffies wrap 5 min after boot
Message-ID: <20030216071659.GB6417@actcom.co.il>
References: <Pine.LNX.4.33L2.0302040935230.6174-100000@dragon.pdx.osdl.net> <Pine.LNX.4.33.0302160232120.7975-100000@gans.physik3.uni-rostock.de> <20030216020808.GF9833@krispykreme> <20030216024317.GM29983@holomorphy.com> <1045377459.2175.0.camel@phantasy>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1045377459.2175.0.camel@phantasy>
User-Agent: Mutt/1.5.3i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Feb 16, 2003 at 01:37:40AM -0500, Robert Love wrote:
> On Sat, 2003-02-15 at 21:43, William Lee Irwin III wrote:
> 
> > Can I get a vote for ~0UL instead of -1UL?
> 
> OK, I bite.  What is the difference?  Aren't both equivalent?

I have no idea if that's what wli meant, but -1UL is only "all ones"
in a 2's complement binary representation. 
-- 
Muli Ben-Yehuda
http://www.mulix.org
http://syscalltrack.sf.net

