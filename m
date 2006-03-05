Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932136AbWCEKa2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932136AbWCEKa2 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 5 Mar 2006 05:30:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932178AbWCEKa2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 5 Mar 2006 05:30:28 -0500
Received: from pentafluge.infradead.org ([213.146.154.40]:15796 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S932136AbWCEKa1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 5 Mar 2006 05:30:27 -0500
Subject: Re: [PATCH] EDAC: core EDAC support code
From: Arjan van de Ven <arjan@infradead.org>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Cc: torvalds@osdl.org, alan@redhat.com, gregkh@kroah.com
In-Reply-To: <1141553885.16388.0.camel@laptopd505.fenrus.org>
References: <200601190414.k0J4EZCV021775@hera.kernel.org>
	 <1141553885.16388.0.camel@laptopd505.fenrus.org>
Content-Type: text/plain
Date: Sun, 05 Mar 2006 11:30:25 +0100
Message-Id: <1141554625.16388.2.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <arjan@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2006-03-05 at 11:18 +0100, Arjan van de Ven wrote:
> > +/* Main MC kobject release() function */
> > +static void edac_memctrl_master_release(struct kobject *kobj)
> > +{
> > +	debugf1("EDAC MC: " __FILE__ ": %s()\n", __func__);
> > +}
> > +
> 
> 
> 
> ehhh how on earth can this be right?


oh and this stuff also violates the "one value per file" rule; can we
fix that urgently before it becomes part of the ABI in 2.6.16??


