Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264047AbTKDKWd (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 4 Nov 2003 05:22:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264048AbTKDKWd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 4 Nov 2003 05:22:33 -0500
Received: from ppp-217-133-42-200.cust-adsl.tiscali.it ([217.133.42.200]:34432
	"EHLO x30.random") by vger.kernel.org with ESMTP id S264047AbTKDKWc
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 4 Nov 2003 05:22:32 -0500
Date: Tue, 4 Nov 2003 11:22:20 +0100
From: Andrea Arcangeli <andrea@suse.de>
To: Zwane Mwaikambo <zwane@arm.linux.org.uk>
Cc: Jan Dittmer <j.dittmer@portrix.net>, linux-kernel@vger.kernel.org
Subject: Re: Clock skips (?) with 2.6 and games
Message-ID: <20031104102219.GA2984@x30.random>
References: <3FA62DD4.1020202@portrix.net> <20031103110129.GF1772@x30.random> <3FA63A57.8070606@portrix.net> <20031103143656.GA6785@x30.random> <3FA677D7.1000100@portrix.net> <Pine.LNX.4.53.0311032139450.20595@montezuma.fsmlabs.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.53.0311032139450.20595@montezuma.fsmlabs.com>
User-Agent: Mutt/1.4i
X-GPG-Key: 1024D/68B9CB43 13D9 8355 295F 4823 7C49  C012 DFA1 686E 68B9 CB43
X-PGP-Key: 1024R/CB4660B9 CC A0 71 81 F4 A0 63 AC  C0 4B 81 1D 8C 15 C8 E5
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 03, 2003 at 09:40:28PM -0500, Zwane Mwaikambo wrote:
> On Mon, 3 Nov 2003, Jan Dittmer wrote:
> 
> > Strange, if I enable Highmem support and set CONFIG_NR_CPUS from 4 to 8,
> > 4 penguins are showing up...
> 
> It should do it with the NR_CPUS change only, sounds like yet another APIC 
> ID SMP bootstrap problem.

yes, and now with NR_CPUS == 8 Jan can compare apples to apples. So I
would suggest you to repeat the interactivity test, first w/o desktop
then w/ desktop. My tree has a o1 scheduler, though quite different
from any other version (especially for HT machines).
