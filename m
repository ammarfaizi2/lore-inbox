Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266828AbUAXBBk (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 23 Jan 2004 20:01:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266819AbUAXBBj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 23 Jan 2004 20:01:39 -0500
Received: from gate.crashing.org ([63.228.1.57]:11996 "EHLO gate.crashing.org")
	by vger.kernel.org with ESMTP id S266847AbUAXA7I (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 23 Jan 2004 19:59:08 -0500
Subject: Re: [PATCH] Big powermac update
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Tom Rini <trini@kernel.crashing.org>
Cc: Andrew Morton <akpm@osdl.org>,
       Linux Kernel list <linux-kernel@vger.kernel.org>
In-Reply-To: <20040123175443.GA15271@stop.crashing.org>
References: <1074825487.976.183.camel@gaston>
	 <20040123175443.GA15271@stop.crashing.org>
Content-Type: text/plain
Message-Id: <1074905912.834.43.camel@gaston>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 
Date: Sat, 24 Jan 2004 11:58:33 +1100
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> 
> Can you please put the 970 register definitions into
> include/asm-ppc/reg_970.h or something along those lines?

I won't create a file for 3 registers :) Also, HID2/3 are defined
on other CPUs, as HIOR, none of these are strictly 970 specific
in fact though we only use them on it (coment may need fixing, bu
that's ok at this point).

Ben.


