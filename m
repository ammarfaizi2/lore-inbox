Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265781AbUGITu2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265781AbUGITu2 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 9 Jul 2004 15:50:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265517AbUGITu2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 9 Jul 2004 15:50:28 -0400
Received: from moutng.kundenserver.de ([212.227.126.191]:7644 "EHLO
	moutng.kundenserver.de") by vger.kernel.org with ESMTP
	id S265781AbUGITuY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 9 Jul 2004 15:50:24 -0400
From: Christian Borntraeger <linux-kernel@borntraeger.net>
To: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] s390 - mark IPv6 support for QETH as broken
Date: Fri, 9 Jul 2004 21:50:22 +0200
User-Agent: KMail/1.6.2
Cc: "David S. Miller" <davem@redhat.com>, Bastian Blank <bastian@waldi.eu.org>,
       Frank Pavlic <pavlic@de.ibm.com>, Thomas Spatzier <tspat@de.ibm.com>
References: <20040709140630.GA27350@wavehammer.waldi.eu.org> <20040709192253.GA11138@wavehammer.waldi.eu.org> <20040709123005.086fdfc5.davem@redhat.com>
In-Reply-To: <20040709123005.086fdfc5.davem@redhat.com>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <200407092150.22868.linux-kernel@borntraeger.net>
X-Provags-ID: kundenserver.de abuse@kundenserver.de auth:5a8b66f42810086ecd21595c2d6103b9
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

David S. Miller wrote:
> On Fri, 9 Jul 2004 21:22:53 +0200
> Bastian Blank <bastian@waldi.eu.org> wrote:
> > The original submission is recorded on
> > http://marc.theaimsgroup.com/?l=linux-net&m=104551077013011&w=2. And
> > the complaint was that it puts '"ipv6 stuff" into the generic netdevice
> > structure'. I don't know if this can be solved another way.
>
> Put it in the inet6device private area.
>
> It's been a year, and you haven't put forth the effort to look
> for solutions like that?

I think its sensible to add the driver authors to cc. Hopefully we can agree 
on a nice solution.

cheers

Christian
