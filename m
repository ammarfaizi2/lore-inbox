Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261777AbVFVXlP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261777AbVFVXlP (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 22 Jun 2005 19:41:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261839AbVFVXiO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 22 Jun 2005 19:38:14 -0400
Received: from fmr22.intel.com ([143.183.121.14]:16302 "EHLO
	scsfmr002.sc.intel.com") by vger.kernel.org with ESMTP
	id S262594AbVFVXem (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 22 Jun 2005 19:34:42 -0400
Date: Wed, 22 Jun 2005 16:34:28 -0700
From: Rajesh Shah <rajesh.shah@intel.com>
To: Brice Goglin <Brice.Goglin@ens-lyon.org>
Cc: Dominik Brodowski <linux@dominikbrodowski.net>,
       Andrew Morton <akpm@osdl.org>,
       Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: 2.6.12-mm1
Message-ID: <20050622163427.A10079@unix-os.sc.intel.com>
Reply-To: Rajesh Shah <rajesh.shah@intel.com>
References: <20050619233029.45dd66b8.akpm@osdl.org> <42B6746B.4020305@ens-lyon.org> <20050620081443.GA31831@isilmar.linta.de> <42B6831B.3040506@ens-lyon.org> <20050620085449.GA32330@isilmar.linta.de> <42B6C06F.4000704@ens-lyon.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <42B6C06F.4000704@ens-lyon.org>; from Brice.Goglin@ens-lyon.org on Mon, Jun 20, 2005 at 03:11:11PM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 20, 2005 at 03:11:11PM +0200, Brice Goglin wrote:
> Dominik Brodowski a écrit :
> > Did you modify the .config in between?
> 
> I just checked carrefully which versions do work.
> It seems that this breakage appeared in rc6-mm1 with the same
> config than a working rc5-mm2.

Can you revert gregkh-pci-pci-collect-host-bridge-resources-02.patch
from the broken-out patches for 2.6.12-mm1 and see if the problem
goes away? If yes, it could be that the ACPI firmware on this
system is not reporting proper host bridge resources, and all
downstream device resources get messed up..

Rajesh




