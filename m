Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751014AbWAFBXA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751014AbWAFBXA (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 5 Jan 2006 20:23:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751013AbWAFBXA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 5 Jan 2006 20:23:00 -0500
Received: from gaz.sfgoth.com ([69.36.241.230]:39365 "EHLO gaz.sfgoth.com")
	by vger.kernel.org with ESMTP id S1750716AbWAFBW7 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 5 Jan 2006 20:22:59 -0500
Date: Thu, 5 Jan 2006 17:22:54 -0800
From: Mitchell Blank Jr <mitch@sfgoth.com>
To: Ingo Molnar <mingo@elte.hu>
Cc: Linus Torvalds <torvalds@osdl.org>, Martin Bligh <mbligh@mbligh.org>,
       Matt Mackall <mpm@selenic.com>, Arjan van de Ven <arjan@infradead.org>,
       Chuck Ebbert <76306.1226@compuserve.com>, Adrian Bunk <bunk@stusta.de>,
       Andrew Morton <akpm@osdl.org>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       Dave Jones <davej@redhat.com>,
       Tim Schmielau <tim@physik3.uni-rostock.de>
Subject: Re: [patch 00/2] improve .text size on gcc 4.0 and newer  compilers
Message-ID: <20060106012254.GD84622@gaz.sfgoth.com>
References: <1136463553.2920.22.camel@laptopd505.fenrus.org> <20060105170255.GK3356@waste.org> <43BD5E6F.1040000@mbligh.org> <Pine.LNX.4.64.0601051112070.3169@g5.osdl.org> <Pine.LNX.4.64.0601051126570.3169@g5.osdl.org> <43BD784F.4040804@mbligh.org> <Pine.LNX.4.64.0601051208510.3169@g5.osdl.org> <Pine.LNX.4.64.0601051213270.3169@g5.osdl.org> <20060106005004.GC84622@gaz.sfgoth.com> <20060106005839.GA24899@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060106005839.GA24899@elte.hu>
User-Agent: Mutt/1.4.2.1i
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-1.2.2 (gaz.sfgoth.com [127.0.0.1]); Thu, 05 Jan 2006 17:22:59 -0800 (PST)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ingo Molnar wrote:
> a better syntax would be:
> 
> 	if __unlikely (cond) {
> 		...
> 	}

Well you could just throw an extra set of parenthesis around the expansion
of the current "unlikely()" macro and get this effect now.

-Mitch
