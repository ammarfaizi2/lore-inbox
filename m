Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264673AbSJ3O0D>; Wed, 30 Oct 2002 09:26:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264678AbSJ3O0D>; Wed, 30 Oct 2002 09:26:03 -0500
Received: from ns1.alcove-solutions.com ([212.155.209.139]:20710 "EHLO
	smtp-out.fr.alcove.com") by vger.kernel.org with ESMTP
	id <S264673AbSJ3O0C>; Wed, 30 Oct 2002 09:26:02 -0500
Date: Wed, 30 Oct 2002 15:32:18 +0100
From: Stelian Pop <stelian.pop@fr.alcove.com>
To: Ben Collins <bcollins@debian.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       linux1394-devel@lists.sourceforge.net
Subject: Re: [PATCH 2.5.bk] allow sbp2 driver to compile again
Message-ID: <20021030143218.GH17103@tahoe.alcove-fr>
Reply-To: Stelian Pop <stelian.pop@fr.alcove.com>
Mail-Followup-To: Stelian Pop <stelian.pop@fr.alcove.com>,
	Ben Collins <bcollins@debian.org>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	linux1394-devel@lists.sourceforge.net
References: <20021030141338.GF17103@tahoe.alcove-fr> <20021030142611.GG1521@phunnypharm.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20021030142611.GG1521@phunnypharm.org>
User-Agent: Mutt/1.3.25i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 30, 2002 at 09:26:12AM -0500, Ben Collins wrote:

> On Wed, Oct 30, 2002 at 03:13:38PM +0100, Stelian Pop wrote:
> > Hi,
> > 
> > The attached patch is required to make the sbp2 compile again.
> > 
> > Note however that, until 2.5.45 is released, one should tweak 
> > the Makefile to manually change the version in order to get
> > the KERNEL_VERSION tests work...
> 
> You're going to need to diff this against our SVN tree, or wait till I
> resync with 2.5.45. Seems it depends on patches in BK against our stock
> source.

Sure, no problem, it's a two-liner...

While we are at it, there are a lot of 'bad: scheduling while atomic!'
and 'sleeping function called from illegal context' when loading
the ohci1394/sbp2 drivers (detailed stack available when compiling
with CONFIG_DEBUG_KERNEL)...

Stelian.
-- 
Stelian Pop <stelian.pop@fr.alcove.com>
Alcove - http://www.alcove.com
