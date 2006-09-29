Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161292AbWI2Q5v@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161292AbWI2Q5v (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 29 Sep 2006 12:57:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161295AbWI2Q5v
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 29 Sep 2006 12:57:51 -0400
Received: from atlrel7.hp.com ([156.153.255.213]:9879 "EHLO atlrel7.hp.com")
	by vger.kernel.org with ESMTP id S1161292AbWI2Q5u (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 29 Sep 2006 12:57:50 -0400
From: Bjorn Helgaas <bjorn.helgaas@hp.com>
To: Keith Owens <kaos@sgi.com>
Subject: Re: KDB blindly reads keyboard port
Date: Fri, 29 Sep 2006 10:57:41 -0600
User-Agent: KMail/1.9.1
Cc: linux-kernel@vger.kernel.org, linux-ia64@vger.kernel.org
References: <14425.1159496284@kao2.melbourne.sgi.com>
In-Reply-To: <14425.1159496284@kao2.melbourne.sgi.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200609291057.41529.bjorn.helgaas@hp.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 28 September 2006 20:18, Keith Owens wrote:
> I have never been a big fan of ACPI, having seen too many broken ACPI
> tables.  But if that is what you want ...

There's always broken firmware, but I think on the whole, it's better
than just assuming that tomorrow's system will be the same as yesterday's.
I think a big reason for broken tables is the fact that ignore many of
them, so the breakage is never discovered.

> Bjorn, could you apply my previous patch anyway, boot your problem
> system with kdb_skip_keyboard, drop into KDB and
> 'md4c1 acpi_kbd_controller_present'.  That will quickly confirm if acpi
> is detecting the absence of the keyboard on your system.

My system says:

  acpi_parse_fadt: acpi_kbd_controller_present 0
