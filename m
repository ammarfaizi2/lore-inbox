Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261640AbSKTVgk>; Wed, 20 Nov 2002 16:36:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261642AbSKTVgk>; Wed, 20 Nov 2002 16:36:40 -0500
Received: from noodles.codemonkey.org.uk ([213.152.47.19]:55433 "EHLO
	noodles.internal") by vger.kernel.org with ESMTP id <S261640AbSKTVgi>;
	Wed, 20 Nov 2002 16:36:38 -0500
Date: Wed, 20 Nov 2002 21:41:04 +0000
From: Dave Jones <davej@codemonkey.org.uk>
To: Stephan von Krawczynski <skraw@ithnet.com>
Cc: gallir@uib.es, linux-kernel@vger.kernel.org, marcelo@conectiva.com.br
Subject: Re: PATCH: Recognize Tualatin cache size in 2.4.x
Message-ID: <20021120214104.GA21030@suse.de>
Mail-Followup-To: Dave Jones <davej@codemonkey.org.uk>,
	Stephan von Krawczynski <skraw@ithnet.com>, gallir@uib.es,
	linux-kernel@vger.kernel.org, marcelo@conectiva.com.br
References: <200211171549.gAHFnSrE021923@mnm.uib.es> <20021118190200.GA20936@suse.de> <200211182154.52081.gallir@uib.es> <20021119120834.GA32004@suse.de> <20021120210357.70464ff2.skraw@ithnet.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20021120210357.70464ff2.skraw@ithnet.com>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 20, 2002 at 09:03:57PM +0100, Stephan von Krawczynski wrote:
 > On Tue, 19 Nov 2002 12:08:34 +0000
 > Dave Jones <davej@codemonkey.org.uk> wrote:
 > 
 > > On Mon, Nov 18, 2002 at 09:54:52PM +0100, Ricardo Galli wrote:
 > > 
 > >  > It's very cosmetic but very annoying for P3 > 1GHz, where Linux <= 2.4.20-preX 
 > >  > only reports 32 KB of cache and it also seems to ignore the "cachesize" 
 > >  > parameter. Perhaps it really uses 256KB, but not sure.
 > > 
 > > There was a bug related to that parameter, I'm sure if the fix
 > > went into the same patch, or a separate one. I'll check later.
 > 
 > Sorry for this possibly dumb comment/question:
 > my Tualatins have 512KB cache on die. Are we all sure that it's used?
 > /proc says indeed 32KB on 2.4.20-rc2

Odd. If you can send me the output of dmesg, /proc/cpuinfo
and x86info -a, I'll take a look.
(You can find x86info at
 http://www.codemonkey.org.uk/x86info/x86info-1.11.tar.gz)

		Dave

-- 
| Dave Jones.        http://www.codemonkey.org.uk
