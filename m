Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316235AbSEaQlH>; Fri, 31 May 2002 12:41:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316223AbSEaQlF>; Fri, 31 May 2002 12:41:05 -0400
Received: from 12-224-36-73.client.attbi.com ([12.224.36.73]:16137 "HELO
	kroah.com") by vger.kernel.org with SMTP id <S316289AbSEaQlB>;
	Fri, 31 May 2002 12:41:01 -0400
Date: Fri, 31 May 2002 09:39:14 -0700
From: Greg KH <greg@kroah.com>
To: David Woodhouse <dwmw2@infradead.org>
Cc: Stelian Pop <stelian.pop@fr.alcove.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: USB host drivers test results (2.5.19) and problem.
Message-ID: <20020531163914.GB1250@kroah.com>
In-Reply-To: <20020531133429.GF8310@come.alcove-fr> <21481.1022856842@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4i
X-Operating-System: Linux 2.2.21 (i586)
Reply-By: Fri, 03 May 2002 14:47:14 -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 31, 2002 at 03:54:02PM +0100, David Woodhouse wrote:
> 
> stelian.pop@fr.alcove.com said:
> >  1. Shouldn't the ehci/ohci drivers give some error on loading, since
> > I obviously don't have the hardware ? 
> 
> How do they know that? You could have it in your hand and be just about to
> insert it.

They should not load, like any other pci driver that should not load if
you don't have the hardware present for it.

thanks,

greg k-h
