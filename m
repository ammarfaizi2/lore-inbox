Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265027AbUGHWEr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265027AbUGHWEr (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 8 Jul 2004 18:04:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265031AbUGHWEr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 8 Jul 2004 18:04:47 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:48550 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S265027AbUGHWEl
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 8 Jul 2004 18:04:41 -0400
Message-ID: <40EDC4EC.1070609@pobox.com>
Date: Thu, 08 Jul 2004 18:04:28 -0400
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6) Gecko/20040510
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Pavel Roskin <proski@gnu.org>
CC: Michael Clark <michael@metaparadigm.com>,
       Linux kernel mailing list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] Update in-kernel orinoco drivers to upstream current
 CVS
References: <20040702222655.GA10333@bougret.hpl.hp.com> <20040703010709.A22334@electric-eye.fr.zoreil.com> <20040704021304.GD25992@zax> <20040704191732.A20676@electric-eye.fr.zoreil.com> <20040706011401.A390@electric-eye.fr.zoreil.com> <40E9E6BC.8020608@pobox.com> <20040707005402.A15251@electric-eye.fr.zoreil.com> <40EB510F.2040801@metaparadigm.com> <Pine.LNX.4.60.0407071359530.3991@marabou.research.att.com>
In-Reply-To: <Pine.LNX.4.60.0407071359530.3991@marabou.research.att.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Pavel Roskin wrote:
> drivers/net/pci-skeleton.c doesn't have power management code, but the 
> driver it was based on, 8139too.c, has such code and uses 
> pci_set_power_state() after pci_(save|restore)_state().  Other well 
> maintained drivers (e.g. e100.c) use pci_set_power_state() after 
> pci_save_state() and before pci_restore_state().  I think it's 
> reasonable to follow this example.  Jeff?


Yeah, that's working code.  Feel free to cut-n-paste, and/or even update 
pci-skeleton.c :)

	Jeff

