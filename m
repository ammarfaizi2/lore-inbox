Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261289AbVGYQLQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261289AbVGYQLQ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 25 Jul 2005 12:11:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261306AbVGYQLQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 25 Jul 2005 12:11:16 -0400
Received: from animx.eu.org ([216.98.75.249]:21472 "EHLO animx.eu.org")
	by vger.kernel.org with ESMTP id S261289AbVGYQLP (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 25 Jul 2005 12:11:15 -0400
Date: Mon, 25 Jul 2005 12:27:13 -0400
From: Wakko Warner <wakko@animx.eu.org>
To: Michael Tokarev <mjt@tls.msk.ru>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Stripping in module
Message-ID: <20050725162713.GA2021@animx.eu.org>
Mail-Followup-To: Michael Tokarev <mjt@tls.msk.ru>,
	linux-kernel@vger.kernel.org
References: <809C13DD6142E74ABE20C65B11A24398020882@www.telos.de> <Pine.LNX.4.61.0507250928300.18209@yvahk01.tjqt.qr> <20050725112622.GA1537@animx.eu.org> <42E4CBAC.6020301@tls.msk.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <42E4CBAC.6020301@tls.msk.ru>
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Michael Tokarev wrote:
> Wakko Warner wrote:
> []
> > I would also be interested in this.  For instance the AIC7xxx driver has
> > every PCI id in the module I think in the .modinfo section which is not
> > truely required once depmod has been run. []
> 
> The .modinfo section, for example the PCI IDs, IS required for the
> module to function properly.  The kernel and the module uses that
> tables to determime which devices to work with, and with which paramteres.

I stripped out the section that had alias= and other vars from aic7xxx and
it still worked.  Not all modules worked doing that.

-- 
 Lab tests show that use of micro$oft causes cancer in lab animals
