Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263601AbUEWVRM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263601AbUEWVRM (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 23 May 2004 17:17:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263603AbUEWVRK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 23 May 2004 17:17:10 -0400
Received: from mx1.redhat.com ([66.187.233.31]:61580 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S263601AbUEWVQ7 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 23 May 2004 17:16:59 -0400
Date: Sun, 23 May 2004 17:14:02 -0400
From: Alan Cox <alan@redhat.com>
To: Jeff Garzik <jgarzik@pobox.com>
Cc: Willy Tarreau <willy@w.ods.org>, Christoph Hellwig <hch@alpha.home.local>,
       akpm@osdl.org, linux-kernel@vger.kernel.org, alan@redhat.com,
       vda@port.imtp.ilyichevsk.odessa.ua
Subject: Re: i486 emu in mainline?
Message-ID: <20040523211402.GB24714@devserv.devel.redhat.com>
References: <20040522234059.GA3735@infradead.org> <20040523082912.GA16071@alpha.home.local> <40B0C0C7.9090604@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <40B0C0C7.9090604@pobox.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, May 23, 2004 at 11:18:31AM -0400, Jeff Garzik wrote:
> >  - There are people (like Alan) who think that this should not go into
> >    mainline because this is a distro problem and nothing else. He says
> >    that only i386 packages should be installed on an i386 machine. He's
> >    perfectly right about this. I found it interesting for people like
> 
> 
> I disagree.
> 
> I want to add "old Alpha" emulation code, so that older Alphas can run 
> binaries built on the newer alphas.

Well it always depends on the platform. cmov emulation isnt useful because
i686 gcc generates too many for it to be of value. For alpha it depends
on the commonness of the emulated instructions and the emulation cost.

Either way it is a user space problem in almost all situations. See
http://www-sop.inria.fr/geometrica/team/Sylvain.Pion/progs/mmx-emu/

