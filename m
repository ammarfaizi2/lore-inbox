Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S272328AbTG3XLV (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 30 Jul 2003 19:11:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272331AbTG3XLU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 30 Jul 2003 19:11:20 -0400
Received: from crosslink-village-512-1.bc.nu ([81.2.110.254]:3831 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP id S272328AbTG3XLT
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 30 Jul 2003 19:11:19 -0400
Subject: Re: TSCs are a no-no on i386
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Jan-Benedict Glaw <jbglaw@lug-owl.de>
Cc: lkml <linux-kernel@vger.kernel.org>
In-Reply-To: <20030730203318.GH1873@lug-owl.de>
References: <20030730135623.GA1873@lug-owl.de>
	 <20030730181006.GB21734@fs.tum.de> <20030730183033.GA970@matchmail.com>
	 <20030730184529.GE21734@fs.tum.de>
	 <1059595260.10447.6.camel@dhcp22.swansea.linux.org.uk>
	 <20030730203318.GH1873@lug-owl.de>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Organization: 
Message-Id: <1059606259.10505.20.camel@dhcp22.swansea.linux.org.uk>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 (1.2.2-5) 
Date: 31 Jul 2003 00:05:53 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mer, 2003-07-30 at 21:33, Jan-Benedict Glaw wrote:
> Well... For sure, I can write a LD_PRELOAD lib dealing with SIGILL, but
> how do I enable it for the whole system. That is, I'd need to give
> LD_PRELOAD=xxx at the kernel's boot prompt to have it as en environment
> variable for each and every process?


/etc/ld.preload

> That sounds a tad inelegant to me. Really, I'd prefer to see libstdc++
> be compiled for i386 ...

True


