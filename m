Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261783AbTEQTWh (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 17 May 2003 15:22:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261786AbTEQTWg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 17 May 2003 15:22:36 -0400
Received: from modemcable204.207-203-24.mtl.mc.videotron.ca ([24.203.207.204]:39808
	"EHLO montezuma.mastecende.com") by vger.kernel.org with ESMTP
	id S261783AbTEQTWg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 17 May 2003 15:22:36 -0400
Date: Sat, 17 May 2003 15:25:46 -0400 (EDT)
From: Zwane Mwaikambo <zwane@linuxpower.ca>
X-X-Sender: zwane@montezuma.mastecende.com
To: Felipe Alfaro Solana <felipe_alfaro@linuxmail.org>
cc: Andrew Morton <akpm@digeo.com>, Patrick Mochel <mochel@osdl.org>,
       LKML <linux-kernel@vger.kernel.org>
Subject: Re: 2.5.69-mm5: reverting i8259-shutdown.patch
In-Reply-To: <1053000426.605.4.camel@teapot.felipe-alfaro.com>
Message-ID: <Pine.LNX.4.50.0305171107090.2356-100000@montezuma.mastecende.com>
References: <20030514193300.58645206.akpm@digeo.com> 
 <Pine.LNX.4.44.0305141935440.9816-100000@cherise>  <20030514231414.42398dda.akpm@digeo.com>
 <1053000426.605.4.camel@teapot.felipe-alfaro.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 15 May 2003, Felipe Alfaro Solana wrote:

> > In this case we need to understand why the lockup is happening - what
> > code is requiring 8259 services after the thing has been turned off?
> > Could be that the bug lies there.
> > 
> > Felipe, please send your .config.   (again - in fact you may as well do
> > cp .config ~/.signature)
> 
> Config attached...
> Don't understand what do you mean with "cp .config ~/.signature" :-?
> 

Unable to reproduce, appears to be machine specific, 1 laptop and 2 test 
systems both managed to power off with APM or ACPI. Also tried with 
Felipe's config

	Zwane
-- 
function.linuxpower.ca
