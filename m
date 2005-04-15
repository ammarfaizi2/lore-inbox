Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261942AbVDOVuV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261942AbVDOVuV (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 15 Apr 2005 17:50:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261943AbVDOVuU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 15 Apr 2005 17:50:20 -0400
Received: from zproxy.gmail.com ([64.233.162.195]:49654 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261942AbVDOVuP convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 15 Apr 2005 17:50:15 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=G84diO9ytaOHEWwZo2vvp6tXd8FU7aEUDj3WBV/dbEGlfIhx4zvqicgKpdGohIwj2QyBcOkd9734N1WwY2jl/pnOoCiaOihFz7n9v7Kk3/E3OjinbunRmHi1SR8+AUq6JKk69sA8CgNZ/cSn9d8z/ngJ51nPS92ZAEg7b/fSllQ=
Message-ID: <29495f1d050415144774ec9c44@mail.gmail.com>
Date: Fri, 15 Apr 2005 14:47:41 -0700
From: Nish Aravamudan <nish.aravamudan@gmail.com>
Reply-To: Nish Aravamudan <nish.aravamudan@gmail.com>
To: Kylene Hall <kjhall@us.ibm.com>
Subject: Re: [PATCH] char/tpm: use msleep(), clean-up timers, fix typo
Cc: Nishanth Aravamudan <nacc@us.ibm.com>, linux-kernel@vger.kernel.org
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

Kylene, there is no entry in MAINTAINERS as of 2.6.12-rc2 for the TPM
driver? Should there be?

I am assuming tpmdd_devel can take care of merging the patch and
pushing to mainline? Please do so.

Thanks,
Nish
