Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261499AbTCGLZL>; Fri, 7 Mar 2003 06:25:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261520AbTCGLZL>; Fri, 7 Mar 2003 06:25:11 -0500
Received: from pc2-cwma1-4-cust86.swan.cable.ntl.com ([213.105.254.86]:17577
	"EHLO irongate.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S261499AbTCGLZK>; Fri, 7 Mar 2003 06:25:10 -0500
Subject: Re: [PATCH] move SWAP option in menu
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Gabriel Paubert <paubert@iram.es>
Cc: Tom Rini <trini@kernel.crashing.org>, "Randy.Dunlap" <rddunlap@osdl.org>,
       randy.dunlap@verizon.net,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <20030307100330.GA4758@iram.es>
References: <3E657EBD.59E167D6@verizon.net> <20030305181748.GA11729@iram.es>
	 <20030305131444.1b9b0cf2.rddunlap@osdl.org>
	 <20030306184332.GA23580@ip68-0-152-218.tc.ph.cox.net>
	 <20030306193344.GA29166@iram.es>
	 <1046984808.18158.115.camel@irongate.swansea.linux.org.uk>
	 <20030307100330.GA4758@iram.es>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Organization: 
Message-Id: <1047040872.20794.7.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.1 (1.2.1-4) 
Date: 07 Mar 2003 12:41:12 +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2003-03-07 at 10:03, Gabriel Paubert wrote:
> > Linux 8086 can swap because it can use CS/DS updates to relocate code/data.
> 
> Unless I miss a subtle trick, that's using the segment registers as a
> poor man's MMU. You can share library code with far calls but you can't 
> use "far" data pointers, can you?

Linux 8086 doesnt support "far" anything. The segment registers are
being used as base registers, and on 8086 "limit" isnt available.

