Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751232AbWAVHjK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751232AbWAVHjK (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 22 Jan 2006 02:39:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751239AbWAVHjK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 22 Jan 2006 02:39:10 -0500
Received: from smtp.osdl.org ([65.172.181.4]:38378 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751232AbWAVHjJ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 22 Jan 2006 02:39:09 -0500
Date: Sat, 21 Jan 2006 23:38:39 -0800
From: Andrew Morton <akpm@osdl.org>
To: Kylene Jo Hall <kjhall@us.ibm.com>
Cc: ngc891@gmail.com, rmps@joel.ist.utl.pt, linux-kernel@vger.kernel.org,
       tpmdd-devel@lists.sourceforge.net
Subject: Re: [PATCH][2.6.16-rc1] TPM: tpm_bios needs securityfs
 (CONFIG_SECURITY)
Message-Id: <20060121233839.2aa99018.akpm@osdl.org>
In-Reply-To: <1137518808.4873.108.camel@localhost.localdomain>
References: <Pine.LNX.4.64.0601171359120.25253@joel.ist.utl.pt>
	<200601171700.k0HH0rAf000466@comet.localnet>
	<1137518808.4873.108.camel@localhost.localdomain>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Kylene Jo Hall <kjhall@us.ibm.com> wrote:
>
> Ack'ed-by: Kylene Hall <kjhall@us.ibm.com>
> 
> On Wed, 2006-01-18 at 02:00 +0900, Jerome Pinot wrote:
> > Hi,
> >  
> >  >It seems that "TPM Hardware Support" (CONFIG_TCG_TPM) depends on
> >  >"Enable different security models" (CONFIG_SECURITY).
> >  
> >  This does the trick but your patch formatting is broken. This one
> >  applies cleanly against 2.6.16-rc1.
> >  
> >  from: Rui Saraiva
> >  
> >  tpm_bios (CONFIG_TCG_TPM) depends on securityfs (CONFIG_SECURITY).
> >  
> >  Signed-off-by: Rui Saraiva <rmps@mail.pt>
> >  Signed-off-by: Jerome Pinot <ngc891@gmail.com>

No, this patch shouldn't be needed once we have the suitable security stubs
in place.

See
ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.16-rc1/2.6.16-rc1-mm2/broken-out/tpm_bios-needs-more-securityfs_-functions.patch
ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.16-rc1/2.6.16-rc1-mm2/broken-out/tpm_bios-securityfs-error-checking-fix.patch

