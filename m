Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265282AbUETU3P@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265282AbUETU3P (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 20 May 2004 16:29:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262009AbUETU3P
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 20 May 2004 16:29:15 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:24482 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S265282AbUETU3G
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 20 May 2004 16:29:06 -0400
Date: Thu, 20 May 2004 17:30:04 -0300
From: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
To: "Justin T. Gibbs" <gibbs@scsiguy.com>
Cc: Etienne Vogt <etienne.vogt@obspm.fr>, linux-kernel@vger.kernel.org
Subject: Re: aic79xx trouble
Message-ID: <20040520203004.GD20953@logos.cnet>
References: <200405132125.28053.bernd.schubert@pci.uni-heidelberg.de> <200405132136.32703.bernd.schubert@pci.uni-heidelberg.de> <Pine.LNX.4.58.0405161930260.2851@siolinb.obspm.fr> <3436150000.1084731012@aslan.btc.adaptec.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3436150000.1084731012@aslan.btc.adaptec.com>
User-Agent: Mutt/1.5.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, May 16, 2004 at 12:10:12PM -0600, Justin T. Gibbs wrote:
> >  The Adaptec Ultra320 cards (aic79xx) do not work reliably on Tyan Thunder
> > motherboards.
> 
> The U320 chips likely work a lot better now if you use driver version 2.0.12.
> The AMD chipsets seem to screw up split completions, and this version of
> the driver avoids the issue for the most common case of triggering the
> bug (transaction completion DMAs) by never crossing an ADB boundary with
> a single DMA.

Justin, 

Just out of curiosity, would you care to submit small fixes in separate
patches instead of a huge patch over a full -pre series 
(2.4.28-pre for example) ? 

Are distros using your updates ?

Thanks.
