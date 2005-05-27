Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262543AbVE0TA5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262543AbVE0TA5 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 27 May 2005 15:00:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262544AbVE0TAt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 27 May 2005 15:00:49 -0400
Received: from ra.tuxdriver.com ([24.172.12.4]:47366 "EHLO ra.tuxdriver.com")
	by vger.kernel.org with ESMTP id S262543AbVE0TAR (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 27 May 2005 15:00:17 -0400
Date: Fri, 27 May 2005 15:00:00 -0400
From: "John W. Linville" <linville@tuxdriver.com>
To: Christoph Hellwig <hch@infradead.org>,
       "David S. Miller" <davem@davemloft.net>, linux-kernel@vger.kernel.org,
       netdev@oss.sgi.com, jgarzik@pobox.com, mchan@broadcom.com
Subject: Re: [patch 2.6.12-rc5] tg3: add bcm5752 entry to pci.ids
Message-ID: <20050527190000.GC11592@tuxdriver.com>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	"David S. Miller" <davem@davemloft.net>,
	linux-kernel@vger.kernel.org, netdev@oss.sgi.com, jgarzik@pobox.com,
	mchan@broadcom.com
References: <04132005193844.8410@laptop> <04132005193844.8474@laptop> <20050421165956.55bdcb14.davem@davemloft.net> <20050527184750.GB11592@tuxdriver.com> <20050527185334.GA7417@infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050527185334.GA7417@infradead.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 27, 2005 at 07:53:35PM +0100, Christoph Hellwig wrote:
> On Fri, May 27, 2005 at 02:47:52PM -0400, John W. Linville wrote:

> > +	1600  NetXtreme BCM5752 Gigabit Ethernet PCI Express
> 
> I don't think you should mention "PCI Express" here.  That can trivially
> befound it looking at the configuration header.

I'm just following what is at pciids.sourceforge.net.  Plus, it is
already like that for nine other IDs:

        1659  NetXtreme BCM5721 Gigabit Ethernet PCI Express
        1677  NetXtreme BCM5751 Gigabit Ethernet PCI Express
        167d  NetXtreme BCM5751M Gigabit Ethernet PCI Express
        167e  NetXtreme BCM5751F Fast Ethernet PCI Express
        169d  NetLink BCM5789 Gigabit Ethernet PCI Express
        16dd  NetLink BCM5781 Gigabit Ethernet PCI Express
        16f7  NetXtreme BCM5753 Gigabit Ethernet PCI Express
        16fd  NetXtreme BCM5753M Gigabit Ethernet PCI Express
        16fe  NetXtreme BCM5753F Fast Ethernet PCI Express

The Broadcom guys can speak-up, but I figure they know if "PCI Express"
is appropriate for their device... :-)

John
-- 
John W. Linville
linville@tuxdriver.com
