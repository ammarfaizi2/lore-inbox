Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262564AbSI0TCq>; Fri, 27 Sep 2002 15:02:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262569AbSI0TCq>; Fri, 27 Sep 2002 15:02:46 -0400
Received: from tolkor.sgi.com ([198.149.18.6]:49341 "EHLO tolkor.sgi.com")
	by vger.kernel.org with ESMTP id <S262564AbSI0TCj>;
	Fri, 27 Sep 2002 15:02:39 -0400
Date: Fri, 27 Sep 2002 22:21:59 -0400
From: Christoph Hellwig <hch@sgi.com>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Marcelo Tosatti <marcelo@conectiva.com.br>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] fix drm ioctl ABI default
Message-ID: <20020927222159.A5124@sgi.com>
Mail-Followup-To: Christoph Hellwig <hch@sgi.com>,
	Alan Cox <alan@lxorguk.ukuu.org.uk>,
	Marcelo Tosatti <marcelo@conectiva.com.br>,
	linux-kernel@vger.kernel.org
References: <20020927212752.E4733@sgi.com> <1033153674.16726.10.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <1033153674.16726.10.camel@irongate.swansea.linux.org.uk>; from alan@lxorguk.ukuu.org.uk on Fri, Sep 27, 2002 at 08:07:54PM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 27, 2002 at 08:07:54PM +0100, Alan Cox wrote:
> With all the vendors now shipping 4.2 this seems a bad thing to default
> to the 4,1 interface - especially as the 4.1 server is
> 
> o Buggy
> o Has security holes that are fixed in 4.2.1 only

I don't think that's the proper argument.  2.4.20 silently breaking
systems that worked fine with 2.4.19 is not the way new linux releases
work.  Vendors can of course feel free to have the new ABI by default.

