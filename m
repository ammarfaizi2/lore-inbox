Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261697AbUJYJCO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261697AbUJYJCO (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 25 Oct 2004 05:02:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261705AbUJYJCO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 25 Oct 2004 05:02:14 -0400
Received: from ee.oulu.fi ([130.231.61.23]:701 "EHLO ee.oulu.fi")
	by vger.kernel.org with ESMTP id S261697AbUJYJCL (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 25 Oct 2004 05:02:11 -0400
Date: Mon, 25 Oct 2004 12:01:31 +0300
From: Pekka Pietikainen <pp@ee.oulu.fi>
To: "Yu, Luming" <luming.yu@intel.com>
Cc: Xavier Bestel <xavier.bestel@free.fr>, Onur Kucuk <onur@delipenguen.net>,
       Olivier Galibert <galibert@pobox.com>, linux-kernel@vger.kernel.org
Subject: Re: Buggy DSDTs policy ?
Message-ID: <20041025090131.GA3404@ee.oulu.fi>
References: <3ACA40606221794F80A5670F0AF15F84041ABFE0@pdsmsx403>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <3ACA40606221794F80A5670F0AF15F84041ABFE0@pdsmsx403>
User-Agent: Mutt/1.4.2i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 25, 2004 at 02:21:09PM +0800, Yu, Luming wrote:
> >> Yes, sure. But real non-technical people won't replace their DSDT
> >> either.
> >Their distro could do it for them :-) A simple approach would be to
> >store md5sums of known-bad dsdt's and xdeltas to fixed ones, and the 
> >fixed one gets placed in /etc where mkinitrd automagically picks it up
> >whenever a new kernel is installed.
> 
> I don't think distro can do that, because they are not the owner of
> DSDT.
That's what I said xdelta, so the only "new" code is patches against
the broken vendor code in /proc/acpi/dsdt. But it's messy even
that way, I know.

But that's all userspace, the kernel should still make it possible (via
initrd or something else ;) )




