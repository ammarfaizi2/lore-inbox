Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751214AbWJAPqZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751214AbWJAPqZ (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 1 Oct 2006 11:46:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751207AbWJAPqZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 1 Oct 2006 11:46:25 -0400
Received: from nf-out-0910.google.com ([64.233.182.186]:43588 "EHLO
	nf-out-0910.google.com") by vger.kernel.org with ESMTP
	id S1751196AbWJAPqY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 1 Oct 2006 11:46:24 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:date:from:to:cc:subject:message-id:references:mime-version:content-type:content-disposition:content-transfer-encoding:in-reply-to:user-agent;
        b=HZTSPvk13/FwpWVZgIOq6Qn7gUMzMGO3isxWLmYpXnnvCrjW1xtaUtkW6rBRlrHwQTVJbnEKlcGFyU/jLOF1D9cbUqjeaKoIB2emvpPdPJZkGAwp3OcC7UYbg4aTMLMbmVPyKn7t6oh/nAUvkpoYowbPEHqJLgbF8SLsiiJk6kI=
Date: Sun, 1 Oct 2006 17:46:30 +0200
From: Luca Tettamanti <kronos.it@gmail.com>
To: Andi Kleen <ak@suse.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [2.6.18-git] Lost all PCI devices
Message-ID: <20061001154630.GA4525@dreamland.darkstar.lan>
References: <20060930174247.GA31793@dreamland.darkstar.lan> <200609302234.24778.ak@suse.de> <20060930220600.GA19990@dreamland.darkstar.lan> <200610010013.01390.ak@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <200610010013.01390.ak@suse.de>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Il Sun, Oct 01, 2006 at 12:13:01AM +0200, Andi Kleen ha scritto: 
> 
> > "pci_direct_probe conf*" printk are placed before calling into
> > pci_check_type{1,2}, it doesn't call pci_sanity_check so it's the I/O
> > check that fails.
> > I can do further debugging if you're interested.
> 
> No I was just curious. It's strange that your system doesn't work without 
> PCI BIOS though. Is it an older laptop? The assumption so far
> was that everything modern can do type 1 without problems (except 
> one broken Apple system). Apparently that's not universally true.

The machine is an ASUS L3D, it's about 3 years old (the built-in memory
module was manufactured on week 41 / 2003). I'm using the latest BIOS,
02/10/2004.

Luca
-- 
Home: http://kronoz.cjb.net
"Vorrei morire ucciso dagli agi. Vorrei che di me si dicesse: ``Com'è
morto?'' ``Gli è scoppiato il portafogli''" -- Marcello Marchesi
