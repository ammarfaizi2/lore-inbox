Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261619AbVASIOX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261619AbVASIOX (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 19 Jan 2005 03:14:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261645AbVASINw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 19 Jan 2005 03:13:52 -0500
Received: from baythorne.infradead.org ([81.187.226.107]:9889 "EHLO
	baythorne.infradead.org") by vger.kernel.org with ESMTP
	id S261619AbVASHoJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 19 Jan 2005 02:44:09 -0500
Subject: Re: [PATCH] raid6: altivec support
From: David Woodhouse <dwmw2@infradead.org>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Olaf Hering <olh@suse.de>, linuxppc-dev list <linuxppc-dev@ozlabs.org>,
       Linus Torvalds <torvalds@osdl.org>,
       Linux Kernel list <linux-kernel@vger.kernel.org>,
       "H. Peter Anvin" <hpa@zytor.com>
In-Reply-To: <1106107876.4534.163.camel@gaston>
References: <200501082324.j08NOIva030415@hera.kernel.org>
	 <20050109151353.GA9508@suse.de>
	 <1105956993.26551.327.camel@hades.cambridge.redhat.com>
	 <1106107876.4534.163.camel@gaston>
Content-Type: text/plain
Date: Wed, 19 Jan 2005 07:43:42 +0000
Message-Id: <1106120622.10851.42.camel@baythorne.infradead.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.2 (2.0.2-3.dwmw2.1) 
Content-Transfer-Encoding: 7bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <dwmw2@infradead.org> by baythorne.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2005-01-19 at 15:11 +1100, Benjamin Herrenschmidt wrote:
> We should probably "backport" that simplification to ppc32...

Yeah.... I'm increasingly tempted to merge ppc32/ppc64 into one arch
like mips/parisc/s390. Or would that get vetoed on the basis that we
don't have all that horrid non-OF platform support in ppc64 yet, and
we're still kidding ourselves that all those embedded vendors will
either not notice ppc64 or will use OF?

-- 
dwmw2


