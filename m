Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264646AbSLBQyW>; Mon, 2 Dec 2002 11:54:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264647AbSLBQyW>; Mon, 2 Dec 2002 11:54:22 -0500
Received: from harpo.it.uu.se ([130.238.12.34]:38848 "EHLO harpo.it.uu.se")
	by vger.kernel.org with ESMTP id <S264646AbSLBQyV>;
	Mon, 2 Dec 2002 11:54:21 -0500
From: Mikael Pettersson <mikpe@csd.uu.se>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <15851.37371.861619.967258@harpo.it.uu.se>
Date: Mon, 2 Dec 2002 18:01:47 +0100
To: Jakub Jelinek <jakub@redhat.com>
Cc: Andi Kleen <ak@suse.de>, "David S. Miller" <davem@redhat.com>,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Start of compat32.h (again)
In-Reply-To: <20021202043645.Q27455@devserv.devel.redhat.com>
References: <Pine.LNX.4.44.0212011047440.12964-100000@home.transmeta.com.suse.lists.linux.kernel>
	<1038804400.4411.4.camel@rth.ninka.net.suse.lists.linux.kernel>
	<p737kesu9bt.fsf@oldwotan.suse.de>
	<20021202.002815.58826951.davem@redhat.com>
	<20021202090756.GA26034@wotan.suse.de>
	<20021202043645.Q27455@devserv.devel.redhat.com>
X-Mailer: VM 6.90 under Emacs 20.7.1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jakub Jelinek writes:
 > The fastest model on x86-64 would IMHO be a 32-bit model using all
 > registers, rip relative addressing and register passing conventions
 > (ie. a 3rd ABI).

When not doing Linux hacks I work on compilers and runtime systems,
and I agree that a model with x86_64 native mode enabled (and thus
the extra registers and addressing modes) but still in a 32-bit
address space looks like a very interesting option for those
applications that don't need tons of address space.

/Mikael
