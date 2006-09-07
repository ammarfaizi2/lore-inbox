Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751779AbWIGRdU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751779AbWIGRdU (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 7 Sep 2006 13:33:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751780AbWIGRdU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 7 Sep 2006 13:33:20 -0400
Received: from e33.co.us.ibm.com ([32.97.110.151]:23470 "EHLO
	e33.co.us.ibm.com") by vger.kernel.org with ESMTP id S1751779AbWIGRdS
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 7 Sep 2006 13:33:18 -0400
Subject: Re: 2.6.18-rc5-mm1
From: keith mannthey <kmannth@us.ibm.com>
Reply-To: kmannth@us.ibm.com
To: Andrew Morton <akpm@osdl.org>
Cc: Maciej Rutecki <maciej.rutecki@gmail.com>,
       Bjorn Helgaas <bjorn.helgaas@hp.com>,
       lkml <linux-kernel@vger.kernel.org>,
       linux acpi <linux-acpi@vger.kernel.org>,
       KAMEZAWA Hiroyuki <kamezawa.hiroyu@jp.fujitsu.com>
In-Reply-To: <20060906200824.4f74f221.akpm@osdl.org>
References: <20060901015818.42767813.akpm@osdl.org>
	 <44F86282.9010809@gmail.com> <200609051016.40468.bjorn.helgaas@hp.com>
	 <44FEFD6F.4020203@gmail.com>  <20060906200824.4f74f221.akpm@osdl.org>
Content-Type: text/plain; charset=utf-8
Organization: Linux Technology Center IBM
Date: Thu, 07 Sep 2006 10:33:14 -0700
Message-Id: <1157650394.5653.21.camel@keithlap>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 (2.0.4-4) 
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2006-09-06 at 20:08 -0700, Andrew Morton wrote:
> On Wed, 06 Sep 2006 18:55:11 +0200
> Maciej Rutecki <maciej.rutecki@gmail.com> wrote:
> 
> > Bjorn Helgaas napisał(a):
> > > 
> > > This ACPI "unknown exception code" problem is the same one reported here:
> > >   http://www.mail-archive.com/linux-acpi%40vger.kernel.org/msg02873.html
> > > 
> > > Basically, we just need to revert this:
> > >   http://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.18-rc4/2.6.18-rc4-mm3/broken-out/hot-add-mem-x86_64-acpi-motherboard-fix.patch
> > > 
> > Thanks it works.
> > 
> 
> So...  should I drop that patch?

Yes please drop this patch.  
  I dislike breaking my boxes functionality without a consensus for the
right fix is but it appears to be breaking others.  The discussion about
what the right fix is ongoing with no definitive direction. At a minimum
this patch will need to be updated. 

Thanks,
  Keith 

