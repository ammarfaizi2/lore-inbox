Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264436AbTFEDBP (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 4 Jun 2003 23:01:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264437AbTFEDBP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 4 Jun 2003 23:01:15 -0400
Received: from modemcable204.207-203-24.mtl.mc.videotron.ca ([24.203.207.204]:43138
	"EHLO montezuma.mastecende.com") by vger.kernel.org with ESMTP
	id S264436AbTFEDBO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 4 Jun 2003 23:01:14 -0400
Date: Wed, 4 Jun 2003 23:04:00 -0400 (EDT)
From: Zwane Mwaikambo <zwane@linuxpower.ca>
X-X-Sender: zwane@montezuma.mastecende.com
To: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
cc: "Brian J. Murrell" <brian@interlinx.bc.ca>,
       Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: local apic timer ints not working with vmware: nolocalapic
In-Reply-To: <Pine.GSO.3.96.1030603133821.29576A-100000@delta.ds2.pg.gda.pl>
Message-ID: <Pine.LNX.4.50.0306030827550.14455-100000@montezuma.mastecende.com>
References: <Pine.GSO.3.96.1030603133821.29576A-100000@delta.ds2.pg.gda.pl>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 3 Jun 2003, Maciej W. Rozycki wrote:

> On Sat, 31 May 2003, Zwane Mwaikambo wrote:
>  How about clearing cpu_has_apic and smp_found_config instead?  As I
> understand the problem, the local APIC is useless so the kernel shouldn't
> pretend it's present.  And the MP-table is useless without a local APIC. 

I agree, but there are already the appropriate checks for wether there is 
an APIC enabled that should suffice.

	Zwane
-- 
function.linuxpower.ca
