Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751164AbWDEUJS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751164AbWDEUJS (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 5 Apr 2006 16:09:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751167AbWDEUJS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 5 Apr 2006 16:09:18 -0400
Received: from dsl093-040-174.pdx1.dsl.speakeasy.net ([66.93.40.174]:16289
	"EHLO aria.kroah.org") by vger.kernel.org with ESMTP
	id S1751164AbWDEUJQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 5 Apr 2006 16:09:16 -0400
Date: Wed, 5 Apr 2006 13:08:31 -0700
From: Greg KH <greg@kroah.com>
To: Kylene Jo Hall <kjhall@us.ibm.com>
Cc: linux-kernel <linux-kernel@vger.kernel.org>, akpm@osdl.org,
       TPM Device Driver List <tpmdd-devel@lists.sourceforge.net>,
       Marcel Selhorst <selhorst@crypto.rub.de>
Subject: Re: PATCH 6/7] tpm: new 1.2 sysfs files - Updated patch
Message-ID: <20060405200831.GA3951@kroah.com>
References: <1144266504.5235.44.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1144266504.5235.44.camel@localhost.localdomain>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 05, 2006 at 02:48:24PM -0500, Kylene Jo Hall wrote:
> On Mon Apr 03, 2006 at 21:47:25 Greg KH wrote:
> <snip>
> > > +EXPORT_SYMBOL_GPL(tpm_show_state);
> > 
> > That is more than one value per file.  Please make unique files for the
> > different capabilities.  As it stands the file doesn't make too much
> > sense for someone reading it and not understanding that each line is a
> > different portion of the state.
> > 
> > thanks,
> > 
> > greg k-h
> tpm_show_state removed in this patch in favor of separate files.

Thanks for changing this, looks much better now.

greg k-h
