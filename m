Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268791AbUI3FxM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268791AbUI3FxM (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 30 Sep 2004 01:53:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268846AbUI3FxM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 30 Sep 2004 01:53:12 -0400
Received: from cantor.suse.de ([195.135.220.2]:26792 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id S268791AbUI3FxJ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 30 Sep 2004 01:53:09 -0400
Date: Thu, 30 Sep 2004 07:53:07 +0200
From: Olaf Hering <olh@suse.de>
To: David Gibson <david@gibson.dropbear.id.au>, Andrew Morton <akpm@osdl.org>,
       Anton Blanchard <anton@samba.org>, Paul Mackerras <paulus@samba.org>,
       linuxppc64-dev@ozlabs.org, linux-kernel@vger.kernel.org
Subject: Re: [PPC64] Improved VSID allocation algorithm
Message-ID: <20040930055307.GA15291@suse.de>
References: <20040913041119.GA5351@zax> <20040929194730.GA6292@suse.de> <20040930003846.GB25001@zax>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20040930003846.GB25001@zax>
X-DOS: I got your 640K Real Mode Right Here Buddy!
X-Homeland-Security: You are not supposed to read this line! You are a terrorist!
User-Agent: Mutt und vi sind doch schneller als Notes (und GroupWise)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

 On Thu, Sep 30, David Gibson wrote:

> On Wed, Sep 29, 2004 at 09:47:30PM +0200, Olaf Hering wrote:
> >  On Mon, Sep 13, David Gibson wrote:
> > 
> > > Andrew, please apply.  This patch has been tested both on SLB and
> > > segment table machines.  This new approach is far from the final word
> > > in VSID/context allocation, but it's a noticeable improvement on the
> > > old method.
> > 
> > This patch went into 2.6.9-rc2-bk2, and my p640 does not boot anymore.
> > Hangs after 'returning from prom_init', wants a power cycle.
> 
> Have you isolated the problem to the VSID allocation patch?  I think
> there may have been a number of ppc64 changes which went into
> 2.6.9-rc2-bk2.

Yes, rc2 does not boot on power3 with that patch.

-- 
USB is for mice, FireWire is for men!

sUse lINUX ag, nÜRNBERG
