Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315374AbSEaPHq>; Fri, 31 May 2002 11:07:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315375AbSEaPHp>; Fri, 31 May 2002 11:07:45 -0400
Received: from ns1.alcove-solutions.com ([212.155.209.139]:54422 "EHLO
	smtp-out.fr.alcove.com") by vger.kernel.org with ESMTP
	id <S315374AbSEaPHp>; Fri, 31 May 2002 11:07:45 -0400
Date: Fri, 31 May 2002 17:07:40 +0200
From: Stelian Pop <stelian.pop@fr.alcove.com>
To: David Woodhouse <dwmw2@infradead.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: USB host drivers test results (2.5.19) and problem.
Message-ID: <20020531150740.GG8310@come.alcove-fr>
Reply-To: Stelian Pop <stelian.pop@fr.alcove.com>
Mail-Followup-To: Stelian Pop <stelian.pop@fr.alcove.com>,
	David Woodhouse <dwmw2@infradead.org>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <20020531133429.GF8310@come.alcove-fr> <21481.1022856842@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.25i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 31, 2002 at 03:54:02PM +0100, David Woodhouse wrote:

> >  1. Shouldn't the ehci/ohci drivers give some error on loading, since
> > I obviously don't have the hardware ? 
> 
> How do they know that? You could have it in your hand and be just about to
> insert it.

PCI hotplug ? I fergot about that one...

However, maybe even a hotplug aware driver should print out a message
upon initialization telling 'no hardware found'... It could be useful
when you want to know the difference between: 
	* bad driver, use another one
	* good driver, but doesn't recognize/init the hardware because it's buggy.

Stelian.
-- 
Stelian Pop <stelian.pop@fr.alcove.com>
Alcove - http://www.alcove.com
