Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266199AbSLCJYW>; Tue, 3 Dec 2002 04:24:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266200AbSLCJYV>; Tue, 3 Dec 2002 04:24:21 -0500
Received: from node-d-1ea6.a2000.nl ([62.195.30.166]:18670 "EHLO
	localhost.localdomain") by vger.kernel.org with ESMTP
	id <S266199AbSLCJYS>; Tue, 3 Dec 2002 04:24:18 -0500
Subject: Re: [BK PATCH] ACPI updates
From: Arjan van de Ven <arjanv@redhat.com>
To: marcelo@conectiva.com.br
Cc: linux-kernel@vger.kernel.org, "Grover, Andrew" <andrew.grover@intel.com>
In-Reply-To: <EDC461A30AC4D511ADE10002A5072CAD04C7A560@orsmsx119.jf.intel.com>
References: <EDC461A30AC4D511ADE10002A5072CAD04C7A560@orsmsx119.jf.intel.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-10) 
Date: 03 Dec 2002 10:31:31 +0100
Message-Id: <1038907891.10619.5.camel@localhost.localdomain>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2002-12-02 at 20:29, Grover, Andrew wrote:

>  arch/i386/kernel/acpitable.c            |  554 ----
>  arch/i386/kernel/acpitable.h            |  260 --

Marcelo,

Please don't merge this. This patch removes existing, small, working,
maintained functionality from the kernel and "replaces" it with
something else for which patches aren't even accepted and that is a lot
bigger and less readable code.

Not only is it rude on the side of the ACPI people to remove "competing"
functionality, but it will break all kinds of existing setups that now
have to change the way they configure their system. In addition it's not
even needed, the existing code can live together with the code Andrew
proposes just fine as the United Linux kernel proves.

Greetings,
    Arjan van de Ven


