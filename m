Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264382AbTLERtA (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 5 Dec 2003 12:49:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264384AbTLERtA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 5 Dec 2003 12:49:00 -0500
Received: from holomorphy.com ([199.26.172.102]:57043 "EHLO holomorphy")
	by vger.kernel.org with ESMTP id S264382AbTLERs6 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 5 Dec 2003 12:48:58 -0500
Date: Fri, 5 Dec 2003 09:48:50 -0800
From: William Lee Irwin III <wli@holomorphy.com>
To: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
Cc: Ethan Weinstein <lists@stinkfoot.org>, linux-kernel@vger.kernel.org
Subject: Re: HT apparently not detected properly on 2.4.23
Message-ID: <20031205174850.GE8039@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	Marcelo Tosatti <marcelo.tosatti@cyclades.com>,
	Ethan Weinstein <lists@stinkfoot.org>, linux-kernel@vger.kernel.org
References: <20031203235837.GW8039@holomorphy.com> <Pine.LNX.4.44.0312051511440.5412-100000@logos.cnet>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44.0312051511440.5412-100000@logos.cnet>
Organization: The Domain of Holomorphy
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 05, 2003 at 03:12:14PM -0200, Marcelo Tosatti wrote:
> I think I will just remove CONFIG_NR_CPUS instead... it seems to bring 
> more trouble than advantages. 

I've gotten a success report from this patch (forwarded separately),
but that's okay.

To handle sparse physical APIC ID's within 2.4 limitations without
this patch, NR_CPUS == BITS_PER_LONG whenever CONFIG_SMP=y is an
effective requirement.


-- wli
