Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262589AbTJTOXv (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Oct 2003 10:23:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262591AbTJTOXv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Oct 2003 10:23:51 -0400
Received: from citrine.spiritone.com ([216.99.193.133]:29391 "EHLO
	citrine.spiritone.com") by vger.kernel.org with ESMTP
	id S262589AbTJTOXu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Oct 2003 10:23:50 -0400
Date: Mon, 20 Oct 2003 07:23:44 -0700
From: "Martin J. Bligh" <mbligh@aracnet.com>
To: James Courtier-Dutton <James@superbug.demon.co.uk>,
       linux-kernel@vger.kernel.org
Subject: Re: IRQ Routing.
Message-ID: <763050000.1066659824@[10.10.2.4]>
In-Reply-To: <3F9396C7.50807@superbug.demon.co.uk>
References: <3F9396C7.50807@superbug.demon.co.uk>
X-Mailer: Mulberry/2.2.1 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Are their any linux tools to allow the user to view irq routing details, 
> and maybe change the routing after boot ?
> 
> This might be useful in special cases.

Yeah, "cat /proc/interrupts" and 
"echo <cpu_bitmask> > /proc/irq/<number>/smp_affinity"

M.

