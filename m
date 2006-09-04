Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964835AbWIDLz7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964835AbWIDLz7 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 4 Sep 2006 07:55:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964836AbWIDLz7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 4 Sep 2006 07:55:59 -0400
Received: from relay1.ptmail.sapo.pt ([212.55.154.21]:43663 "HELO sapo.pt")
	by vger.kernel.org with SMTP id S964835AbWIDLz6 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 4 Sep 2006 07:55:58 -0400
X-AntiVirus: PTMail-AV 0.3-0.88.4
Subject: Re: VIA IRQ quirk, another (embarrassing) suggestion.
From: Sergio Monteiro Basto <sergio@sergiomb.no-ip.org>
To: Chris Wedgwood <cw@f00f.org>
Cc: Jeff Garzik <jeff@garzik.org>, Andrew Morton <akpm@osdl.org>,
       bjorn.helgaas@hp.com, linux-kernel@vger.kernel.org,
       Alan Cox <alan@lxorguk.ukuu.org.uk>, greg@kroah.com, harmon@ksu.edu,
       Daniel Drake <dsd@gentoo.org>, Len Brown <len.brown@intel.com>
In-Reply-To: <20060904055502.GA26816@tuatara.stupidest.org>
References: <1157330567.3046.24.camel@localhost.portugal>
	 <20060903175841.7a84c63c.akpm@osdl.org> <44FBBD28.6070601@garzik.org>
	 <20060904055502.GA26816@tuatara.stupidest.org>
Content-Type: text/plain; charset=utf-8
Date: Mon, 04 Sep 2006 12:54:07 +0100
Message-Id: <1157370847.4624.15.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.3 (2.6.3-1.fc5.5) 
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2006-09-03 at 22:55 -0700, Chris Wedgwood wrote:
> On Mon, Sep 04, 2006 at 01:44:08AM -0400, Jeff Garzik wrote:
> 
> > Some installations have VIA products on a PCI card.  We cannot
> > assume that all PCI_VENDOR_ID_VIA devices are on-board devices with
> > the special VIA PIC on-chip routing (the thing quirk_via_irq
> > tweaks). 

I don't know if this is a real question. Have we VIA products on PCI
card, running on not VIA chip sets ? 

but in this cases, we can add other "if" to exclude this cases from
quirks. Until then I think it is urgent put this VIA PIC quirks back to
state of kernel 2.6.12, with quirking just on PIC mode .
(http://www.kernel.org/diff/diffview.cgi?file=%2Fpub%2Flinux%2Fkernel%
2Fv2.6%2Fpatch-2.6.12.bz2;z=2752)

Thanks, 
--
Sérgio M. B.


-- 
VGER BF report: H 5.50155e-11
