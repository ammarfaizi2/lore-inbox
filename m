Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265641AbUFCQZf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265641AbUFCQZf (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 3 Jun 2004 12:25:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265642AbUFCQZf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 3 Jun 2004 12:25:35 -0400
Received: from mail.kroah.org ([65.200.24.183]:13212 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S265641AbUFCQZ3 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 3 Jun 2004 12:25:29 -0400
Date: Thu, 3 Jun 2004 09:24:02 -0700
From: Greg KH <greg@kroah.com>
To: Andrew Morton <akpm@osdl.org>
Cc: Paul Jackson <pj@sgi.com>, linux-kernel@vger.kernel.org, ak@suse.de,
       rusty@rustcorp.com.au
Subject: Re: [PATCH] fix sys cpumap for > 352 NR_CPUS
Message-ID: <20040603162402.GB3022@kroah.com>
References: <20040602161115.1340f698.pj@sgi.com> <20040602162330.0664ec5d.akpm@osdl.org> <20040602165902.73dfc977.pj@sgi.com> <20040602171724.2221f97e.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040602171724.2221f97e.akpm@osdl.org>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 02, 2004 at 05:17:24PM -0700, Andrew Morton wrote:
> Paul Jackson <pj@sgi.com> wrote:
> >
> > > Can't we just stick a PAGE_SIZE in here?
> > 
> > We could - either way works about as well.  Is there something special
> > about PAGE_SIZE here?  Is that in fact what sysfs is making available?
> 
> Think so.  Greg, can you confirm that a SYSDEV_ATTR's handler can safely
> assume that it has a PAGE_SIZE buffer to write to?

Yes, that is correct.

thanks,

greg k-h
