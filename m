Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261704AbVEJQjS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261704AbVEJQjS (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 10 May 2005 12:39:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261707AbVEJQjS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 10 May 2005 12:39:18 -0400
Received: from mx1.redhat.com ([66.187.233.31]:147 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S261696AbVEJQjG (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 10 May 2005 12:39:06 -0400
Date: Tue, 10 May 2005 12:38:51 -0400
From: Dave Jones <davej@redhat.com>
To: Christopher Warner <chris@servertogo.com>
Cc: Andi Kleen <ak@suse.de>, Hugh Dickins <hugh@veritas.com>,
       cwarner@kernelcode.com, Chris Wright <chrisw@osdl.org>,
       "Sergey S. Kostyliov" <rathamahata@ehouse.ru>,
       Clem Taylor <clem.taylor@gmail.com>, linux-kernel@vger.kernel.org
Subject: Re: x86-64 bad pmds in 2.6.11.6 II
Message-ID: <20050510163851.GA1128@redhat.com>
Mail-Followup-To: Dave Jones <davej@redhat.com>,
	Christopher Warner <chris@servertogo.com>, Andi Kleen <ak@suse.de>,
	Hugh Dickins <hugh@veritas.com>, cwarner@kernelcode.com,
	Chris Wright <chrisw@osdl.org>,
	"Sergey S. Kostyliov" <rathamahata@ehouse.ru>,
	Clem Taylor <clem.taylor@gmail.com>, linux-kernel@vger.kernel.org
References: <20050415172408.GB8511@wotan.suse.de> <20050415172816.GU493@shell0.pdx.osdl.net> <Pine.LNX.4.61.0504151833020.29919@goblin.wat.veritas.com> <20050419133509.GF7715@wotan.suse.de> <Pine.LNX.4.61.0504191636570.13422@goblin.wat.veritas.com> <1114773179.9543.14.camel@jasmine> <20050429173216.GB1832@redhat.com> <20050502170042.GJ7342@wotan.suse.de> <1115047729.19314.1.camel@jasmine> <1115717814.7679.2.camel@jasmine>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1115717814.7679.2.camel@jasmine>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 10, 2005 at 05:36:54AM -0400, Christopher Warner wrote:
 > 2.6.11.5 kernel,
 > Tyan S2882/dual AMD 246 opterons
 > sh:18983: mm/memory.c:99: bad pmd ffff810005974cc8(00007ffffffffe46). 
 > sh:18983: mm/memory.c:99: bad pmd ffff810005974cd0(00007ffffffffe47).

That's the 3rd or 4th time I've seen this reported on this hardware.
It's not exclusive to it, but it does seem more susceptible
for some reason. Spooky.

		Dave

