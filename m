Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262691AbVCCXVn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262691AbVCCXVn (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 3 Mar 2005 18:21:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262714AbVCCXRJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 3 Mar 2005 18:17:09 -0500
Received: from mail.kroah.org ([69.55.234.183]:27092 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S262662AbVCCXOt (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 3 Mar 2005 18:14:49 -0500
Date: Thu, 3 Mar 2005 15:14:30 -0800
From: Greg KH <greg@kroah.com>
To: Olof Johansson <olof@austin.ibm.com>
Cc: Paul Mackerras <paulus@samba.org>, Jeff Garzik <jgarzik@pobox.com>,
       Rene Rebe <rene@exactcode.de>, torvalds@osdl.org,
       linux-kernel@vger.kernel.org, chrisw@osdl.org
Subject: Re: [PATCH] trivial fix for 2.6.11 raid6 compilation on ppc w/ Altivec
Message-ID: <20050303231430.GA17031@kroah.com>
References: <422751D9.2060603@exactcode.de> <422756DC.6000405@pobox.com> <16935.36862.137151.499468@cargo.ozlabs.ibm.com> <20050303225542.GB16886@austin.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050303225542.GB16886@austin.ibm.com>
User-Agent: Mutt/1.5.8i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 03, 2005 at 04:55:42PM -0600, Olof Johansson wrote:
> On Fri, Mar 04, 2005 at 09:30:22AM +1100, Paul Mackerras wrote:
> > > I nominate this as a candidate for linux-2.6.11 release branch.  :)
> > 
> > No.  Unfortunately if you fix ppc64 here you will break ppc, and vice
> > versa.  Yes, we are going to reconcile the cur_cpu_spec definitions
> > between ppc and ppc64. :)
> 
> The proper fix is to get the cpu_has_feature patch merged up from -mm,
> but that's 99% cleanup and 1% bugfix. So here's a more appropriate fix
> for the 2.6.11 patch stream. This goes on top of the one that just got
> merged there.

Applied, thanks.

greg k-h
