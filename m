Return-Path: <linux-kernel-owner+willy=40w.ods.org-S270054AbUJTJBl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270054AbUJTJBl (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 20 Oct 2004 05:01:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270181AbUJTIV1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 20 Oct 2004 04:21:27 -0400
Received: from fmr10.intel.com ([192.55.52.30]:10403 "EHLO
	fmsfmr003.fm.intel.com") by vger.kernel.org with ESMTP
	id S270035AbUJTHyB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 20 Oct 2004 03:54:01 -0400
Subject: Re: [PATCH] boot parameters: quoting of
	environmentvariablesrevisited
From: Len Brown <len.brown@intel.com>
To: Rusty Russell <rusty@rustcorp.com.au>
Cc: Werner Almesberger <werner@almesberger.net>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>
In-Reply-To: <1098257731.10571.138.camel@localhost.localdomain>
References: <1098253261.10571.129.camel@localhost.localdomain>
	 <1098256561.26603.4289.camel@d845pe>
	 <1098257731.10571.138.camel@localhost.localdomain>
Content-Type: text/plain
Organization: 
Message-Id: <1098258821.26595.4324.camel@d845pe>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.3 
Date: 20 Oct 2004 03:53:42 -0400
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2004-10-20 at 03:35, Rusty Russell wrote:
> On Wed, 2004-10-20 at 17:16, Len Brown wrote:
> > I verified that this new patch doesn't break the
> acpi_os_string="Brand X" kernel parameter.
> 
> I can't find where acpi_os_string is handled: grepping the latest
> kernel gives nothing, but I'd expect the quotes to be stripped.

s/acpi_os_string/acpi_os_name

go to bed len...


