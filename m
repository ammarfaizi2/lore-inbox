Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267882AbUIFM33@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267882AbUIFM33 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 6 Sep 2004 08:29:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267880AbUIFM33
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 6 Sep 2004 08:29:29 -0400
Received: from the-village.bc.nu ([81.2.110.252]:11937 "EHLO
	localhost.localdomain") by vger.kernel.org with ESMTP
	id S267879AbUIFM3Y (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 6 Sep 2004 08:29:24 -0400
Subject: Re: Intel ICH - sound/pci/intel8x0.c
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: 1094417386.1911.0.camel@localhost.localdomain
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <20040906083139.GA1188@linux.ensimag.fr>
References: <20040906083139.GA1188@linux.ensimag.fr>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Message-Id: <1094470037.3816.5.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2) 
Date: Mon, 06 Sep 2004 12:27:19 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Llu, 2004-09-06 at 09:31, Matthieu Castet wrote:
> > None of them help because you need to deal with hotplug.
> Heu, I don't understant why you need to deal with hotplug ?
> PnP modules works like pci modules. You make a list of know id, and then

ISAPnP has no hotplug functionality. If I have an ICH or 440MX in laptop
docking stations the ISAPnP world simply can't report it, while the PCI
hotplug layer can.

