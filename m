Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261548AbVFHTcl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261548AbVFHTcl (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 8 Jun 2005 15:32:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261571AbVFHTcl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 8 Jun 2005 15:32:41 -0400
Received: from hell.sks3.muni.cz ([147.251.210.30]:54280 "EHLO
	anubis.fi.muni.cz") by vger.kernel.org with ESMTP id S261548AbVFHTcU
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 8 Jun 2005 15:32:20 -0400
Date: Wed, 8 Jun 2005 21:32:15 +0200
From: Lukas Hejtmanek <xhejtman@mail.muni.cz>
To: Scott Bardone <sbardone@chelsio.com>
Cc: Francois Romieu <romieu@fr.zoreil.com>, Jeff Garzik <jgarzik@pobox.com>,
       linux-kernel@vger.kernel.org
Subject: Re: Kernel 2.6.12-rc6-mm1 & Chelsio driver
Message-ID: <20050608193215.GF2369@mail.muni.cz>
References: <8A71B368A89016469F72CD08050AD3340255F0@maui.asicdesigners.com> <20050608184933.GC2369@mail.muni.cz> <42A742FF.2020706@chelsio.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-2
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <42A742FF.2020706@chelsio.com>
X-echelon: NSA, CIA, CI5, MI5, FBI, KGB, BIS, Plutonium, Bin Laden, bomb
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 08, 2005 at 12:11:59PM -0700, Scott Bardone wrote:
> You would need to use the cxgb-2.1.1 driver (NIC only). It is near the 
> bottom of the webpage, under "Chelsio N210 / N110 10Gb Ethernet Server 
> Adapter",  Chelsio N210 / N110 Linux Driver - Version 2.1.1 (05/17/2005).
> <https://service.chelsio.com/drivers/linux/n210/cxgb-2.1.1.tar.gz>
> Use the above driver for the T110 in NIC mode. This driver will work for 
> the T110 and T210 but only in NIC mode.

Unfortunately, this driver does not contain 
CH_DEVICE(6, 0|1.. )

Should I just add it?

-- 
Luká¹ Hejtmánek
