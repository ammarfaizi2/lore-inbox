Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264244AbUESPey@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264244AbUESPey (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 19 May 2004 11:34:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264246AbUESPey
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 19 May 2004 11:34:54 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:58529 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S264244AbUESPd7
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 19 May 2004 11:33:59 -0400
Date: Tue, 18 May 2004 12:48:16 -0300
From: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
To: "Justin T. Gibbs" <gibbs@scsiguy.com>
Cc: Etienne Vogt <etienne.vogt@obspm.fr>, linux-kernel@vger.kernel.org,
       James.Bottomley@HansenPartnership.com
Subject: Re: aic79xx trouble
Message-ID: <20040518154816.GA1918@logos.cnet>
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

Hi Justin,

I've seen several reports of what seem to be aic7xxx driver bugs. And
some of them you have stated that are fixed by your new driver.

I feel we should merge it in v2.4 mainline.  

Do you have any idea of how widely use your newer driver is?

For what reason the changes you made havent been merged in the past
in mainline?
