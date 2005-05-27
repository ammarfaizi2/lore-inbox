Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262550AbVE0TFE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262550AbVE0TFE (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 27 May 2005 15:05:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262544AbVE0TCj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 27 May 2005 15:02:39 -0400
Received: from pentafluge.infradead.org ([213.146.154.40]:33771 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S262549AbVE0TCH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 27 May 2005 15:02:07 -0400
Date: Fri, 27 May 2005 20:02:03 +0100
From: Christoph Hellwig <hch@infradead.org>
To: Christoph Hellwig <hch@infradead.org>,
       "David S. Miller" <davem@davemloft.net>, linux-kernel@vger.kernel.org,
       netdev@oss.sgi.com, jgarzik@pobox.com, mchan@broadcom.com
Subject: Re: [patch 2.6.12-rc5] tg3: add bcm5752 entry to pci.ids
Message-ID: <20050527190203.GA7692@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	"David S. Miller" <davem@davemloft.net>,
	linux-kernel@vger.kernel.org, netdev@oss.sgi.com, jgarzik@pobox.com,
	mchan@broadcom.com
References: <04132005193844.8410@laptop> <04132005193844.8474@laptop> <20050421165956.55bdcb14.davem@davemloft.net> <20050527184750.GB11592@tuxdriver.com> <20050527185334.GA7417@infradead.org> <20050527190000.GC11592@tuxdriver.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050527190000.GC11592@tuxdriver.com>
User-Agent: Mutt/1.4.1i
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 27, 2005 at 03:00:00PM -0400, John W. Linville wrote:
> On Fri, May 27, 2005 at 07:53:35PM +0100, Christoph Hellwig wrote:
> > On Fri, May 27, 2005 at 02:47:52PM -0400, John W. Linville wrote:
> 
> > > +	1600  NetXtreme BCM5752 Gigabit Ethernet PCI Express
> > 
> > I don't think you should mention "PCI Express" here.  That can trivially
> > befound it looking at the configuration header.
> 
> I'm just following what is at pciids.sourceforge.net.  Plus, it is
> already like that for nine other IDs:
> 
>         1659  NetXtreme BCM5721 Gigabit Ethernet PCI Express
>         1677  NetXtreme BCM5751 Gigabit Ethernet PCI Express
>         167d  NetXtreme BCM5751M Gigabit Ethernet PCI Express
>         167e  NetXtreme BCM5751F Fast Ethernet PCI Express
>         169d  NetLink BCM5789 Gigabit Ethernet PCI Express
>         16dd  NetLink BCM5781 Gigabit Ethernet PCI Express
>         16f7  NetXtreme BCM5753 Gigabit Ethernet PCI Express
>         16fd  NetXtreme BCM5753M Gigabit Ethernet PCI Express
>         16fe  NetXtreme BCM5753F Fast Ethernet PCI Express
> 
> The Broadcom guys can speak-up, but I figure they know if "PCI Express"
> is appropriate for their device... :-)

ok, it should be an all or nothing.  I still think it's more than silly..
