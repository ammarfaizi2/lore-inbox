Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965060AbVITWPI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965060AbVITWPI (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 20 Sep 2005 18:15:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965165AbVITWPI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 20 Sep 2005 18:15:08 -0400
Received: from pimout3-ext.prodigy.net ([207.115.63.102]:13527 "EHLO
	pimout3-ext.prodigy.net") by vger.kernel.org with ESMTP
	id S965167AbVITWPG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 20 Sep 2005 18:15:06 -0400
X-ORBL: [67.124.117.85]
Date: Tue, 20 Sep 2005 12:44:46 -0700
From: Chris Wedgwood <cw@f00f.org>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Charles McCreary <mccreary@crmeng.com>, linux-kernel@vger.kernel.org
Subject: Re: x86-64 bad pmds in 2.6.11.6
Message-ID: <20050920194446.GA15606@taniwha.stupidest.org>
References: <200509201212.55676.mccreary@crmeng.com> <Pine.LNX.4.58.0509201028050.2553@g5.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.58.0509201028050.2553@g5.osdl.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 20, 2005 at 10:30:48AM -0700, Linus Torvalds wrote:

> This is quite possibly the result of an Opteron errata (tlb flush
> filtering is broken on SMP) that we worked around as of 2.6.14-rc4.

It would be really interesting to know if this does help.  I was told
em64t also have the 'bad pmd' problem but I can't make it happen here
on opteron on em64t.
