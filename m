Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932493AbVJCSPR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932493AbVJCSPR (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 3 Oct 2005 14:15:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932494AbVJCSPQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 3 Oct 2005 14:15:16 -0400
Received: from fmr24.intel.com ([143.183.121.16]:58332 "EHLO
	scsfmr004.sc.intel.com") by vger.kernel.org with ESMTP
	id S932493AbVJCSPO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 3 Oct 2005 14:15:14 -0400
Date: Mon, 3 Oct 2005 11:14:41 -0700
From: Rajesh Shah <rajesh.shah@intel.com>
To: Rajat Jain <rajat.noida.india@gmail.com>
Cc: acpi-devel@lists.sourceforge.net, pcihpd-discuss@lists.sourceforge.net,
       linux-kernel@vger.kernel.org, dkumar@noida.hcltech.com,
       sanjayku@noida.hcltech.com
Subject: Re: [Pcihpd-discuss] Re: ACPI problem with PCI Express Native Hot-plug driver
Message-ID: <20051003111441.C14857@unix-os.sc.intel.com>
Reply-To: Rajesh Shah <rajesh.shah@intel.com>
References: <b115cb5f0509020057741365dc@mail.gmail.com> <b115cb5f050902005877607db1@mail.gmail.com> <1125683188.13185.5.camel@whizzy> <b115cb5f05090418583abfc73@mail.gmail.com> <b115cb5f0509292257j395d60f8j53d1afa967caa263@mail.gmail.com> <20050930132440.C28328@unix-os.sc.intel.com> <b115cb5f0510022207k41df0380nfb8b4ee73149f7ea@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <b115cb5f0510022207k41df0380nfb8b4ee73149f7ea@mail.gmail.com>; from rajat.noida.india@gmail.com on Mon, Oct 03, 2005 at 02:07:26PM +0900
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 03, 2005 at 02:07:26PM +0900, Rajat Jain wrote:

> Thanks for the insight. But my doubt is that the PCI Express devices
> down the hot-pluggable slots are working fine. i.e. if we forget about
> the hot-plugging / unplugging, the bridges and devices are working
> fine, even with ACPI enabled.
> 
> So is the presence of bridges in ACPI namespace required only for
> hot-plugging / unplugging and not for normal operation?
> 
Yes, that's correct. The PCI core will correctly scan PCI bridges
independent of their presence in the acpi namespace.

PS: trimming the cc list a bit, as I'm getting rejects due to
too many recipients. pcihp-discuss is the correct list for pciehp
related questions.

Rajesh
