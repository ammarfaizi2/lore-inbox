Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030408AbWBHSUU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030408AbWBHSUU (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 8 Feb 2006 13:20:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030434AbWBHSUU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 8 Feb 2006 13:20:20 -0500
Received: from mail.kroah.org ([69.55.234.183]:65482 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S1030408AbWBHSUS (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 8 Feb 2006 13:20:18 -0500
Date: Wed, 8 Feb 2006 09:36:18 -0800
From: Greg KH <gregkh@suse.de>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [RFC] EXPORT_SYMBOL_GPL_FUTURE()
Message-ID: <20060208173618.GC14105@suse.de>
References: <20060208062007.GA7936@kroah.com> <20060207233318.33fbdd8a.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060207233318.33fbdd8a.akpm@osdl.org>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 07, 2006 at 11:33:18PM -0800, Andrew Morton wrote:
> Greg KH <gregkh@suse.de> wrote:
> >
> >  +				printk(KERN_WARNING "symbol %s is being used "
> >  +					"by a non-GPL module, which will not "
> >  +					"be allowed in the future\n", name);
> 
> "See Documentation/feature-removal.txt for details".

Doh, that makes more sense :)

thanks,

greg k-h
