Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261722AbVCKEV2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261722AbVCKEV2 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 10 Mar 2005 23:21:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261684AbVCKESJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 10 Mar 2005 23:18:09 -0500
Received: from omx2-ext.sgi.com ([192.48.171.19]:52134 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S263211AbVCKEEp (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 10 Mar 2005 23:04:45 -0500
From: Jesse Barnes <jbarnes@engr.sgi.com>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: AGP bogosities
Date: Thu, 10 Mar 2005 20:02:46 -0800
User-Agent: KMail/1.7.2
Cc: Paul Mackerras <paulus@samba.org>, werner@sgi.com,
       Linus Torvalds <torvalds@osdl.org>, davej@redhat.com,
       Linux Kernel list <linux-kernel@vger.kernel.org>
References: <16944.62310.967444.786526@cargo.ozlabs.ibm.com> <200503101818.25033.jbarnes@engr.sgi.com> <1110508715.32524.317.camel@gaston>
In-Reply-To: <1110508715.32524.317.camel@gaston>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200503102002.47645.jbarnes@engr.sgi.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday, March 10, 2005 6:38 pm, Benjamin Herrenschmidt wrote:
> That one is even worse... from what I see in your lspci output, you have
> no bridge with AGP capability at all, and the various AGP devices are
> all siblings...

Both of the video cards are sitting on agp busses in agp slots hooked up to 
host to agp bridges.

> Are you sure there is any real AGP slot in there ?

Yes :)

Jesse
