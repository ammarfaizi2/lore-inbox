Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264726AbUHGXkw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264726AbUHGXkw (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 7 Aug 2004 19:40:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264750AbUHGXkw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 7 Aug 2004 19:40:52 -0400
Received: from the-village.bc.nu ([81.2.110.252]:43460 "EHLO
	localhost.localdomain") by vger.kernel.org with ESMTP
	id S264726AbUHGXkv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 7 Aug 2004 19:40:51 -0400
Subject: Re: [0/3]kprobes-base-268-rc3.patch
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: prasanna@in.ibm.com
Cc: Andi Kleen <ak@muc.de>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       suparna@in.ibm.com, shemminger@osdl.org, vamsi_krishna@in.ibm.com
In-Reply-To: <20040806163114.GB3732@in.ibm.com>
References: <2pMzT-XA-21@gated-at.bofh.it>
	 <m3hdrhyhuy.fsf@averell.firstfloor.org> <20040806123757.GB3376@in.ibm.com>
	 <20040806151625.GA96991@muc.de>  <20040806163114.GB3732@in.ibm.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Message-Id: <1091918278.19092.40.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2) 
Date: Sat, 07 Aug 2004 23:37:59 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Gwe, 2004-08-06 at 17:31, Prasanna S Panchamukhi wrote:
> > Is it good enough for kprobes?
> > 
> 
> Its good enough for Kprobes. Also kprobes needs int3 handler to be an 
> interrupt gate, as of now its system gate. Please see my next mail for updated 
> kprobes patch.

It also looks just right for a patch-free loadable gdbstubs module which
will end years of wrangling with Linus over debugger hooks ;)

Alan

