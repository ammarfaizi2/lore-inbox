Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261609AbVDOVrS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261609AbVDOVrS (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 15 Apr 2005 17:47:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261942AbVDOVrR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 15 Apr 2005 17:47:17 -0400
Received: from zproxy.gmail.com ([64.233.162.207]:48872 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261609AbVDOVrM convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 15 Apr 2005 17:47:12 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=ALalLphrqU/Xop7Gq39ApTaDjmhSqB41mB2UF45jarmdu97teuW06uOQWrv7fxJx8AfexR70RaFFvPlNADXI4U67ojAYHbtg6N+JIOMrfG0t0xaCVeM2GvzgYsNpJpdnOKSyWNB814vg2G/fl1edbyX3PDpSeh7ysrl3cRoQYwc=
Message-ID: <29495f1d05041514474e17a2da@mail.gmail.com>
Date: Fri, 15 Apr 2005 14:47:11 -0700
From: Nish Aravamudan <nish.aravamudan@gmail.com>
Reply-To: Nish Aravamudan <nish.aravamudan@gmail.com>
To: Greg KH <greg@kroah.com>
Subject: Re: [PATCH] char/tpm: use msleep(), clean-up timers, fix typo
Cc: Kylene Hall <kjhall@us.ibm.com>, Nishanth Aravamudan <nacc@us.ibm.com>,
       linux-kernel@vger.kernel.org
In-Reply-To: <20050415210402.GA22834@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <20050310004115.GA32583@kroah.com> <1110415321526@kroah.com>
	 <20050311181816.GC2595@us.ibm.com>
	 <Pine.LNX.4.61.0504151522210.24192@dyn95395164>
	 <29495f1d0504151344a33ee24@mail.gmail.com>
	 <20050415210402.GA22834@kroah.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/15/05, Greg KH <greg@kroah.com> wrote:
> On Fri, Apr 15, 2005 at 01:44:55PM -0700, Nish Aravamudan wrote:
> > On 4/15/05, Kylene Hall <kjhall@us.ibm.com> wrote:
> > > I have tested this patch and agree that using msleep is the right.  Please
> > > apply this patch to the tpm driver.  One hunk might fail b/c the
> > > typo has been fixed already.
> >
> > Would you like me to respin the patch, Greg? Or is the failed hunk ok?
> 
> I'm sorry, but I am not in charge of accepting patches for the tpm
> driver.  Why not go through the listed maintainer for this process, they
> should know how to get it into the mainline kernel tree properly.  If
> not, why would they be listed as the maintainer?  :)

Sorry about that Greg, I was just mixed-up since you had pushed the
original patch in; my fault. Will remove you from my other reply.

Thanks,
Nish
