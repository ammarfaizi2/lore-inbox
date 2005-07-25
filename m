Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261226AbVGYLX3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261226AbVGYLX3 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 25 Jul 2005 07:23:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261230AbVGYLX3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 25 Jul 2005 07:23:29 -0400
Received: from hobbit.corpit.ru ([81.13.94.6]:56664 "EHLO hobbit.corpit.ru")
	by vger.kernel.org with ESMTP id S261226AbVGYLX1 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 25 Jul 2005 07:23:27 -0400
Message-ID: <42E4CBAC.6020301@tls.msk.ru>
Date: Mon, 25 Jul 2005 15:23:24 +0400
From: Michael Tokarev <mjt@tls.msk.ru>
User-Agent: Debian Thunderbird 1.0.2 (X11/20050331)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Wakko Warner <wakko@animx.eu.org>
CC: Jan Engelhardt <jengelh@linux01.gwdg.de>, linux-kernel@vger.kernel.org
Subject: Re: Stripping in module
References: <809C13DD6142E74ABE20C65B11A24398020882@www.telos.de> <Pine.LNX.4.61.0507250928300.18209@yvahk01.tjqt.qr> <20050725112622.GA1537@animx.eu.org>
In-Reply-To: <20050725112622.GA1537@animx.eu.org>
X-Enigmail-Version: 0.91.0.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Wakko Warner wrote:
[]
> I would also be interested in this.  For instance the AIC7xxx driver has
> every PCI id in the module I think in the .modinfo section which is not
> truely required once depmod has been run. []

The .modinfo section, for example the PCI IDs, IS required for the
module to function properly.  The kernel and the module uses that
tables to determime which devices to work with, and with which paramteres.

/mjt
