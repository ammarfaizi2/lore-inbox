Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264037AbSJWKJj>; Wed, 23 Oct 2002 06:09:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264146AbSJWKJj>; Wed, 23 Oct 2002 06:09:39 -0400
Received: from e6.ny.us.ibm.com ([32.97.182.106]:16512 "EHLO e6.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id <S264037AbSJWKJi>;
	Wed, 23 Oct 2002 06:09:38 -0400
Date: Wed, 23 Oct 2002 15:58:53 +0530
From: "Vamsi Krishna S ." <vamsi@in.ibm.com>
To: Jeff Garzik <jgarzik@pobox.com>
Cc: landley@trommello.org, Guillaume Boissiere <boissiere@adiglobal.com>,
       linux-kernel@vger.kernel.org
Subject: Re: Son of crunch time: the list v1.2.
Message-ID: <20021023155853.A28909@in.ibm.com>
Reply-To: vamsi@in.ibm.com
References: <20021021135137.2801edd2.rusty@rustcorp.com.au> <3DB3AB3E.23020.5FFF7144@localhost> <200210211536.25109.landley@trommello.org> <3DB4B1B9.4070303@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <3DB4B1B9.4070303@pobox.com>; from jgarzik@pobox.com on Tue, Oct 22, 2002 at 02:06:29AM +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 22, 2002 at 02:06:29AM +0000, Jeff Garzik wrote:
> 
> > 7) Dynamic Probes (dprobes team)
> > http://oss.software.ibm.com/developerworks/opensource/linux/projects/dprobes
> 
> why does this need to be the mainline kernel?  this is another type of 
> thing that can live as a patch, IMO...
> 
We are not proposing the entire dprobes patch to be in kernel. It doesn't
have to be. We are proposing for inclusion the "kprobes" patchset at
http://www-124.ibm.com/linux/patches/?project_id=141 which provides
the basic infrastructure in the kernel for setting up and handling
breakpoints automatically in kernel space. Once this small piece is in,
we can implement comprehensive tools like dynamic probes as external
kernel modules without having to patch the kernel. 

-- 
Vamsi Krishna S.
Linux Technology Center,
IBM Software Lab, Bangalore.
Ph: +91 80 5044959
Internet: vamsi@in.ibm.com
