Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261862AbTJMQFt (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Oct 2003 12:05:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261863AbTJMQFt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Oct 2003 12:05:49 -0400
Received: from fed1mtao06.cox.net ([68.6.19.125]:27031 "EHLO
	fed1mtao06.cox.net") by vger.kernel.org with ESMTP id S261862AbTJMQFs
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Oct 2003 12:05:48 -0400
Date: Mon, 13 Oct 2003 09:05:46 -0700
From: Tom Rini <trini@kernel.crashing.org>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
       Mikael Pettersson <mikpe@csd.uu.se>,
       Linux Kernel list <linux-kernel@vger.kernel.org>,
       linuxppc-dev list <linuxppc-dev@lists.linuxppc.org>,
       Sam Ravnborg <sam@ravnborg.org>
Subject: Re: non-modular 2.6 ppc kernels miscompiled by gcc-3.3.1?
Message-ID: <20031013160546.GH3634@ip68-0-152-218.tc.ph.cox.net>
References: <200310121310.h9CDASEI006119@harpo.it.uu.se> <1065964761.993.34.camel@gaston> <20031012181950.GB2328@mars.ravnborg.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20031012181950.GB2328@mars.ravnborg.org>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Oct 12, 2003 at 08:19:50PM +0200, Sam Ravnborg wrote:
> 
> On Sun, Oct 12, 2003 at 03:19:22PM +0200, Benjamin Herrenschmidt wrote:
> > Smells like some section alignement issues. Can you check
> > how the __ex_table  section is aligned and where __start___ex_table
> > points to ? (using objdump)
> 
> Or you could try to apply the following patch - it will fix mis-
> alignmnet of above section.

Applied.  Thanks.

-- 
Tom Rini
http://gate.crashing.org/~trini/
