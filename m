Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161140AbWG1MeH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161140AbWG1MeH (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 28 Jul 2006 08:34:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161141AbWG1MeH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 28 Jul 2006 08:34:07 -0400
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:44161 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP
	id S1161140AbWG1MeF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 28 Jul 2006 08:34:05 -0400
Subject: Re: [RFC][PATCH] A generic boolean (version 6)
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Nicholas Miell <nmiell@comcast.net>
Cc: ricknu-0@student.ltu.se, Arnd Bergmann <arnd.bergmann@de.ibm.com>,
       linux-kernel@vger.kernel.org, Andrew Morton <akpm@osdl.org>,
       Jeff Garzik <jeff@garzik.org>, Alexey Dobriyan <adobriyan@gmail.com>,
       Vadim Lobanov <vlobanov@speakeasy.net>,
       Jan Engelhardt <jengelh@linux01.gwdg.de>,
       Shorty Porty <getshorty_@hotmail.com>,
       Peter Williams <pwil3058@bigpond.net.au>, Michael Buesch <mb@bu3sch.de>,
       Pekka Enberg <penberg@cs.helsinki.fi>,
       Stefan Richter <stefanr@s5r6.in-berlin.de>, larsbj@gullik.net,
       Paul Jackson <pj@sgi.com>
In-Reply-To: <1154031240.2535.1.camel@entropy>
References: <1153341500.44be983ca1407@portal.student.luth.se>
	 <1153945705.44c7d069c5e18@portal.student.luth.se>
	 <200607270448.03257.arnd.bergmann@de.ibm.com>
	 <1153978047.2807.5.camel@entropy>
	 <1154030149.44c91a453d6b0@portal.student.luth.se>
	 <1154031240.2535.1.camel@entropy>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Fri, 28 Jul 2006 13:50:22 +0100
Message-Id: <1154091022.13509.112.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.2 (2.6.2-1.fc5.5) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ar Iau, 2006-07-27 am 13:13 -0700, ysgrifennodd Nicholas Miell:
> The compiler knows that "b = !!b;" is a no-op.

b = !!b isn't a no-op.

Try printf("%d", !!4);

