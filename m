Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264610AbTCEVFr>; Wed, 5 Mar 2003 16:05:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264705AbTCEVFq>; Wed, 5 Mar 2003 16:05:46 -0500
Received: from air-2.osdl.org ([65.172.181.6]:18401 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id <S264610AbTCEVFp>;
	Wed, 5 Mar 2003 16:05:45 -0500
Date: Wed, 5 Mar 2003 13:14:44 -0800
From: "Randy.Dunlap" <rddunlap@osdl.org>
To: Gabriel Paubert <paubert@iram.es>
Cc: randy.dunlap@verizon.net, linux-kernel@vger.kernel.org,
       torvalds@transmeta.com
Subject: Re: [PATCH] move SWAP option in menu
Message-Id: <20030305131444.1b9b0cf2.rddunlap@osdl.org>
In-Reply-To: <20030305181748.GA11729@iram.es>
References: <3E657EBD.59E167D6@verizon.net>
	<20030305181748.GA11729@iram.es>
Organization: OSDL
X-Mailer: Sylpheed version 0.8.6 (GTK+ 1.2.10; i586-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 5 Mar 2003 19:17:48 +0100 Gabriel Paubert <paubert@iram.es> wrote:

| On Tue, Mar 04, 2003 at 08:36:13PM -0800, Randy.Dunlap wrote:
| > Hi,
| > 
| > Please apply this patch (option B of 2 choices) from
| > Tomas Szepe to move the SWAP option into the General Setup
| > menu.
| > 
| > Patch is to 2.5.64.
| > 
[snip]
| 
| Why restrict it to Intel only? I don't know if it works properly on
| other architectures, but at least it would give people the opportunity 
| to test it on embedded PPC/Arm/MIPS/CRIS/whatever.
| 
| >From a quick grep over a recent BK tree, the only files who have 
| sections conditional on CONFIG_SWAP are:
| 
| include/linux/page-flags.h
| include/linux/swap.h
| mm/vmscan.c
| mm/Makefile
| 
| no architecture specific code at all. From a quick look, the
| conditionals are rather simple (most of them are replacements of
| actual functions by dummies) and should work on all architectures.
| Please let people test it on non-X86, after all it's still a 
| development kernel. Any breakage is unlikely to be serious and 
| embedded people are going to be the most interested since it 
| saves some space.

OK, please send a patch.

--
~Randy
