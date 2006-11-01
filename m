Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1752557AbWKAXbt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752557AbWKAXbt (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Nov 2006 18:31:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752568AbWKAXbt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Nov 2006 18:31:49 -0500
Received: from smtp.osdl.org ([65.172.181.4]:13275 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1752557AbWKAXbt (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Nov 2006 18:31:49 -0500
Date: Wed, 1 Nov 2006 15:31:02 -0800
From: Andrew Morton <akpm@osdl.org>
To: Rusty Russell <rusty@rustcorp.com.au>
Cc: Andi Kleen <ak@muc.de>, Andi Kleen <ak@suse.de>,
       virtualization@lists.osdl.org, Chris Wright <chrisw@sous-sol.org>,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH 6/7] paravirtualization: Add APIC accessors to
 paravirt-ops.
Message-Id: <20061101153102.a192f6c9.akpm@osdl.org>
In-Reply-To: <1162377150.23462.16.camel@localhost.localdomain>
References: <20061029024504.760769000@sous-sol.org>
	<20061029024607.401333000@sous-sol.org>
	<200610290831.21062.ak@suse.de>
	<1162178936.9802.34.camel@localhost.localdomain>
	<20061030231132.GA98768@muc.de>
	<1162376827.23462.5.camel@localhost.localdomain>
	<1162376894.23462.7.camel@localhost.localdomain>
	<1162376981.23462.10.camel@localhost.localdomain>
	<1162377043.23462.12.camel@localhost.localdomain>
	<1162377093.23462.14.camel@localhost.localdomain>
	<1162377150.23462.16.camel@localhost.localdomain>
X-Mailer: Sylpheed version 2.2.7 (GTK+ 2.8.6; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 01 Nov 2006 21:32:30 +1100
Rusty Russell <rusty@rustcorp.com.au> wrote:

> +static __inline void apic_write(unsigned long reg, unsigned long v)
> +static __inline void apic_write_atomic(unsigned long reg, unsigned long v)
> +static __inline unsigned long apic_read(unsigned long reg)

Just `inline', please.
