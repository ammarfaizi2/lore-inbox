Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261704AbVCUTHx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261704AbVCUTHx (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 21 Mar 2005 14:07:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261762AbVCUTHx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 21 Mar 2005 14:07:53 -0500
Received: from mx1.redhat.com ([66.187.233.31]:58311 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S261704AbVCUTH2 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 21 Mar 2005 14:07:28 -0500
Date: Mon, 21 Mar 2005 20:07:21 +0100
From: Arjan van de Ven <arjanv@redhat.com>
To: jmerkey <jmerkey@utah-nac.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: clone() and pthread_create() segment fault in 2.4.29
Message-ID: <20050321190721.GA19194@devserv.devel.redhat.com>
References: <423F13EA.6050007@utah-nac.org> <1111431021.6952.73.camel@laptopd505.fenrus.org> <423F1852.3070902@utah-nac.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <423F1852.3070902@utah-nac.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 21, 2005 at 11:54:10AM -0700, jmerkey wrote:
> Arjan van de Ven wrote:
> 
> >On Mon, 2005-03-21 at 11:35 -0700, jmerkey wrote:
> > 
> >
> >>In case nobody has already reported it, clone() and pthread_create() 
> >>return SIGSEGV faults
> >>when a 2.4.29 kernel on the Taroon Red Hat release.
> >>   
> >>
> >
> >you're running an OS that requires a kernel with NPTL support. Yet you
> >run a kernel without. Bad idea.
> >
> >
> > 
> >
> which 2.4 kernels will work properly on RH ES release 3, Taroon Update 
> 4. 

Only kernels with NPTL in, which for 2.4 limits you to the RH supplied one.
