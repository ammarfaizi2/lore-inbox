Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263776AbTLUReY (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 21 Dec 2003 12:34:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263832AbTLUReY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 21 Dec 2003 12:34:24 -0500
Received: from scrub.xs4all.nl ([194.109.195.176]:14863 "EHLO scrub.xs4all.nl")
	by vger.kernel.org with ESMTP id S263776AbTLUReX (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 21 Dec 2003 12:34:23 -0500
Date: Sun, 21 Dec 2003 18:34:17 +0100 (CET)
From: Roman Zippel <zippel@linux-m68k.org>
X-X-Sender: roman@serv
To: Marcel Holtmann <marcel@holtmann.org>
cc: Randy Dunlap <rddunlap@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Difference between select and enable in Kconfig
In-Reply-To: <1072027326.2684.72.camel@pegasus>
Message-ID: <Pine.LNX.4.58.0312211830260.27544@serv>
References: <1071974814.2684.41.camel@pegasus>  <20031220205433.195037e8.rddunlap@osdl.org>
 <1072027326.2684.72.camel@pegasus>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Sun, 21 Dec 2003, Marcel Holtmann wrote:

> > 			case P_SELECT:
> > 				sym2 = prop_get_symbol(prop);
> > 				if ((sym->type != S_BOOLEAN && sym->type != S_TRISTATE) ||
> > 				    (sym2->type != S_BOOLEAN && sym2->type != S_TRISTATE))
> > 					fprintf(stderr, "%s:%d:warning: enable is only allowed with boolean and tristate symbols\n",
> > 					                                ~~~~~~
>
> so both options achieve the same result. Why do we have two different
> options for the same stuff? Should we not remove one?

It was called first 'enable' and later renamed into 'select', which is now
the official version, so 'enable' could be indeed removed.

bye, Roman
