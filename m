Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932184AbVIXOvH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932184AbVIXOvH (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 24 Sep 2005 10:51:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932185AbVIXOvH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 24 Sep 2005 10:51:07 -0400
Received: from metis.extern.pengutronix.de ([83.236.181.26]:7060 "EHLO
	metis.extern.pengutronix.de") by vger.kernel.org with ESMTP
	id S932184AbVIXOvG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 24 Sep 2005 10:51:06 -0400
Date: Sat, 24 Sep 2005 16:51:02 +0200
From: Robert Schwebel <r.schwebel@pengutronix.de>
To: Luke Yang <luke.adi@gmail.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: ADI Blackfin porting for kernel-2.6.13
Message-ID: <20050924145102.GD28883@pengutronix.de>
References: <489ecd0c05091923336b48555@mail.gmail.com> <20050920071514.GA10909@plexity.net> <489ecd0c050922223736cf1548@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
In-Reply-To: <489ecd0c050922223736cf1548@mail.gmail.com>
User-Agent: Mutt/1.5.5.1+cvs20040105i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 23, 2005 at 01:37:03PM +0800, Luke Yang wrote:
> This patch mainly includes the arch/bfinnommu architecture files and
> some blackfin specific drivers.

Having in mind the pain with arm and m68k with and without MMU, could
you structure that thing in a way that it will be able to share the
current nommu code with (hopefully coming) code for blackfins which
might have a MMU? So it would be something like arch/blackfin. 

Robert 
-- 
 Dipl.-Ing. Robert Schwebel | http://www.pengutronix.de
 Pengutronix - Linux Solutions for Science and Industry
   Handelsregister:  Amtsgericht Hildesheim, HRA 2686
     Hannoversche Str. 2, 31134 Hildesheim, Germany
   Phone: +49-5121-206917-0 |  Fax: +49-5121-206917-9

