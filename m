Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264881AbUAaOa1 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 31 Jan 2004 09:30:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264887AbUAaOa1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 31 Jan 2004 09:30:27 -0500
Received: from krusty.dt.E-Technik.Uni-Dortmund.DE ([129.217.163.1]:16346 "EHLO
	mail.dt.e-technik.uni-dortmund.de") by vger.kernel.org with ESMTP
	id S264881AbUAaOaX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 31 Jan 2004 09:30:23 -0500
Date: Sat, 31 Jan 2004 15:30:19 +0100
From: Matthias Andree <matthias.andree@gmx.de>
To: Linux-Kernel mailing list <linux-kernel@vger.kernel.org>
Subject: Re: khubd crash on scanner disconnect
Message-ID: <20040131143019.GB31547@merlin.emma.line.org>
Mail-Followup-To: Linux-Kernel mailing list <linux-kernel@vger.kernel.org>
References: <20040130173656.GA4570@merlin.emma.line.org> <20040130191453.GA7173@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040130191453.GA7173@kroah.com>
User-Agent: Mutt/1.5.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 30 Jan 2004, Greg KH wrote:

> On Fri, Jan 30, 2004 at 06:36:56PM +0100, Matthias Andree wrote:
> > Hi,
> > 
> > I have just caught this khubd NULL dereference simply by unplugging my
> > scanner. Kernel is a current 2.6.2-rc2 from BK, PNP enabled:
> 
> Known bug, don't use that module, it's OBSOLETED.  Use xscane and libusb
> instead.

Well, if it's "obsoleted" AND "broken", why not remove it from Kconfig
altogether, just leaving a pointer "scanner has been replaced by
libusb"?

-- 
Matthias Andree

Encrypt your mail: my GnuPG key ID is 0x052E7D95
