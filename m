Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269967AbUJTIYw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269967AbUJTIYw (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 20 Oct 2004 04:24:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269671AbUJTIXT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 20 Oct 2004 04:23:19 -0400
Received: from ozlabs.org ([203.10.76.45]:16051 "EHLO ozlabs.org")
	by vger.kernel.org with ESMTP id S270151AbUJTIDN (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 20 Oct 2004 04:03:13 -0400
Subject: Re: [PATCH] boot parameters: quoting of
	environmentvariablesrevisited
From: Rusty Russell <rusty@rustcorp.com.au>
To: Len Brown <len.brown@intel.com>
Cc: Werner Almesberger <werner@almesberger.net>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>
In-Reply-To: <1098258821.26595.4324.camel@d845pe>
References: <1098253261.10571.129.camel@localhost.localdomain>
	 <1098256561.26603.4289.camel@d845pe>
	 <1098257731.10571.138.camel@localhost.localdomain>
	 <1098258821.26595.4324.camel@d845pe>
Content-Type: text/plain
Message-Id: <1098259389.10571.149.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Wed, 20 Oct 2004 18:03:10 +1000
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2004-10-20 at 17:53, Len Brown wrote:
> On Wed, 2004-10-20 at 03:35, Rusty Russell wrote:
> > On Wed, 2004-10-20 at 17:16, Len Brown wrote:
> > > I verified that this new patch doesn't break the
> > acpi_os_string="Brand X" kernel parameter.
> > 
> > I can't find where acpi_os_string is handled: grepping the latest
> > kernel gives nothing, but I'd expect the quotes to be stripped.
> 
> s/acpi_os_string/acpi_os_name

Ah, looks like that code strips the " anyway, so the fact that we're now
doing it just means it can be simplified.

Cheers!
Rusty.
-- 
Anyone who quotes me in their signature is an idiot -- Rusty Russell

