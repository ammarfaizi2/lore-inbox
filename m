Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263601AbTKDClI (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 3 Nov 2003 21:41:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263605AbTKDClI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 3 Nov 2003 21:41:08 -0500
Received: from modemcable137.219-201-24.mc.videotron.ca ([24.201.219.137]:44928
	"EHLO montezuma.fsmlabs.com") by vger.kernel.org with ESMTP
	id S263601AbTKDClH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 3 Nov 2003 21:41:07 -0500
Date: Mon, 3 Nov 2003 21:40:28 -0500 (EST)
From: Zwane Mwaikambo <zwane@arm.linux.org.uk>
To: Jan Dittmer <j.dittmer@portrix.net>
cc: Andrea Arcangeli <andrea@suse.de>, linux-kernel@vger.kernel.org
Subject: Re: Clock skips (?) with 2.6 and games
In-Reply-To: <3FA677D7.1000100@portrix.net>
Message-ID: <Pine.LNX.4.53.0311032139450.20595@montezuma.fsmlabs.com>
References: <3FA62DD4.1020202@portrix.net> <20031103110129.GF1772@x30.random>
 <3FA63A57.8070606@portrix.net> <20031103143656.GA6785@x30.random>
 <3FA677D7.1000100@portrix.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 3 Nov 2003, Jan Dittmer wrote:

> Strange, if I enable Highmem support and set CONFIG_NR_CPUS from 4 to 8,
> 4 penguins are showing up...

It should do it with the NR_CPUS change only, sounds like yet another APIC 
ID SMP bootstrap problem.

