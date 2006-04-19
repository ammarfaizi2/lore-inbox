Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751218AbWDSUyq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751218AbWDSUyq (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 19 Apr 2006 16:54:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751243AbWDSUyq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 19 Apr 2006 16:54:46 -0400
Received: from pentafluge.infradead.org ([213.146.154.40]:57279 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S1751218AbWDSUyp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 19 Apr 2006 16:54:45 -0400
Subject: Re: Time to remove LSM (was Re: [RESEND][RFC][PATCH 2/7]
	implementation of LSM hooks)
From: Arjan van de Ven <arjan@infradead.org>
To: "Randy.Dunlap" <rdunlap@xenotime.net>
Cc: Greg KH <greg@kroah.com>, jengelh@linux01.gwdg.de, jmorris@namei.org,
       hch@infradead.org, akpm@osdl.org, sds@tycho.nsa.gov, edwin@gurde.com,
       linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org,
       chrisw@sous-sol.org, torvalds@osdl.org
In-Reply-To: <20060419135207.dfc2d8ee.rdunlap@xenotime.net>
References: <200604142301.10188.edwin@gurde.com>
	 <1145290013.8542.141.camel@moss-spartans.epoch.ncsc.mil>
	 <20060417162345.GA9609@infradead.org>
	 <1145293404.8542.190.camel@moss-spartans.epoch.ncsc.mil>
	 <20060417173319.GA11506@infradead.org>
	 <Pine.LNX.4.64.0604171454070.17563@d.namei>
	 <20060417195146.GA8875@kroah.com>
	 <Pine.LNX.4.61.0604191010300.12755@yvahk01.tjqt.qr>
	 <1145462454.3085.62.camel@laptopd505.fenrus.org>
	 <Pine.LNX.4.61.0604192102001.7177@yvahk01.tjqt.qr>
	 <20060419201154.GB20545@kroah.com>
	 <20060419135207.dfc2d8ee.rdunlap@xenotime.net>
Content-Type: text/plain
Date: Wed, 19 Apr 2006 22:54:30 +0200
Message-Id: <1145480071.3085.103.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <arjan@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2006-04-19 at 13:52 -0700, Randy.Dunlap wrote:
> On Wed, 19 Apr 2006 13:11:54 -0700 Greg KH wrote:
> 
> > On Wed, Apr 19, 2006 at 09:06:57PM +0200, Jan Engelhardt wrote:
> > > >> 
> > > >> Well then, have a look at http://alphagate.hopto.org/multiadm/
> > > >> 
> > > >
> > > >hmm on first sight that seems to be basically an extension to the
> > > >existing capability() code... rather than a 'real' LSM module. Am I
> > > >missing something here?
> > > >
> > > 
> > > (So what's the definition for a "real" LSM module?)
> > 
> > No idea, try submitting the patch :)
> 
> hrm, I guess the smiley is supposed to help??
> 
> surely someone knows that it takes to qualify as a "real"
> LSM module.  

ok for me it would be "implements it's own security_ops vector" as
criterium. 

