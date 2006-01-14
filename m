Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751749AbWANKnV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751749AbWANKnV (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 14 Jan 2006 05:43:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751747AbWANKnU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 14 Jan 2006 05:43:20 -0500
Received: from cpc4-cmbg4-4-0-cust18.cmbg.cable.ntl.com ([81.108.205.18]:43536
	"EHLO thekelleys.org.uk") by vger.kernel.org with ESMTP
	id S1751227AbWANKnT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 14 Jan 2006 05:43:19 -0500
Message-ID: <43C8D685.70805@thekelleys.org.uk>
Date: Sat, 14 Jan 2006 10:46:29 +0000
From: Simon Kelley <simon@thekelleys.org.uk>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-GB; rv:1.7.12) Gecko/20051007 Debian/1.7.12-1
X-Accept-Language: en
MIME-Version: 1.0
To: Chase Venters <chase.venters@clientec.com>
CC: netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
       Jiri Benc <jbenc@suse.cz>, Stefan Rompf <stefan@loplof.de>,
       Mike Kershaw <dragorn@kismetwireless.net>,
       Krzysztof Halasa <khc@pm.waw.pl>, Robert Hancock <hancockr@shaw.ca>,
       Alistair John Strachan <s0348365@sms.ed.ac.uk>,
       Dominik Brodowski <linux@dominikbrodowski.net>,
       Denis Vlasenko <vda@ilport.com.ua>,
       Danny van Dyk <kugelfang@gentoo.org>,
       Stephen Hemminger <shemminger@osdl.org>, feyd <feyd@nmskb.cz>,
       Andreas Mohr <andim2@users.sourceforge.net>,
       Bas Vermeulen <bvermeul@blackstar.nl>, Jean Tourrilhes <jt@hpl.hp.com>,
       Daniel Drake <dsd@gentoo.org>, Ulrich Kunitz <kune@deine-taler.de>,
       Phil Dibowitz <phil@ipom.com>, Michael Buesch <mbuesch@freenet.de>,
       Marcel Holtmann <marcel@holtmann.org>,
       Patrick McHardy <kaber@trash.net>, Ingo Oeser <netdev@axxeo.de>,
       Harald Welte <laforge@gnumonks.org>,
       Ben Greear <greearb@candelatech.com>, Thomas Graf <tgraf@suug.ch>
Subject: Re: wireless: recap of current issues (stack)
References: <20060113195723.GB16166@tuxdriver.com> <20060113212605.GD16166@tuxdriver.com> <20060113213200.GG16166@tuxdriver.com> <200601131703.29677.chase.venters@clientec.com>
In-Reply-To: <200601131703.29677.chase.venters@clientec.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Chase Venters wrote:

> As an aside to this whole thing, I know we're talking about *kernel* wireless 
> but it's worthless to most people without good userland support as well. 
> Anyone have any thoughts and feelings on what things look like on the 
> desktop? I think if we work closely with some desktop people, we can shepard 
> in some wonderful new desktop support on top of the new netlink API.
> 

An obvious place to start is the NetworkManager project. They should be 
asked the obvious "what do you need" and "does this provide it" 
questions. Dan Williams has been active recently producing small kernel 
patches which make the kernel side stuff work better with NM, so he 
might be a good contact to start with.

Cheers,

Simon.
