Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264656AbUEXRmF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264656AbUEXRmF (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 24 May 2004 13:42:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264658AbUEXRmF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 24 May 2004 13:42:05 -0400
Received: from mx1.redhat.com ([66.187.233.31]:52894 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S264656AbUEXRmC (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 24 May 2004 13:42:02 -0400
Date: Mon, 24 May 2004 13:41:56 -0400
From: Alan Cox <alan@redhat.com>
To: Alan Cox <alan@redhat.com>, Willy Tarreau <willy@w.ods.org>,
       Christoph Hellwig <hch@alpha.home.local>, akpm@osdl.org,
       linux-kernel@vger.kernel.org, vda@port.imtp.ilyichevsk.odessa.uay
Subject: Re: i486 emu in mainline?
Message-ID: <20040524174156.GG19161@devserv.devel.redhat.com>
References: <20040522234059.GA3735@infradead.org> <20040523082912.GA16071@alpha.home.local> <20040523110836.GE25746@devserv.devel.redhat.com> <20040523115735.GA16726@alpha.home.local> <20040523131512.GA25185@devserv.devel.redhat.com> <20040524151715.GS1912@lug-owl.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040524151715.GS1912@lug-owl.de>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 24, 2004 at 05:17:15PM +0200, Jan-Benedict Glaw wrote:
> There are some application that register signal handling functions IIRC
> for SIGILL, SIGSEGV and the like to do internal error trapping on their
> own (not only OOo comes to mind). These would probably be f*cked up if they
> didn't call the LD_PRELOADed signal handler...

No. The LD_PRELOAD also hooks the signal setting functions. This really is
not rocket science at all. 

