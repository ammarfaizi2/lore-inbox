Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750771AbWDYGRJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750771AbWDYGRJ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 25 Apr 2006 02:17:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751261AbWDYGRJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 25 Apr 2006 02:17:09 -0400
Received: from pentafluge.infradead.org ([213.146.154.40]:14497 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S1750771AbWDYGRH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 25 Apr 2006 02:17:07 -0400
Subject: Re: [patch] pciehp: dont call pci_enable_dev
From: Arjan van de Ven <arjan@infradead.org>
To: Kristen Accardi <kristen.c.accardi@intel.com>
Cc: pcihpd-discuss@lists.sourceforge.net, greg@kroah.com,
       linux-kernel@vger.kernel.org
In-Reply-To: <1145919059.6478.29.camel@whizzy>
References: <1145919059.6478.29.camel@whizzy>
Content-Type: text/plain
Date: Tue, 25 Apr 2006 08:16:59 +0200
Message-Id: <1145945819.3114.0.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <arjan@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2006-04-24 at 15:50 -0700, Kristen Accardi wrote:
> Don't call pci_enable_device from pciehp because the pcie port service driver
> already does this.

hmmmm shouldn't pci_enable_device on a previously enabled device just
succeed? Sounds more than logical to me to make it that way at least...

