Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270652AbTG0Cli (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 26 Jul 2003 22:41:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270654AbTG0Cli
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 26 Jul 2003 22:41:38 -0400
Received: from louise.pinerecords.com ([213.168.176.16]:59356 "EHLO
	louise.pinerecords.com") by vger.kernel.org with ESMTP
	id S270652AbTG0Clh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 26 Jul 2003 22:41:37 -0400
Date: Sun, 27 Jul 2003 04:56:47 +0200
From: Tomas Szepe <szepe@pinerecords.com>
To: "Randy.Dunlap" <rddunlap@osdl.org>
Cc: torvalds@osdl.org, linux-kernel@vger.kernel.org
Subject: Re: [TRIVIAL] sanitize power management config menus
Message-ID: <20030727025647.GB17724@louise.pinerecords.com>
References: <20030726200213.GD16160@louise.pinerecords.com> <20030726194651.5e3f00bb.rddunlap@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030726194651.5e3f00bb.rddunlap@osdl.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> [rddunlap@osdl.org]
> 
> 1.  However, both old and new versions say:
>   Power management options (ACPI, APM)  --->
> but have Software Suspend and CPU Frequency (hidden) below there,
> so one has to know to look there for them, while the heading
> only says APCI and APM.  I guess that the heading is too restrictive.

Yes, you're right, let's just kill the parentheses.

> 2.  APM and ACPI aren't usable together, right?  so should the
> Kconfig file prevent both of them from being enabled?

I'm not quite sure about this, though I believe that
ACPI at least in the CPU-enum-only configuration makes
sense even with APM enabled.

> 3.  The help text for Software Suspend (not part of this patch)
> really needs some help.  Would you address that or shall I?

Sure, it would be nice if you could fish out an entry from somewhere.

-- 
Tomas Szepe <szepe@pinerecords.com>
