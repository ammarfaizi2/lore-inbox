Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271187AbTHLWJT (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 12 Aug 2003 18:09:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271188AbTHLWJT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 12 Aug 2003 18:09:19 -0400
Received: from smtp-node1.eclipse.net.uk ([212.104.129.76]:50961 "EHLO
	smtp1.ex.eclipse.net.uk") by vger.kernel.org with ESMTP
	id S271187AbTHLWJS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 12 Aug 2003 18:09:18 -0400
From: Ian Hastie <ianh@iahastie.clara.net>
To: Matthew Wilcox <willy@debian.org>, Dave Jones <davej@redhat.com>,
       Robert Love <rml@tech9.net>, CaT <cat@zip.com.au>,
       linux-kernel@vger.kernel.org,
       kernel-janitor-discuss@lists.sourceforge.net
Subject: Re: C99 Initialisers
Date: Tue, 12 Aug 2003 23:06:45 +0100
User-Agent: KMail/1.5.3
References: <20030812020226.GA4688@zip.com.au> <20030812173707.GB6919@redhat.com> <20030812174810.GD10015@parcelfarce.linux.theplanet.co.uk>
In-Reply-To: <20030812174810.GD10015@parcelfarce.linux.theplanet.co.uk>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200308122306.48206.ianh@iahastie.local.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 12 Aug 2003 18:48, Matthew Wilcox wrote:
> On Tue, Aug 12, 2003 at 06:37:07PM +0100, Dave Jones wrote:
> > Depends. If it's a huuuge struct (see the device ID struct in 2.4's
> > agpgart for eg) it becomes much more readable. Whitespace good, clutter
> > bad.
>
> Yup, absolutely.  My point is that struct pci_device_id is really really
> common.  If you've ever looked at a Linux PCI driver, you've seen it.

That could be used as an argument for just as much as against.  The very fact 
of it's ubiquity makes it all the more important to minimise the possibility 
of confusion.  C99 initialisers will help a lot with this.

> The agp_bridge_info example is specific to this one driver, so it's new
> every time you look at it.

That really doesn't make sense to me.

-- 
Ian.

