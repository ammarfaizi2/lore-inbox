Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030184AbWJCSyG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030184AbWJCSyG (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 3 Oct 2006 14:54:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030362AbWJCSyG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 3 Oct 2006 14:54:06 -0400
Received: from e31.co.us.ibm.com ([32.97.110.149]:45543 "EHLO
	e31.co.us.ibm.com") by vger.kernel.org with ESMTP id S1030184AbWJCSyF
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 3 Oct 2006 14:54:05 -0400
Date: Tue, 3 Oct 2006 14:52:17 -0400
From: Vivek Goyal <vgoyal@in.ibm.com>
To: Dave Hansen <haveblue@us.ibm.com>
Cc: linux kernel mailing list <linux-kernel@vger.kernel.org>,
       Reloc Kernel List <fastboot@lists.osdl.org>, ebiederm@xmission.com,
       akpm@osdl.org, ak@suse.de, horms@verge.net.au, lace@jankratochvil.net,
       hpa@zytor.com, magnus.damm@gmail.com, lwang@redhat.com,
       dzickus@redhat.com, maneesh@in.ibm.com
Subject: Re: [PATCH 6/12] i386: CONFIG_PHYSICAL_START cleanup
Message-ID: <20061003185217.GA20347@in.ibm.com>
Reply-To: vgoyal@in.ibm.com
References: <20061003170032.GA30036@in.ibm.com> <20061003171531.GF3164@in.ibm.com> <1159901109.18746.9.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1159901109.18746.9.camel@localhost.localdomain>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 03, 2006 at 11:45:09AM -0700, Dave Hansen wrote:
> On Tue, 2006-10-03 at 13:15 -0400, Vivek Goyal wrote:
> > diff -puN arch/i386/boot/compressed/misc.c~i386-CONFIG_PHYSICAL_START-cleanup arch/i386/boot/compressed/misc.c
> > --- linux-2.6.18-git17/arch/i386/boot/compressed/misc.c~i386-CONFIG_PHYSICAL_START-cleanup      2006-10-02 13:17:58.000000000 -0400
> > +++ linux-2.6.18-git17-root/arch/i386/boot/compressed/misc.c    2006-10-02 14:33:44.000000000 -0400
> > @@ -9,11 +9,11 @@
> >   * High loaded stuff by Hans Lermen & Werner Almesberger, Feb. 1996
> >   */
> >  
> > +#include <linux/config.h>
> >  #include <linux/linkage.h>
> >  #include <linux/vmalloc.h>
> >  #include <linux/screen_info.h> 
> 
> Isn't config.h implicitly included everywhere by the build system now?
> I don't think this is needed.
>

You are right. I will get rid of it.

-Vivek
