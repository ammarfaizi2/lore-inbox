Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261648AbVGUNLk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261648AbVGUNLk (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 21 Jul 2005 09:11:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261667AbVGUNLk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 21 Jul 2005 09:11:40 -0400
Received: from mx1.redhat.com ([66.187.233.31]:43403 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S261648AbVGUNLj (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 21 Jul 2005 09:11:39 -0400
Date: Thu, 21 Jul 2005 09:11:32 -0400
From: Neil Horman <nhorman@redhat.com>
To: =?iso-8859-1?Q?M=E1rcio?= Oliveira <moliveira@latinsourcetech.com>
Cc: arjanv@redhat.com, linux-kernel@vger.kernel.org
Subject: Re: Memory Management
Message-ID: <20050721131132.GB11327@hmsendeavour.rdu.redhat.com>
References: <42DF9646.5070806@latinsourcetech.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <42DF9646.5070806@latinsourcetech.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 21, 2005 at 09:34:14AM -0300, Márcio Oliveira wrote:
> Arjan van de Ven wrote:
> 
> >On Wed, 2005-07-20 at 11:23 -0300, Márcio Oliveira wrote:
> > 
> >
> >>Arjan van de Ven wrote:
> >>
> >>   
> >>
> >>>I'm sure RH support will be able to help you with that; I doubt many
> >>>other people care about an ancient kernel like that, and a vendor one to
> >>>boot.
> >>>
> >>>(Also I assume you are using the -hugemem kernel as the documentation
> >>>recommends you to do)
> >>>
> >>>
> >>>
> >>>     
> >>>
> >>Arjan,
> >>
> >>  I'd like to know/understand more about memory management  on  Linux 
> >>Kernel and I belive this concept is applyable to the Red Hat Linux Kernel.
> >>   
> >>
> >
> >Only on the highest of levels. The RHEL3 kernel has a VM that resembles
> >almost no other linux kernel in many many ways. 
> >
> >
> > 
> >
> >> I have some doubts about the ZONE divison (DMA, NORMAL, HIGHMEM), 
> >>Shared Memory utilization, HugeTLB feature and OOM with large memory and 
> >>the kernel management of memory on SMP machines. I believe these 
> >>features are common to the Linux kernel in general(Red Hat, Debian, 
> >>SuSe, kernel.org), right?
> >>   
> >>
> >
> >nope. These things are very much different between the kernels you
> >mention.
> >
> >What do you want to use the knowledge for? Fixing the VM? Tuning your
> >server? The goal of your question determines what kind of answer you
> >want to your questions....
> > 
> >
> It's about tunning the VM parameters...
> 
> That's my first question on list:
> 
> "Is HugeTBL proc memory parameters only to hugetlbfs "filesystem" or are 
> these parameters affect ramfs, shm and tmpfs too?
> 
> What is the basic difference between ramfs, hugetlbfs, shm and tmpfs to 
> the memory management / process VLM utilization?
> 
> thanks,
> 
http://people.redhat.com/nhorman/papers/rhel3_vm.pdf
I wrote this with norm awhile back.  It may help you out.
Regards
Neil

> Márcio."
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/

-- 
/***************************************************
 *Neil Horman
 *Software Engineer
 *Red Hat, Inc.
 *nhorman@redhat.com
 *gpg keyid: 1024D / 0x92A74FA1
 *http://pgp.mit.edu
 ***************************************************/
