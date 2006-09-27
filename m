Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030199AbWI0L5L@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030199AbWI0L5L (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 27 Sep 2006 07:57:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030200AbWI0L5K
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 27 Sep 2006 07:57:10 -0400
Received: from palinux.external.hp.com ([192.25.206.14]:65412 "EHLO
	mail.parisc-linux.org") by vger.kernel.org with ESMTP
	id S1030199AbWI0L5I (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 27 Sep 2006 07:57:08 -0400
Date: Wed, 27 Sep 2006 05:57:08 -0600
From: Matthew Wilcox <matthew@wil.cx>
To: Keith Owens <kaos@sgi.com>
Cc: Bjorn Helgaas <bjorn.helgaas@hp.com>, linux-kernel@vger.kernel.org,
       linux-ia64@vger.kernel.org
Subject: Re: KDB blindly reads keyboard port
Message-ID: <20060927115707.GQ5017@parisc-linux.org>
References: <200609261354.30722.bjorn.helgaas@hp.com> <5239.1159325150@kao2.melbourne.sgi.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5239.1159325150@kao2.melbourne.sgi.com>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 27, 2006 at 12:45:50PM +1000, Keith Owens wrote:
> No support for legacy I/O ports could be a bigger problem than just
> KDB.  To fix just KDB, apply this patch over kdb-v4.4-2.6.18-common-1 and add
> 'kdb_skip_keyboard' to the boot command line on the offending hardware.

Why can't you use acpi_kbd_controller_present instead of introducing a
new option?
