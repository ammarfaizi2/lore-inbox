Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1752790AbWKFMLi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752790AbWKFMLi (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 6 Nov 2006 07:11:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752807AbWKFMLi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 6 Nov 2006 07:11:38 -0500
Received: from qb-out-0506.google.com ([72.14.204.231]:43555 "EHLO
	qb-out-0506.google.com") by vger.kernel.org with ESMTP
	id S1752790AbWKFMLh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 6 Nov 2006 07:11:37 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=crim692H5vVKDCIXXm+ytv6PuZJWO5l1nnbewXdrzKbdPSbiVSVSRG5PQH1Mecxhe8WQ17TUMj8/RpUgFdQCHZ62wE1u/eeuMwKfdNKOz1Gov5W3jjeApk2ZkPc6bGSHSDLt/VmKIS463tfzzJb2dF+Mwbu7SUl4l8qQlT4ro1I=
Message-ID: <f55850a70611060221m77194aa6k4c14d8509809e491@mail.gmail.com>
Date: Mon, 6 Nov 2006 18:21:43 +0800
From: "Zhao Xiaoming" <xiaoming.nj@gmail.com>
To: linux-kernel@vger.kernel.org, "Linux Netdev List" <netdev@vger.kernel.org>
Subject: Re: ZONE_NORMAL memory exhausted by 4000 TCP sockets
In-Reply-To: <f55850a70611060221y25528116pa1b73aa89008f906@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <f55850a70611052207j384e1d3flaf40bb9dd74df7c5@mail.gmail.com>
	 <1162807984.3160.188.camel@laptopd505.fenrus.org>
	 <f55850a70611060221y25528116pa1b73aa89008f906@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

32 bit.  Of course 64 bit kernel can help me overcome the 900M
barrier. However, if I can't find the reason why so much memory
getting 'lost', it will be difficult to support more heavy loadded
concurrent TCP connections.

> 2006/11/6, Arjan van de Ven <arjan@infradead.org>:
> > On Mon, 2006-11-06 at 14:07 +0800, Zhao Xiaoming wrote:
> > > Dears,
> > >     I'm running a linux box with kernel version 2.6.16. The hardware
> > > has 2 Woodcrest Xeon CPUs (2 cores each) and 4G RAM. The NIC cards is
> > > Intel 82571 on PCI-e bus.
> >
> > are you using a 32 bit or a 64 bit OS?
> >
> >
> >
>
