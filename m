Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264766AbUEYNti@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264766AbUEYNti (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 25 May 2004 09:49:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264846AbUEYNth
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 25 May 2004 09:49:37 -0400
Received: from mx1.redhat.com ([66.187.233.31]:2517 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S264766AbUEYNtb (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 25 May 2004 09:49:31 -0400
Date: Tue, 25 May 2004 09:48:15 -0400
From: Alan Cox <alan@redhat.com>
To: Alan Cox <alan@redhat.com>, Willy Tarreau <willy@w.ods.org>,
       Christoph Hellwig <hch@alpha.home.local>, akpm@osdl.org,
       linux-kernel@vger.kernel.org, vda@port.imtp.ilyichevsk.odessa.ua
Subject: Re: i486 emu in mainline?
Message-ID: <20040525134815.GA10958@devserv.devel.redhat.com>
References: <20040522234059.GA3735@infradead.org> <20040523082912.GA16071@alpha.home.local> <20040523110836.GE25746@devserv.devel.redhat.com> <20040523115735.GA16726@alpha.home.local> <20040523131512.GA25185@devserv.devel.redhat.com> <20040524151715.GS1912@lug-owl.de> <20040524174156.GG19161@devserv.devel.redhat.com> <20040525093652.GA1912@lug-owl.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040525093652.GA1912@lug-owl.de>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 25, 2004 at 11:36:52AM +0200, Jan-Benedict Glaw wrote:
> > No. The LD_PRELOAD also hooks the signal setting functions. This really is
> > not rocket science at all. 
> 
> But works only on dynamically linkes executables, and only on those that
> don't do system calls on their own, right?

If it is static linked to glibc or libc5 then you have the source or the
bits to relink it. 

You can build an app to deliberately break software emulation, but that goes
for kernel mode too and isn't the problem you *actually* want to solve

