Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932158AbWCEQYL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932158AbWCEQYL (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 5 Mar 2006 11:24:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932170AbWCEQYL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 5 Mar 2006 11:24:11 -0500
Received: from pentafluge.infradead.org ([213.146.154.40]:63138 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S932158AbWCEQYJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 5 Mar 2006 11:24:09 -0500
Subject: Re: [PATCH] EDAC: core EDAC support code
From: Arjan van de Ven <arjan@infradead.org>
To: Greg KH <greg@kroah.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <20060305155503.GA18580@kroah.com>
References: <200601190414.k0J4EZCV021775@hera.kernel.org>
	 <1141553885.16388.0.camel@laptopd505.fenrus.org>
	 <20060305155503.GA18580@kroah.com>
Content-Type: text/plain
Date: Sun, 05 Mar 2006 17:24:06 +0100
Message-Id: <1141575846.18528.1.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <arjan@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2006-03-05 at 07:55 -0800, Greg KH wrote:
> On Sun, Mar 05, 2006 at 11:18:04AM +0100, Arjan van de Ven wrote:
> > 
> > > +/* Main MC kobject release() function */
> > > +static void edac_memctrl_master_release(struct kobject *kobj)
> > > +{
> > > +	debugf1("EDAC MC: " __FILE__ ": %s()\n", __func__);
> > > +}
> > > +
> > 
> > ehhh how on earth can this be right?
> 
> Ugh.  Good catch, it isn't right.  Gotta love it when people try to
> ignore the helpful messages the kernel gives you when you use an API
> wrong :(


s/ignore/circumvent/



