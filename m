Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261868AbVBAJEo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261868AbVBAJEo (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 1 Feb 2005 04:04:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261870AbVBAJEl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 1 Feb 2005 04:04:41 -0500
Received: from mail.kroah.org ([69.55.234.183]:30909 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S261890AbVBAJCO (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 1 Feb 2005 04:02:14 -0500
Date: Tue, 1 Feb 2005 00:56:53 -0800
From: Greg KH <greg@kroah.com>
To: Mitch Williams <mitch.a.williams@intel.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/3] change sematics of read flag
Message-ID: <20050201085653.GA23068@kroah.com>
References: <Pine.CYG.4.58.0501211452420.3364@mawilli1-desk2.amr.corp.intel.com> <20050201083800.GB22162@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050201083800.GB22162@kroah.com>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 01, 2005 at 12:38:00AM -0800, Greg KH wrote:
> On Fri, Jan 21, 2005 at 02:55:09PM -0800, Mitch Williams wrote:
> > This patch reverses the semantics of the read fill flag, getting rid of an
> > extra assignment at allocation time.
> > 
> > Generated from 2.6.11-rc1.
> > 
> > Signed-off-by:  Mitch Williams <mitch.a.williams@intel.com>
> 
> Applied, thanks.

Ick, no.  Pulled back out, as it doesn't even compile :(

greg k-h
