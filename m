Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750903AbWCEPzG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750903AbWCEPzG (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 5 Mar 2006 10:55:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751045AbWCEPzG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 5 Mar 2006 10:55:06 -0500
Received: from dsl093-040-174.pdx1.dsl.speakeasy.net ([66.93.40.174]:17031
	"EHLO aria.kroah.org") by vger.kernel.org with ESMTP
	id S1750903AbWCEPzF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 5 Mar 2006 10:55:05 -0500
Date: Sun, 5 Mar 2006 07:55:03 -0800
From: Greg KH <greg@kroah.com>
To: Arjan van de Ven <arjan@infradead.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] EDAC: core EDAC support code
Message-ID: <20060305155503.GA18580@kroah.com>
References: <200601190414.k0J4EZCV021775@hera.kernel.org> <1141553885.16388.0.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1141553885.16388.0.camel@laptopd505.fenrus.org>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Mar 05, 2006 at 11:18:04AM +0100, Arjan van de Ven wrote:
> 
> > +/* Main MC kobject release() function */
> > +static void edac_memctrl_master_release(struct kobject *kobj)
> > +{
> > +	debugf1("EDAC MC: " __FILE__ ": %s()\n", __func__);
> > +}
> > +
> 
> ehhh how on earth can this be right?

Ugh.  Good catch, it isn't right.  Gotta love it when people try to
ignore the helpful messages the kernel gives you when you use an API
wrong :(

thanks,

greg k-h
