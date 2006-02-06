Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964773AbWBFUZi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964773AbWBFUZi (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 6 Feb 2006 15:25:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964777AbWBFUZi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 6 Feb 2006 15:25:38 -0500
Received: from viper.oldcity.dca.net ([216.158.38.4]:48327 "HELO
	viper.oldcity.dca.net") by vger.kernel.org with SMTP
	id S964773AbWBFUZh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 6 Feb 2006 15:25:37 -0500
Subject: Re: DMA in PCI chipset -- module vs. compiled-in
From: Lee Revell <rlrevell@joe-job.com>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: William Park <opengeometry@yahoo.ca>, linux-kernel@vger.kernel.org
In-Reply-To: <1139255365.10437.49.camel@localhost.localdomain>
References: <20060206034312.GA2962@node1.opengeometry.net>
	 <1139200372.2791.208.camel@mindpipe>
	 <1139255365.10437.49.camel@localhost.localdomain>
Content-Type: text/plain
Date: Mon, 06 Feb 2006 15:25:34 -0500
Message-Id: <1139257535.2791.298.camel@mindpipe>
Mime-Version: 1.0
X-Mailer: Evolution 2.5.90 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2006-02-06 at 19:49 +0000, Alan Cox wrote:
> On Sul, 2006-02-05 at 23:32 -0500, Lee Revell wrote:
> > Generic and chipset specific support are not complementary, they are
> > mutually exclusive.  Having generic PCI IDE support enabled will prevent
> > the chipset specific support from working properly.
> 
> Untrue.
> 
> The PCI generic driver by default grabs only hardware with PCI IDS it
> knows can be driven generically. That list purposefully has no overlaps
> with chipset drivers.

OK.  But wasn't this a problem in previous kernels?

Lee

