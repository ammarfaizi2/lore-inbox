Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262756AbUFFBwM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262756AbUFFBwM (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 5 Jun 2004 21:52:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262730AbUFFBwM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 5 Jun 2004 21:52:12 -0400
Received: from gate.crashing.org ([63.228.1.57]:63722 "EHLO gate.crashing.org")
	by vger.kernel.org with ESMTP id S262756AbUFFBwK (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 5 Jun 2004 21:52:10 -0400
Subject: Re: [BUG] asm-ppc/pgtable.h breakage from 2.6.7-rc1-bk4
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Mikael Pettersson <mikpe@csd.uu.se>
Cc: Linux Kernel list <linux-kernel@vger.kernel.org>,
       linuxppc-dev list <linuxppc-dev@lists.linuxppc.org>,
       Paul Mackerras <paulus@samba.org>
In-Reply-To: <200406060139.i561dNDR018329@harpo.it.uu.se>
References: <200406060139.i561dNDR018329@harpo.it.uu.se>
Content-Type: text/plain
Message-Id: <1086486640.12665.50.camel@gaston>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Sat, 05 Jun 2004 20:50:41 -0500
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> That (see below) also works and allows 2.6.7-rc2 to
> boot on my PM4400.

Ok, that's not normal though, as we are only relaxing permissions,
so we must be missing something in the DSI handler or such. Can you
try to look at what the CPU is doing when hitting that loop ? It must
be taking the same exception over and over again...

Ben.


