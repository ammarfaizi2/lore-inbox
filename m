Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S272873AbTGaJSm (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 31 Jul 2003 05:18:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272916AbTGaJSm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 31 Jul 2003 05:18:42 -0400
Received: from louise.pinerecords.com ([213.168.176.16]:26268 "EHLO
	louise.pinerecords.com") by vger.kernel.org with ESMTP
	id S272873AbTGaJSl (ORCPT <rfc822;Linux-Kernel@vger.kernel.org>);
	Thu, 31 Jul 2003 05:18:41 -0400
Date: Thu, 31 Jul 2003 11:15:25 +0200
From: Tomas Szepe <szepe@pinerecords.com>
To: Adrian Bunk <bunk@fs.tum.de>
Cc: John Bradford <john@grabjohn.com>, Riley@Williams.Name,
       Linux-Kernel@vger.kernel.org
Subject: Re: [2.6 patch] let broken drivers depend on BROKEN{,ON_SMP}
Message-ID: <20030731091525.GI12849@louise.pinerecords.com>
References: <200307300911.h6U9BH2f000813@81-2-122-30.bradfords.org.uk> <20030730104421.GC28767@fs.tum.de> <20030730160403.GF12849@louise.pinerecords.com> <20030730161839.GB19356@fs.tum.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030730161839.GB19356@fs.tum.de>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> [bunk@fs.tum.de]
> 
> On Wed, Jul 30, 2003 at 06:04:03PM +0200, Tomas Szepe wrote:
> > > [bunk@fs.tum.de]
> > > 
> > > If a _user_ of a stable kernel notices "it doesn't even compile" this 
> > > gives a very bad impression of the quality of the Linux kernel.
> > 
> > The keyword in this sentence is "stable."
> > Could you maybe come up with this again at around 2.6.40? :)
> 
> The first stable kernel of the 2.6 kernel series will be 2.6.0.

There are going to be a zillion drivers that don't compile by the
time 2.6.0 is released, which is precisely when lkml will see a whole
new wave of people willing to fix things so I really don't think
hiding the problems behind CONFIG_BROKEN or whatever is reasonable.

-- 
Tomas Szepe <szepe@pinerecords.com>
