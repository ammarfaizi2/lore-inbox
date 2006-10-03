Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965171AbWJCErV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965171AbWJCErV (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 3 Oct 2006 00:47:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965191AbWJCErV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 3 Oct 2006 00:47:21 -0400
Received: from smtp.osdl.org ([65.172.181.4]:9951 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S965171AbWJCErU (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 3 Oct 2006 00:47:20 -0400
Date: Mon, 2 Oct 2006 21:44:00 -0700
From: Andrew Morton <akpm@osdl.org>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Judith Lebzelter <judith@osdl.org>, linuxppc-dev@ozlabs.org,
       Linux Kernel list <linux-kernel@vger.kernel.org>,
       Adrian Bunk <bunk@stusta.de>
Subject: Re: [2.6 patch] mark virt_to_bus/bus_to_virt as __deprecated on
 i386
Message-Id: <20061002214400.0a83b743.akpm@osdl.org>
In-Reply-To: <1159850245.5482.32.camel@localhost.localdomain>
References: <20061002214954.GD665@shell0.pdx.osdl.net>
	<20061002234428.GE3278@stusta.de>
	<20061003012241.GF3278@stusta.de>
	<1159850245.5482.32.camel@localhost.localdomain>
X-Mailer: Sylpheed version 2.2.7 (GTK+ 2.8.17; x86_64-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 03 Oct 2006 14:37:25 +1000
Benjamin Herrenschmidt <benh@kernel.crashing.org> wrote:

> > > You might want to convince Andrew accepting my patch to make 
> > > virt_to_bus/bus_to_virt give compile warnings on i386 for making
> > > people more aware of this problem...
> > >...
> 
> Andrew, is there any reason not to take that patch ?

It generates lots of warnings from drivers which nobody does any work on.

Net result: lots of new warnings, no fixed bugs.
