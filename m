Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316585AbSEaSov>; Fri, 31 May 2002 14:44:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316606AbSEaSou>; Fri, 31 May 2002 14:44:50 -0400
Received: from ns1.alcove-solutions.com ([212.155.209.139]:59301 "EHLO
	smtp-out.fr.alcove.com") by vger.kernel.org with ESMTP
	id <S316585AbSEaSor>; Fri, 31 May 2002 14:44:47 -0400
Date: Fri, 31 May 2002 20:44:42 +0200
From: Stelian Pop <stelian.pop@fr.alcove.com>
To: Greg KH <greg@kroah.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: USB host drivers test results (2.5.19) and problem.
Message-ID: <20020531184442.GB10621@come.alcove-fr>
Reply-To: Stelian Pop <stelian.pop@fr.alcove.com>
Mail-Followup-To: Stelian Pop <stelian.pop@fr.alcove.com>,
	Greg KH <greg@kroah.com>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <20020531133429.GF8310@come.alcove-fr> <21481.1022856842@redhat.com> <20020531163914.GB1250@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.25i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 31, 2002 at 09:39:14AM -0700, Greg KH wrote:

> > >  1. Shouldn't the ehci/ohci drivers give some error on loading, since
> > > I obviously don't have the hardware ? 
> > 
> > How do they know that? You could have it in your hand and be just about to
> > insert it.
> 
> They should not load, like any other pci driver that should not load if
> you don't have the hardware present for it.

What about the PCI hotplug case, as David suggested ?

Stelian.
-- 
Stelian Pop <stelian.pop@fr.alcove.com>
Alcove - http://www.alcove.com
