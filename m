Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262746AbVF2Xsu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262746AbVF2Xsu (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 29 Jun 2005 19:48:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262743AbVF2Xst
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 29 Jun 2005 19:48:49 -0400
Received: from gate.crashing.org ([63.228.1.57]:33196 "EHLO gate.crashing.org")
	by vger.kernel.org with ESMTP id S262749AbVF2XsF (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 29 Jun 2005 19:48:05 -0400
Subject: Re: [PATCH 8/13]: PCI Err: Event delivery utility
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Linas Vepstas <linas@austin.ibm.com>
Cc: linux-kernel@vger.kernel.org, long <tlnguyen@snoqualmie.dp.intel.com>,
       Hidetoshi Seto <seto.hidetoshi@jp.fujitsu.com>,
       Greg KH <greg@kroah.com>, ak@muc.de, Paul Mackerras <paulus@samba.org>,
       linuxppc64-dev <linuxppc64-dev@ozlabs.org>,
       linux-pci@atrey.karlin.mff.cuni.cz, johnrose@us.ibm.com
In-Reply-To: <20050629211435.GN28499@austin.ibm.com>
References: <20050628235932.GA6429@austin.ibm.com>
	 <1120010387.5133.235.camel@gaston>  <20050629211435.GN28499@austin.ibm.com>
Content-Type: text/plain
Date: Thu, 30 Jun 2005 09:42:01 +1000
Message-Id: <1120088522.31924.25.camel@gaston>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.2 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2005-06-29 at 16:14 -0500, Linas Vepstas wrote:

> I'm pretty sure this was balanced, there is a get very early on when the
> error is detected.  But I'll review.
> 
> > I'd keep that in arch code for now.
> 
> OK, I'm moving it there. It did seem both confusing and semi-pointless
> after the last round of changes.

Well, it's logical for the get and put to be in the same "layer" don't
you think ?

Ben.


