Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268239AbUIPSd1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268239AbUIPSd1 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 16 Sep 2004 14:33:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268229AbUIPS3e
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 16 Sep 2004 14:29:34 -0400
Received: from omx3-ext.sgi.com ([192.48.171.20]:9115 "EHLO omx3.sgi.com")
	by vger.kernel.org with ESMTP id S268170AbUIPSXm (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 16 Sep 2004 14:23:42 -0400
From: Jesse Barnes <jbarnes@engr.sgi.com>
To: Robert Picco <Robert.Picco@hp.com>
Subject: Re: device driver for the SGI system clock, mmtimer
Date: Thu, 16 Sep 2004 11:23:13 -0700
User-Agent: KMail/1.7
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, Bjorn Helgaas <bjorn.helgaas@hp.com>,
       Christoph Lameter <clameter@sgi.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       venkatesh.pallipadi@intel.com
References: <200409161003.39258.bjorn.helgaas@hp.com> <200409161007.37015.jbarnes@engr.sgi.com> <4149D8C6.1060407@hp.com>
In-Reply-To: <4149D8C6.1060407@hp.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200409161123.13891.jbarnes@engr.sgi.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday, September 16, 2004 11:17 am, Robert Picco wrote:
> The hpet driver checks that the mapping is page aligned.  It's up to the
> platform to provide this alignment.  It's also dependent on the platform
> for what resides in the page.  Also the configured page size could
> impact what is within the page.

Right, mmtimer has the same checks.  I'll leave it up to Christoph.  I haven't 
looked at the hpet driver at all, so I'm not sure if it's appropriate.

Jesse
