Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264586AbTLEW4N (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 5 Dec 2003 17:56:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264592AbTLEW4N
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 5 Dec 2003 17:56:13 -0500
Received: from mtaw4.prodigy.net ([64.164.98.52]:31161 "EHLO mtaw4.prodigy.net")
	by vger.kernel.org with ESMTP id S264586AbTLEW4K (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 5 Dec 2003 17:56:10 -0500
Date: Fri, 5 Dec 2003 14:55:54 -0800
From: Mike Fedyk <mfedyk@matchmail.com>
To: Allen Martin <AMartin@nvidia.com>
Cc: "'Mikael Pettersson'" <mikpe@csd.uu.se>,
       Josh McKinney <forming@charter.net>, linux-kernel@vger.kernel.org
Subject: Re: Catching NForce2 lockup with NMI watchdog
Message-ID: <20031205225554.GT29119@mis-mike-wstn.matchmail.com>
Mail-Followup-To: Allen Martin <AMartin@nvidia.com>,
	'Mikael Pettersson' <mikpe@csd.uu.se>,
	Josh McKinney <forming@charter.net>, linux-kernel@vger.kernel.org
References: <DCB9B7AA2CAB7F418919D7B59EE45BAF49F877@mail-sc-6.nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <DCB9B7AA2CAB7F418919D7B59EE45BAF49F877@mail-sc-6.nvidia.com>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 05, 2003 at 11:11:39AM -0800, Allen Martin wrote:
> NVIDIA doesn't provide a windows driver to setup APIC interrupts.  APIC
> functionality is exported through the ACPI methods and MP table in the
> system BIOS which the motherboard vendors supply.
> 
> Likely the root of the problem has to do with the way the Linux kernel is
> using the ACPI methods to setup the interrupts which is different from win
> 9x/2k/XP.  I can help track this down, unfortunately so far I've been unable
> to reproduce the hangs on any of the boards I have.

Can the people with nforce chips run a command that will show the chipset
config space like was done back when there were problems with via chipsets
(before via released the specs on how to set the bits correctly).

Maybe you'll see some correlation between the boards that are crashing, and
a few bits that are different for the boards that aren't crashing.
