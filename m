Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262624AbSI0Txr>; Fri, 27 Sep 2002 15:53:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262623AbSI0Txh>; Fri, 27 Sep 2002 15:53:37 -0400
Received: from pc1-cwma1-5-cust51.swa.cable.ntl.com ([80.5.120.51]:6136 "EHLO
	irongate.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S262627AbSI0Txb>; Fri, 27 Sep 2002 15:53:31 -0400
Subject: Re: [PATCH] fix drm ioctl ABI default
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Christoph Hellwig <hch@sgi.com>
Cc: Marcelo Tosatti <marcelo@conectiva.com.br>, linux-kernel@vger.kernel.org
In-Reply-To: <20020927222159.A5124@sgi.com>
References: <20020927212752.E4733@sgi.com>
	<1033153674.16726.10.camel@irongate.swansea.linux.org.uk> 
	<20020927222159.A5124@sgi.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-10) 
Date: 27 Sep 2002 21:04:18 +0100
Message-Id: <1033157058.16726.23.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2002-09-28 at 03:21, Christoph Hellwig wrote:
> I don't think that's the proper argument.  2.4.20 silently breaking
> systems that worked fine with 2.4.19 is not the way new linux releases
> work.  Vendors can of course feel free to have the new ABI by default.

Linus did the same during earlier 2.4 when we went from 4.0 to 4.1 DRM.
There is a clear precedent for it from the boss 8)

In the general case it will autodetect the problem. There are some
additional bitds (see the dri-devel archive) to investigate that may
make it even more reliable

