Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261260AbTILUA6 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 12 Sep 2003 16:00:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261823AbTILUA5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 12 Sep 2003 16:00:57 -0400
Received: from hermes.fachschaften.tu-muenchen.de ([129.187.202.12]:63999 "HELO
	hermes.fachschaften.tu-muenchen.de") by vger.kernel.org with SMTP
	id S261260AbTILUAb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 12 Sep 2003 16:00:31 -0400
Date: Fri, 12 Sep 2003 22:00:23 +0200
From: Adrian Bunk <bunk@fs.tum.de>
To: Andi Kleen <ak@suse.de>
Cc: Martin Schlemmer <azarah@gentoo.org>, jgarzik@pobox.com,
       ebiederm@xmission.com, akpm@osdl.org, richard.brunner@amd.com,
       linux-kernel@vger.kernel.org, torvalds@osdl.org
Subject: Re: [PATCH] 2.6 workaround for Athlon/Opteron prefetch errata
Message-ID: <20030912200022.GO27368@fs.tum.de>
References: <3F60837D.7000209@pobox.com> <20030911162634.64438c7d.ak@suse.de> <3F6087FC.7090508@pobox.com> <m1vfrxlxol.fsf@ebiederm.dsl.xmission.com> <20030912195606.24e73086.ak@suse.de> <3F62098F.9030300@pobox.com> <20030912182216.GK27368@fs.tum.de> <20030912202851.3529e7e7.ak@suse.de> <1063393505.3371.207.camel@workshop.saharacpt.lan> <20030912213016.47a4e5de.ak@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030912213016.47a4e5de.ak@suse.de>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 12, 2003 at 09:30:16PM +0200, Andi Kleen wrote:
>...
> I think it's useful to keep kernels booting everywhere, it makes it a lot easier
> to test a single kernel on multiple systems.

Different people have different needs:

Sometimes you want kernels booting everywhere, e.g. a distribution might
want to support all CPUs from an 386 to an Opteron with one kernel for
their boot floppies.

For a system administrator with only Pentium 3 and Pentum 4 machines
support for 386 and Opteron isn't of much worth.

In some embedded systems people are happy about every kB their kernel is 
smaller.

> -Andi

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

