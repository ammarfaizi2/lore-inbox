Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262019AbUL1Cjj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262019AbUL1Cjj (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 27 Dec 2004 21:39:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262020AbUL1Cji
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 27 Dec 2004 21:39:38 -0500
Received: from fmr15.intel.com ([192.55.52.69]:64473 "EHLO
	fmsfmr005.fm.intel.com") by vger.kernel.org with ESMTP
	id S262019AbUL1Cjh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 27 Dec 2004 21:39:37 -0500
Subject: Re: 2.6.{9,10}: C3 not working once USB driver gets loaded
	(ThinkPad T40p)
From: Len Brown <len.brown@intel.com>
To: Tomas Szepe <szepe@pinerecords.com>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20041226205053.GA27671@louise.pinerecords.com>
References: <20041226205053.GA27671@louise.pinerecords.com>
Content-Type: text/plain
Organization: 
Message-Id: <1104201565.18173.36.camel@d845pe>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.3 
Date: 27 Dec 2004 21:39:25 -0500
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2004-12-26 at 15:50, Tomas Szepe wrote:
> Hi,
> 
> In recent kernels (tried 2.6.9, 2.6.10), after I load the uhci_hcd
> module, the processor never goes to state C3.  Unloading the module
> again puts things back to normal.  The system is an IBM ThinkPad T40p.
> 
> Is the USB driver setting some kinda flag in the ACPI subsystem to
> achieve this behavior intentionally or is this a bug?

It is not a Linux bug -- it is a system hardware architecture flaw.

There is a workaround for this issue called
USB Selective Suspend, which you can google and
read all about.  Hopefully we'll have this workaround
available on Linux systems before too long.

cheers,
-Len



