Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262386AbTIHOmf (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 8 Sep 2003 10:42:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262420AbTIHOme
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 8 Sep 2003 10:42:34 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:3792 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S262386AbTIHOmd
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 8 Sep 2003 10:42:33 -0400
Date: Mon, 8 Sep 2003 15:42:32 +0100
From: Matthew Wilcox <willy@debian.org>
To: Jeff Garzik <jgarzik@pobox.com>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, David Woodhouse <dwmw2@infradead.org>,
       Matthew Wilcox <willy@debian.org>,
       Erik Andersen <andersen@codepoet.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: kernel header separation
Message-ID: <20030908144232.GP18654@parcelfarce.linux.theplanet.co.uk>
References: <20030902191614.GR13467@parcelfarce.linux.theplanet.co.uk> <20030903014908.GB1601@codepoet.org> <20030905144154.GL18654@parcelfarce.linux.theplanet.co.uk> <20030905211604.GB16993@codepoet.org> <20030905232212.GP18654@parcelfarce.linux.theplanet.co.uk> <1063028303.32473.333.camel@hades.cambridge.redhat.com> <1063030329.21310.32.camel@dhcp23.swansea.linux.org.uk> <20030908142545.GA3926@gtf.org> <20030908143249.GA4462@gtf.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030908143249.GA4462@gtf.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 08, 2003 at 10:32:49AM -0400, Jeff Garzik wrote:
> On Mon, Sep 08, 2003 at 10:25:45AM -0400, Jeff Garzik wrote:
> > Whenever I see "__u8", I think "non-standard, gcc-specific dependency"
> 
> Ignore this, I stand corrected:  these are kernel types.
> 
> Regardless, I still prefer the C99 size-specific types, as they are the
> most portable across all compilers, and you can depend on the compiler
> to provide them for you.  No need to define them yourself.

bzzt.  glibc provides them, not gcc.

-- 
"It's not Hollywood.  War is real, war is primarily not about defeat or
victory, it is about death.  I've seen thousands and thousands of dead bodies.
Do you think I want to have an academic debate on this subject?" -- Robert Fisk
