Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261662AbVEJOVU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261662AbVEJOVU (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 10 May 2005 10:21:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261663AbVEJOVU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 10 May 2005 10:21:20 -0400
Received: from mout.perfora.net ([217.160.230.40]:42717 "EHLO mout.perfora.net")
	by vger.kernel.org with ESMTP id S261662AbVEJOVO (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 10 May 2005 10:21:14 -0400
Subject: Re: x86-64 bad pmds in 2.6.11.6 II
From: Christopher Warner <chris@servertogo.com>
To: Andi Kleen <ak@suse.de>
Cc: Dave Jones <davej@redhat.com>, Hugh Dickins <hugh@veritas.com>,
       cwarner@kernelcode.com, Chris Wright <chrisw@osdl.org>,
       "Sergey S. Kostyliov" <rathamahata@ehouse.ru>,
       Clem Taylor <clem.taylor@gmail.com>, linux-kernel@vger.kernel.org
In-Reply-To: <1115047729.19314.1.camel@jasmine>
References: <20050414181015.GH22573@wotan.suse.de>
	 <20050414181133.GA18221@wotan.suse.de>
	 <20050414182712.GG493@shell0.pdx.osdl.net>
	 <20050415172408.GB8511@wotan.suse.de>
	 <20050415172816.GU493@shell0.pdx.osdl.net>
	 <Pine.LNX.4.61.0504151833020.29919@goblin.wat.veritas.com>
	 <20050419133509.GF7715@wotan.suse.de>
	 <Pine.LNX.4.61.0504191636570.13422@goblin.wat.veritas.com>
	 <1114773179.9543.14.camel@jasmine> <20050429173216.GB1832@redhat.com>
	 <20050502170042.GJ7342@wotan.suse.de>  <1115047729.19314.1.camel@jasmine>
Content-Type: text/plain
Date: Tue, 10 May 2005 05:36:54 -0400
Message-Id: <1115717814.7679.2.camel@jasmine>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.1.1 
Content-Transfer-Encoding: 7bit
X-Provags-ID: perfora.net abuse@perfora.net login:d2cbd72fb1ab4860f78cabc62f71ec31
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

2.6.11.5 kernel,
Tyan S2882/dual AMD 246 opterons

sh:18983: mm/memory.c:99: bad pmd ffff810005974cc8(00007ffffffffe46). 
sh:18983: mm/memory.c:99: bad pmd ffff810005974cd0(00007ffffffffe47).
sh:18983: mm/memory.c:99: bad pmd ffff810005974cd8(00007ffffffffe48).
sh:18983: mm/memory.c:99: bad pmd ffff810005974ce0(00007ffffffffe49).
sh:18983: mm/memory.c:99: bad pmd ffff810005974ce8(00007ffffffffe4a).
sh:18983: mm/memory.c:99: bad pmd ffff810005974cf0(00007ffffffffe4b).
sh:18983: mm/memory.c:99: bad pmd ffff810005974cf8(00007ffffffffe4c).
sh:18983: mm/memory.c:99: bad pmd ffff810005974d00(00007ffffffffe4d).
sh:18983: mm/memory.c:99: bad pmd ffff810005974d08(00007ffffffffe4e).
sh:18983: mm/memory.c:99: bad pmd ffff810005974d10(00007ffffffffe4f).
sh:18983: mm/memory.c:99: bad pmd ffff810005974d18(00007ffffffffe50).
sh:18983: mm/memory.c:99: bad pmd ffff810005974d20(00007ffffffffe51).
sh:18983: mm/memory.c:99: bad pmd ffff810005974d30(0000000000000010).
sh:18983: mm/memory.c:99: bad pmd ffff810005974d38(00000000078bfbff).
sh:18983: mm/memory.c:99: bad pmd ffff810005974d40(0000000000000006).
sh:18983: mm/memory.c:99: bad pmd ffff810005974d48(0000000000001000).
sh:18983: mm/memory.c:99: bad pmd ffff810005974d50(0000000000000011).
sh:18983: mm/memory.c:99: bad pmd ffff810005974d58(0000000000000064).
sh:18983: mm/memory.c:99: bad pmd ffff810005974d60(0000000000000003).
sh:18983: mm/memory.c:99: bad pmd ffff810005974d68(0000000000400040).
sh:18983: mm/memory.c:99: bad pmd ffff810005974d70(0000000000000004).
sh:18983: mm/memory.c:99: bad pmd ffff810005974d78(0000000000000038).
sh:18983: mm/memory.c:99: bad pmd ffff810005974d80(0000000000000005).
sh:18983: mm/memory.c:99: bad pmd ffff810005974d88(0000000000000008).
sh:18983: mm/memory.c:99: bad pmd ffff810005974d90(0000000000000007).
sh:18983: mm/memory.c:99: bad pmd ffff810005974d98(00002aaaaaaab000).
sh:18983: mm/memory.c:99: bad pmd ffff810005974da0(0000000000000008).
sh:18983: mm/memory.c:99: bad pmd ffff810005974db0(0000000000000009).
sh:18983: mm/memory.c:99: bad pmd ffff810005974db8(0000000000413a00).
sh:18983: mm/memory.c:99: bad pmd ffff810005974dc0(000000000000000b).
sh:18983: mm/memory.c:99: bad pmd ffff810005974dc8(00000000000007d3).
sh:18983: mm/memory.c:99: bad pmd ffff810005974dd0(000000000000000c).
sh:18983: mm/memory.c:99: bad pmd ffff810005974dd8(00000000000007d3).
sh:18983: mm/memory.c:99: bad pmd ffff810005974de0(000000000000000d).
sh:18983: mm/memory.c:99: bad pmd ffff810005974df0(000000000000000e).
sh:18983: mm/memory.c:99: bad pmd ffff810005974e00(0000000000000017).
sh:18983: mm/memory.c:99: bad pmd ffff810005974e10(000000000000000f).
sh:18983: mm/memory.c:99: bad pmd ffff810005974e18(00007ffffffffe3a).
sh:18983: mm/memory.c:99: bad pmd ffff810005974e38(34365f3638780000)

