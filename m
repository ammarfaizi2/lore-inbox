Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263971AbTE3UVY (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 30 May 2003 16:21:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263976AbTE3UVY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 30 May 2003 16:21:24 -0400
Received: from pc2-cwma1-4-cust86.swan.cable.ntl.com ([213.105.254.86]:3038
	"EHLO lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP
	id S263971AbTE3UVX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 30 May 2003 16:21:23 -0400
Subject: Re: Problem Installing Linux Kernel Module compiled with gcc-3.2.x
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Joe Buck <jbuck@synopsys.com>
Cc: Bernd Jendrissek <berndj@prism.co.za>,
       Kendrick Hamilton <hamilton@sedsystems.ca>, gcc@gcc.gnu.org,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <20030530120231.A1328@synopsys.com>
References: <Pine.LNX.4.44.0305300919510.3613-100000@sw-55.sedsystems.ca>
	 <20030530192240.A7564@prism.co.za> <20030530103329.A848@synopsys.com>
	 <20030530204332.C7564@prism.co.za>  <20030530120231.A1328@synopsys.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Organization: 
Message-Id: <1054323389.23566.56.camel@dhcp22.swansea.linux.org.uk>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 (1.2.2-5) 
Date: 30 May 2003 20:36:30 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Gwe, 2003-05-30 at 20:02, Joe Buck wrote:
> > Between GCC 2.x and 3.x the *major* version changed (duh).  I would
> > imagine that people are/were (justifiably?) concerned that ABI's might
> > have changed.  From your response, I assume there are no ABI changes
> > for C at least?  I suppose a gratuitous ABI change would constitute a
> > bug, though...
> 
> There are no ABI changes for C.

Not quite true but close. The padding in gcc 2.96 however is actually to
work around a compiler bug

