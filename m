Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269507AbUIZKht@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269507AbUIZKht (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 26 Sep 2004 06:37:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269505AbUIZKht
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 26 Sep 2004 06:37:49 -0400
Received: from arnor.apana.org.au ([203.14.152.115]:53253 "EHLO
	arnor.apana.org.au") by vger.kernel.org with ESMTP id S269503AbUIZKhq
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 26 Sep 2004 06:37:46 -0400
From: Herbert Xu <herbert@gondor.apana.org.au>
To: James.Bottomley@SteelEye.com (James Bottomley)
Subject: Re: [RFC] put symbolic links between drivers and modules in the	sysfs tree
Cc: viro@parcelfarce.linux.theplanet.co.uk, greg@kroah.com,
       rusty@rustcorp.com.au, linux-kernel@vger.kernel.org,
       linux-scsi@vger.kernel.org
Organization: Core
In-Reply-To: <1096118081.1715.3.camel@mulgrave>
X-Newsgroups: apana.lists.os.linux.kernel,apana.lists.os.linux.scsi
User-Agent: tin/1.7.4-20040225 ("Benbecula") (UNIX) (Linux/2.4.27-hx-1-686-smp (i686))
Message-Id: <E1CBWOq-0007t6-00@gondolin.me.apana.org.au>
Date: Sun, 26 Sep 2004 20:37:00 +1000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

James Bottomley <James.Bottomley@steeleye.com> wrote:
>
>> So what will your userland code do when you run it on a system with
>> non-modular kernel currently running?
> 
> Not put a module in the initial ramdisk, since it would be unnecessary. 
> The only information the patch seeks to add is the linkage between
> driver and module.  So you can work back from sysfs to know which
> devices have which modules

You're assuming that the kernel before/after the reboot have the same
configuration.  This is false in general.
-- 
Visit Openswan at http://www.openswan.org/
Email: Herbert Xu ~{PmV>HI~} <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
