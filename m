Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262531AbSI0S5N>; Fri, 27 Sep 2002 14:57:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262576AbSI0S5N>; Fri, 27 Sep 2002 14:57:13 -0400
Received: from pc1-cwma1-5-cust51.swa.cable.ntl.com ([80.5.120.51]:24311 "EHLO
	irongate.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S262531AbSI0S5L>; Fri, 27 Sep 2002 14:57:11 -0400
Subject: Re: [PATCH] fix drm ioctl ABI default
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Christoph Hellwig <hch@sgi.com>
Cc: Marcelo Tosatti <marcelo@conectiva.com.br>, linux-kernel@vger.kernel.org
In-Reply-To: <20020927212752.E4733@sgi.com>
References: <20020927212752.E4733@sgi.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-10) 
Date: 27 Sep 2002 20:07:54 +0100
Message-Id: <1033153674.16726.10.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2002-09-28 at 02:27, Christoph Hellwig wrote:
> Add a config option to make the i810 drm ioctl ABI XFree4.1 compatible
> by default (currently that's a module parameter).  The XFree folks fucked
> this up by adding members in the middle of a struct and we have to work
> around it now.  At least we should have the pre-2.4.20 behaviour as default.
> (And I'd suggest you add that option as y to the defconfig)

With all the vendors now shipping 4.2 this seems a bad thing to default
to the 4,1 interface - especially as the 4.1 server is

o Buggy
o Has security holes that are fixed in 4.2.1 only

Alan

