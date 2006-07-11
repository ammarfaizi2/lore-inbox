Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750896AbWGKJw7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750896AbWGKJw7 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 11 Jul 2006 05:52:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750893AbWGKJw7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 11 Jul 2006 05:52:59 -0400
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:2442 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP
	id S1750888AbWGKJw6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 11 Jul 2006 05:52:58 -0400
Subject: Re: [PATCH] ia64: change usermode HZ to 250
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: David Mosberger-Tang <David.Mosberger@acm.org>
Cc: Jeremy Higdon <jeremy@sgi.com>, Arjan van de Ven <arjan@infradead.org>,
       Jes Sorensen <jes@sgi.com>, "Luck, Tony" <tony.luck@intel.com>,
       John Daiker <jdaiker@osdl.org>, John Hawkes <hawkes@sgi.com>,
       Tony Luck <tony.luck@gmail.com>, Andrew Morton <akpm@osdl.org>,
       linux-ia64@vger.kernel.org, linux-kernel@vger.kernel.org,
       Jack Steiner <steiner@sgi.com>, Dan Higgins <djh@sgi.com>
In-Reply-To: <ed5aea430607102001g514bfa97jf82c25a038e9c436@mail.gmail.com>
References: <617E1C2C70743745A92448908E030B2A27FC5F@scsmsx411.amr.corp.intel.com>
	 <yq04py4i9p7.fsf@jaguar.mkp.net>
	 <1151578928.23785.0.camel@localhost.localdomain> <44A3AFFB.2000203@sgi.com>
	 <1151578513.3122.22.camel@laptopd505.fenrus.org>
	 <20060708001427.GA723842@sgi.com>
	 <1152340963.3120.0.camel@laptopd505.fenrus.org>
	 <ed5aea430607080607u67aeb05di963243c0e653e4f0@mail.gmail.com>
	 <20060710202228.GA732959@sgi.com>
	 <ed5aea430607102001g514bfa97jf82c25a038e9c436@mail.gmail.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Tue, 11 Jul 2006 11:10:14 +0100
Message-Id: <1152612614.18028.1.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.2 (2.6.2-1.fc5.5) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ar Llu, 2006-07-10 am 21:01 -0600, ysgrifennodd David Mosberger-Tang:
> Note that Alan didn't claim that *all* (Linux-supported) architectures
> expose a constant user HZ, only the "mainstream" ones.  I won't get

Indeed. IA64 likes to be different

> into the debate as to what qualifies as "mainstream", but clearly IA64
> does not (and should not) expose a constant value, since there were no
> legacy-binary-issue and we chose to insist that apps should uses
> sysconf() or equivalent if they need to know the clocktick.

In the case where you are running x86 binaries where you do need to
translate of course.

Alan

