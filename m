Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261746AbVA3Rjf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261746AbVA3Rjf (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 30 Jan 2005 12:39:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261747AbVA3Rjf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 30 Jan 2005 12:39:35 -0500
Received: from pentafluge.infradead.org ([213.146.154.40]:39577 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S261746AbVA3Rjd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 30 Jan 2005 12:39:33 -0500
Date: Sun, 30 Jan 2005 17:39:29 +0000
From: Christoph Hellwig <hch@infradead.org>
To: Len Brown <len.brown@intel.com>
Cc: Adrian Bunk <bunk@stusta.de>,
       Alexey Y Starikovskiy <alexey.y.starikovskiy@intel.com>,
       Robert Moore <robert.moore@intel.com>, linux-kernel@vger.kernel.org,
       ACPI Developers <acpi-devel@lists.sourceforge.net>
Subject: Re: [RFC: 2.6 patch] drivers/acpi/: possible cleanups
Message-ID: <20050130173929.GA32014@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Len Brown <len.brown@intel.com>, Adrian Bunk <bunk@stusta.de>,
	Alexey Y Starikovskiy <alexey.y.starikovskiy@intel.com>,
	Robert Moore <robert.moore@intel.com>, linux-kernel@vger.kernel.org,
	ACPI Developers <acpi-devel@lists.sourceforge.net>
References: <20050127110125.GE28047@stusta.de> <1106867060.2400.2297.camel@d845pe>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1106867060.2400.2297.camel@d845pe>
User-Agent: Mutt/1.4.1i
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 27, 2005 at 06:04:20PM -0500, Len Brown wrote:
> I've already asked Bob Moore to migrate to the use of static in the
> interpreter.  There are some somewhat urgent functional issues he needs
> to focus on first, but static is on the list.  If we allow him to do it
> upstream (w/o looking at your patch), then we can avoid a fork in the
> core interpreter code.
> 
> At the same time, the non "R. Byron Moore" files, such as those in
> drivers/acpi, but not in the lower sub-directories, are straight GPL and
> I'll be happy to accept patches to those files immediately.  Note that
> there are 4 straight GPL files in include/acpi as well -- so like the
> drivers/acpi/* files, we can modify them any time when cleanups are
> appropriate in the Linux release cycle.

The files are licensed under a BSD license so all patches against it
are aswell unless explicitly marked.

