Return-Path: <linux-kernel-owner+w=401wt.eu-S1750747AbXACNwh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750747AbXACNwh (ORCPT <rfc822;w@1wt.eu>);
	Wed, 3 Jan 2007 08:52:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750777AbXACNwh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 3 Jan 2007 08:52:37 -0500
Received: from pentafluge.infradead.org ([213.146.154.40]:34750 "EHLO
	pentafluge.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750747AbXACNwg (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 3 Jan 2007 08:52:36 -0500
Subject: Re: [PATCH] quiet MMCONFIG related printks
From: Arjan van de Ven <arjan@infradead.org>
To: Alan <alan@lxorguk.ukuu.org.uk>
Cc: Jesse Barnes <jbarnes@virtuousgeek.org>, linux-kernel@vger.kernel.org,
       Andrew Morton <akpm@osdl.org>
In-Reply-To: <20070102103602.28a873ea@localhost.localdomain>
References: <200701012101.38427.jbarnes@virtuousgeek.org>
	 <20070102103602.28a873ea@localhost.localdomain>
Content-Type: text/plain
Organization: Intel International BV
Date: Wed, 03 Jan 2007 05:52:33 -0800
Message-Id: <1167832353.3095.18.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.8.2.1 (2.8.2.1-2.fc6) 
Content-Transfer-Encoding: 7bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <arjan@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2007-01-02 at 10:36 +0000, Alan wrote:
> On Mon, 1 Jan 2007 21:01:38 -0800
> Jesse Barnes <jbarnes@virtuousgeek.org> wrote:
> 
> > Using MMCONFIG for PCI config space access is simply an optimization, not
> > a requirement.  Therefore, when it can't be used, there's no need for
> 
> Some hardware reqires MCFG. In addition this is an error, a real error on
> the vendors part or ours and could indicate there are many other BIOS
> problems outstanding.
> 
> We shouldn't keep quiet about serious errors in tables, we need people to
> know and be able to take appropriate action (eg new BIOSen, refusing
> certifications etc).

to some degree that is what the firmware kit is for ;)

-- 
if you want to mail me at work (you don't), use arjan (at) linux.intel.com
Test the interaction between Linux and your BIOS via http://www.linuxfirmwarekit.org

