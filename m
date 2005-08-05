Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263052AbVHEPSi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263052AbVHEPSi (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 5 Aug 2005 11:18:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263050AbVHEPSe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 5 Aug 2005 11:18:34 -0400
Received: from postfix4-2.free.fr ([213.228.0.176]:42129 "EHLO
	postfix4-2.free.fr") by vger.kernel.org with ESMTP id S263046AbVHEPR6
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 5 Aug 2005 11:17:58 -0400
Message-ID: <42F38324.10207@free.fr>
Date: Fri, 05 Aug 2005 17:17:56 +0200
From: matthieu castet <castet.matthieu@free.fr>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.10) Gecko/20050802 Debian/1.7.10-1
X-Accept-Language: fr-fr, en, en-us
MIME-Version: 1.0
To: Bjorn Helgaas <bjorn.helgaas@hp.com>
CC: Adam Belay <ambx1@neo.rr.com>, Li Shaohua <shaohua.li@intel.com>,
       Kenji Kaneshige <kaneshige.kenji@jp.fujitsu.com>,
       acpi-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] PNPACPI: fix IRQ and 64-bit address decoding
References: <200508041726.19336.bjorn.helgaas@hp.com>
In-Reply-To: <200508041726.19336.bjorn.helgaas@hp.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Bjorn Helgaas wrote:
> Maybe the third time's the charm :-)  Added a bugfix
> (pcibios_penalize_isa_irq()) and a workaround for HP
> HPET firmware description since last time.  The workaround
> accepts stuff that is illegal according to the spec,
> so speak up if you think this is a problem.  It seems
> fairly safe to me.
> 
May be print some warnings if the acpi is broken...


Matthieu
