Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264735AbTFAVfO (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 1 Jun 2003 17:35:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264736AbTFAVfO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 1 Jun 2003 17:35:14 -0400
Received: from modemcable204.207-203-24.mtl.mc.videotron.ca ([24.203.207.204]:17538
	"EHLO montezuma.mastecende.com") by vger.kernel.org with ESMTP
	id S264735AbTFAVfN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 1 Jun 2003 17:35:13 -0400
Date: Sun, 1 Jun 2003 17:38:02 -0400 (EDT)
From: Zwane Mwaikambo <zwane@linuxpower.ca>
X-X-Sender: zwane@montezuma.mastecende.com
To: "Justin T. Gibbs" <gibbs@scsiguy.com>
cc: Willy Tarreau <willy@w.ods.org>,
       Daniel Podlejski <underley@underley.eu.org>,
       "" <linux-kernel@vger.kernel.org>
Subject: Re: AIC7xxx problem
In-Reply-To: <2878250000.1054503467@aslan.scsiguy.com>
Message-ID: <Pine.LNX.4.50.0306011730540.19313-100000@montezuma.mastecende.com>
References: <20030531165945.GA5561@witch.underley.eu.org>
 <20030601083656.GI21673@alpha.home.local> <2859720000.1054499680@aslan.scsiguy.com>
 <Pine.LNX.4.50.0306011647431.19313-100000@montezuma.mastecende.com>
 <2878250000.1054503467@aslan.scsiguy.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 1 Jun 2003, Justin T. Gibbs wrote:

> Daniel is comparing 2.4.20-ac2 with 2.4.21-rc6.  In 2.4.20-ac2, APIC
> routing is disabled by default and his kernel works.  In 2.4.21-rc6,
> APIC routing is enabled by default and interrupts are not properly
> routed to his SCSI controller.  If he boots with noapic, everything
> works fine.  You'll have to ask Daniel for more details on his system
> if you want to figure out why interrupts are not being delivered.
> All I know is, from the output and his testing, it is pretty obvious
> that interrupts are not being delivered.

Ok i'll ask him about the details, but i've posted on a number of 
occasions about aic7xxx oopsing unless i boot with noapic. Interrupts do 
get delivered otherwise it wouldn't even get to mounting root. I can't 
give you a 2.5.70 boot because raid is horked there too. If you want me to 
fish out the emails again i can do that.

	Zwane

-- 
function.linuxpower.ca
