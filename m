Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750884AbWAJHDd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750884AbWAJHDd (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 10 Jan 2006 02:03:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750896AbWAJHDd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 10 Jan 2006 02:03:33 -0500
Received: from gate.crashing.org ([63.228.1.57]:38327 "EHLO gate.crashing.org")
	by vger.kernel.org with ESMTP id S1750867AbWAJHDd (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 10 Jan 2006 02:03:33 -0500
Subject: Re: [PATCH 12/24] pcspkr: register with driver core as a platfrom
	device
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Dmitry Torokhov <dtor_core@ameritech.net>
Cc: Linus Torvalds <torvalds@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>, Vojtech Pavlik <vojtech@suse.cz>,
       mikey@neuling.org
In-Reply-To: <200601100148.38228.dtor_core@ameritech.net>
References: <20060107171559.593824000.dtor_core@ameritech.net>
	 <20060107172100.901011000.dtor_core@ameritech.net>
	 <1136875317.10235.4.camel@localhost.localdomain>
	 <200601100148.38228.dtor_core@ameritech.net>
Content-Type: text/plain
Date: Tue, 10 Jan 2006 18:04:13 +1100
Message-Id: <1136876653.10235.7.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> Having platform code instantiate platform devices would be great but I
> wonder how it will look like on x86 where we don't have a way to enumerate
> devices. ACPI might do it but I am not sure if all DSDTs describe beepers...

I don't know the gory details about x86 so I'll let others decide what
to do there... can't it start by instanciating it unconditionally +/-
maybe a kernel command line to "skip" it in case the hw is really not
legacy ?

Ben.


