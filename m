Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269276AbUIYIFy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269276AbUIYIFy (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 25 Sep 2004 04:05:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269281AbUIYIFy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 25 Sep 2004 04:05:54 -0400
Received: from arnor.apana.org.au ([203.14.152.115]:28173 "EHLO
	arnor.apana.org.au") by vger.kernel.org with ESMTP id S269276AbUIYIFt
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 25 Sep 2004 04:05:49 -0400
From: Herbert Xu <herbert@gondor.apana.org.au>
To: viro@parcelfarce.linux.theplanet.co.uk
Subject: Re: [RFC] put symbolic links between drivers and modules in the sysfs tree
Cc: James.Bottomley@steeleye.com, greg@kroah.com, rusty@rustcorp.com.au,
       linux-kernel@vger.kernel.org, linux-scsi@vger.kernel.org
Organization: Core
In-Reply-To: <20040925073819.GT23987@parcelfarce.linux.theplanet.co.uk>
X-Newsgroups: apana.lists.os.linux.kernel,apana.lists.os.linux.scsi
User-Agent: tin/1.7.4-20040225 ("Benbecula") (UNIX) (Linux/2.4.27-hx-1-686-smp (i686))
Message-Id: <E1CB7YE-0004cA-00@gondolin.me.apana.org.au>
Date: Sat, 25 Sep 2004 18:05:03 +1000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

viro@parcelfarce.linux.theplanet.co.uk wrote:
> On Mon, Sep 20, 2004 at 01:29:44PM -0400, James Bottomley wrote:
>> This functionality is essential for us to work out which drivers are
>> supplied by which modules.  We use this in turn to work out which
>> modules are necessary to find the root device (and hence what
>> initrd/initramfs needs to insert).
> 
> So what will your userland code do when you run it on a system with
> non-modular kernel currently running?

Totally agreed.  If we didn't care about built-in drivers, then we might
as well do cat /proc/modules.

BTW, I'm very glad that this is being worked on and that table in Debian's
mkinitrd can finally die.

Cheers,
-- 
Visit Openswan at http://www.openswan.org/
Email: Herbert Xu ~{PmV>HI~} <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
