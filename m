Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964926AbWFATTI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964926AbWFATTI (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 1 Jun 2006 15:19:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965280AbWFATTI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 1 Jun 2006 15:19:08 -0400
Received: from smtp1.xs4all.be ([195.144.64.135]:14791 "EHLO smtp1.xs4all.be")
	by vger.kernel.org with ESMTP id S964926AbWFATTH (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 1 Jun 2006 15:19:07 -0400
Date: Thu, 1 Jun 2006 21:18:40 +0200
From: Frank Gevaerts <frank.gevaerts@fks.be>
To: Greg KH <gregkh@suse.de>
Cc: Frank Gevaerts <frank.gevaerts@fks.be>, Pete Zaitcev <zaitcev@redhat.com>,
       lcapitulino@mandriva.com.br, linux-kernel@vger.kernel.org,
       linux-usb-devel@lists.sourceforge.net
Subject: Re: [PATCH] ipaq.c bugfixes
Message-ID: <20060601191840.GB1757@fks.be>
References: <20060529193330.3c51f3ba@home.brethil> <20060530082141.GA26517@fks.be> <20060530113801.22c71afe@doriath.conectiva> <20060530115329.30184aa0@doriath.conectiva> <20060530174821.GA15969@fks.be> <20060530113327.297aceb7.zaitcev@redhat.com> <20060531213828.GA17711@fks.be> <20060531215523.GA13745@suse.de> <20060531224245.GB17711@fks.be> <20060531224624.GA17667@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060531224624.GA17667@suse.de>
User-Agent: Mutt/1.5.9i
X-FKS-MailScanner: Found to be clean
X-FKS-MailScanner-SpamCheck: geen spam, SpamAssassin (score=-105.816,
	vereist 5, autolearn=not spam, ALL_TRUSTED -3.30, AWL 0.08,
	BAYES_00 -2.60, USER_IN_WHITELIST -100.00)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 31, 2006 at 03:46:24PM -0700, Greg KH wrote:
> On Thu, Jun 01, 2006 at 12:42:45AM +0200, Frank Gevaerts wrote:
> > +
> > +module_param(connect_retries, int, KP_RETRIES);
> 
> I really do not think that you want KP_RETRIES as a mode value in sysfs
> :)
> 
> This is not how you pre-initialize a module parameter...

Thanks. That should teach me not to try to fix kernel code without
reading documentation. I fixed it here, but I won't resubmit yet because
there are some 100% reproducible bugs left. 

Frank

> 
> thanks,
> 
> greg k-h

-- 
Frank Gevaerts                                 frank.gevaerts@fks.be
fks bvba - Formal and Knowledge Systems        http://www.fks.be/
Stationsstraat 108                             Tel:  ++32-(0)11-21 49 11
B-3570 ALKEN                                   Fax:  ++32-(0)11-22 04 19
