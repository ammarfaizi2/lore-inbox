Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266344AbUI0PN5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266344AbUI0PN5 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 27 Sep 2004 11:13:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266187AbUI0PN4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 27 Sep 2004 11:13:56 -0400
Received: from atlrel6.hp.com ([156.153.255.205]:39312 "EHLO atlrel6.hp.com")
	by vger.kernel.org with ESMTP id S266319AbUI0PMU (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 27 Sep 2004 11:12:20 -0400
From: Bjorn Helgaas <bjorn.helgaas@hp.com>
To: David Brownell <david-b@pacbell.net>
Subject: Re: OHCI_QUIRK_INITRESET (was: 2.6.9-rc2-mm2 ohci_hcd doesn't work)
Date: Mon, 27 Sep 2004 09:11:56 -0600
User-Agent: KMail/1.7
Cc: "Rui Nuno Capela" <rncbc@rncbc.org>, "Ingo Molnar" <mingo@elte.hu>,
       linux-kernel@vger.kernel.org,
       "Karsten Wiese" <annabellesgarden@yahoo.de>,
       "Roman Weissgaerber" <weissg@vienna.at>,
       linux-usb-devel@lists.sourceforge.net, "K.R. Foley" <kr@cybsft.com>
References: <414F8CFB.3030901@cybsft.com> <200409241016.46201.bjorn.helgaas@hp.com> <200409251637.29401.david-b@pacbell.net>
In-Reply-To: <200409251637.29401.david-b@pacbell.net>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200409270911.56415.bjorn.helgaas@hp.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Saturday 25 September 2004 5:37 pm, David Brownell wrote:
> On Friday 24 September 2004 9:16 am, Bjorn Helgaas wrote:
> > 
> > The attached patch (which applies on top of Rui's patch for
> > ALI M5237) fixes the problem for my DL360.  
> 
> Hmm, I'd rather avoid needing a quirk table ... especially
> when I've always suspected this is some subtle bug in the
> way Linux initializes!  Does this patch behave too?

Yes, your patch seems to work on my DL360 (ServerWorks OSB4/CSB5 OHCI)
as well.
