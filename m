Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263726AbSJGWpl>; Mon, 7 Oct 2002 18:45:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263727AbSJGWpl>; Mon, 7 Oct 2002 18:45:41 -0400
Received: from fusion.wineasy.se ([195.42.198.105]:56837 "HELO
	fusion.wineasy.se") by vger.kernel.org with SMTP id <S263726AbSJGWpk>;
	Mon, 7 Oct 2002 18:45:40 -0400
Date: Tue, 8 Oct 2002 00:51:16 +0200
From: Andreas Schuldei <andreas@schuldei.org>
Cc: Keith Owens <kaos@sgi.com>, linux-kernel@vger.kernel.org
Subject: Re: kdb against memory corruption?
Message-ID: <20021007225116.GF1102@lukas>
References: <20021006200801.GD1316@lukas> <10888.1033981406@kao2.melbourne.sgi.com> <20021007171140.GD1102@lukas>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20021007171140.GD1102@lukas>
User-Agent: Mutt/1.4i
To: unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* Andreas Schuldei (andreas@schuldei.org) [021007 19:11]:
> an other idea (by erikm) was that virutal and physical address
> mode is mixed up. how do i find out which one is used by kdb and the
> debug interface of the cpu? do i need to convert, somehow?

yet another possibility is that a 3Dnow function is used for
memset. Would that be caught?

i tried compiling the kernel for i386, but it still did not work
(to be droped into kdb when the memory gets currupted).
