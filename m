Return-Path: <linux-kernel-owner+willy=40w.ods.org-S270118AbUJTHmT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270118AbUJTHmT (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 20 Oct 2004 03:42:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269883AbUJTHiM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 20 Oct 2004 03:38:12 -0400
Received: from ozlabs.org ([203.10.76.45]:34737 "EHLO ozlabs.org")
	by vger.kernel.org with ESMTP id S269046AbUJTHfr (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 20 Oct 2004 03:35:47 -0400
Subject: Re: [PATCH] boot parameters: quoting of environment
	variablesrevisited
From: Rusty Russell <rusty@rustcorp.com.au>
To: Len Brown <len.brown@intel.com>
Cc: Werner Almesberger <werner@almesberger.net>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>
In-Reply-To: <1098256561.26603.4289.camel@d845pe>
References: <1098253261.10571.129.camel@localhost.localdomain>
	 <1098256561.26603.4289.camel@d845pe>
Content-Type: text/plain
Message-Id: <1098257731.10571.138.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Wed, 20 Oct 2004 17:35:45 +1000
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2004-10-20 at 17:16, Len Brown wrote:
> I verified that this new patch doesn't break the acpi_os_string="Brand
> X" kernel parameter.

I can't find where acpi_os_string is handled: grepping the latest kernel
gives nothing, but I'd expect the quotes to be stripped.

> I'm not sure what quoted parameters for init's environment are used for,
> but it looks like FOO="FOO BAR" now results in
> FOO=FOO BAR
> in the environment.

Yes, as did Werner's patch.  I don't know if this is right, but it seems
sensible.

Rusty.
-- 
Anyone who quotes me in their signature is an idiot -- Rusty Russell

