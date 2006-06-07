Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932109AbWFGJnh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932109AbWFGJnh (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 7 Jun 2006 05:43:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932113AbWFGJnh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 7 Jun 2006 05:43:37 -0400
Received: from ogre.sisk.pl ([217.79.144.158]:54491 "EHLO ogre.sisk.pl")
	by vger.kernel.org with ESMTP id S932109AbWFGJng (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 7 Jun 2006 05:43:36 -0400
From: "Rafael J. Wysocki" <rjw@sisk.pl>
To: Pavel Machek <pavel@ucw.cz>
Subject: Re: klibc (was: 2.6.18 -mm merge plans)
Date: Wed, 7 Jun 2006 11:44:01 +0200
User-Agent: KMail/1.9.3
Cc: "H. Peter Anvin" <hpa@zytor.com>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org
References: <20060604135011.decdc7c9.akpm@osdl.org> <200606062256.55472.rjw@sisk.pl> <20060607084455.GA7399@elf.ucw.cz>
In-Reply-To: <20060607084455.GA7399@elf.ucw.cz>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200606071144.01717.rjw@sisk.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 07 June 2006 10:44, Pavel Machek wrote:
> > > > The original idea was due Al Viro; obviously, the 
> > > > implementation is mostly mine.
> > > > 
> > > > It is of course my hope that this will be used for more 
> > > > than just plain initialization code, but that in itself 
> > > > is a significant step, and one has to start somewhere.
> > > 
> > > It allows me to unify swsusp & uswsusp into one in future, for
> > > example, reducing code duplication.
> > 
> > [cough] How distant is the future you're referring to?
> 
> Year or two, I believe. Actually it is not as much as "unify swsusp &
> uswsusp" as "drop kernel/power/swap.c" and possibly put parts of
> uswsusp into initial userland so that user do not notice it was
> dropped from kernel.

OK

Rafael
