Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751092AbWCVI2F@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751092AbWCVI2F (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 22 Mar 2006 03:28:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751093AbWCVI2E
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 22 Mar 2006 03:28:04 -0500
Received: from pentafluge.infradead.org ([213.146.154.40]:13442 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S1751092AbWCVI2E (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 22 Mar 2006 03:28:04 -0500
Subject: Re: [RFC PATCH 04/35] Hypervisor interface header files.
From: Arjan van de Ven <arjan@infradead.org>
To: Chris Wright <chrisw@sous-sol.org>
Cc: linux-kernel@vger.kernel.org, xen-devel@lists.xensource.com,
       virtualization@lists.osdl.org, Ian Pratt <ian.pratt@xensource.com>,
       Christian Limpach <Christian.Limpach@cl.cam.ac.uk>
In-Reply-To: <20060322063744.407582000@sorel.sous-sol.org>
References: <20060322063040.960068000@sorel.sous-sol.org>
	 <20060322063744.407582000@sorel.sous-sol.org>
Content-Type: text/plain
Date: Wed, 22 Mar 2006 09:28:00 +0100
Message-Id: <1143016080.2955.7.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <arjan@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2006-03-21 at 22:30 -0800, Chris Wright wrote:
> plain text document attachment (03-i386-hypervisor-interface)
> Define macros and inline functions for doing hypercalls into the
> hypervisor.
> 
> Signed-off-by: Ian Pratt <ian.pratt@xensource.com>
> Signed-off-by: Christian Limpach <Christian.Limpach@cl.cam.ac.uk>
> Signed-off-by: Chris Wright <chrisw@sous-sol.org>
> ---
>  include/asm-i386/hypercall.h  |  306 ++++++++++++++++++++++++++++++++++++++++++
>  include/asm-i386/hypervisor.h |   67 +++++++++
>  2 files changed, 373 insertions(+)
> 
> --- /dev/null
> +++ xen-subarch-2.6/include/asm-i386/hypercall.h
> @@ -0,0 +1,306 @@
> +/******************************************************************************
> + * hypercall.h
> + *
> + * Linux-specific hypervisor handling.
> + *
> + * Copyright (c) 2002-2004, K A Fraser
> + *
> + * This file may be distributed separately from the Linux kernel, or
> + * incorporated into other software packages, subject to the following license:
> + *

and what, if any, is the license when distributed with the kernel, as
you propose? Right now there doesn't seem to be any at all, and thus it
would be undistributable.


