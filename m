Return-Path: <linux-kernel-owner+willy=40w.ods.org-S270020AbUIDC6l@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270020AbUIDC6l (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 3 Sep 2004 22:58:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270022AbUIDC6l
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 3 Sep 2004 22:58:41 -0400
Received: from main.gmane.org ([80.91.224.249]:32936 "EHLO main.gmane.org")
	by vger.kernel.org with ESMTP id S270020AbUIDC6j (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 3 Sep 2004 22:58:39 -0400
X-Injected-Via-Gmane: http://gmane.org/
To: linux-kernel@vger.kernel.org
From: Giuseppe Bilotta <bilotta78@hotpop.com>
Subject: Re: The argument for fs assistance in handling archives
Date: Sat, 4 Sep 2004 04:58:15 +0200
Message-ID: <MPG.1ba2816bae8677619896e0@news.gmane.org>
References: <20040826150202.GE5733@mail.shareable.org> <200408282314.i7SNErYv003270@localhost.localdomain> <20040901200806.GC31934@mail.shareable.org> <Pine.LNX.4.58.0409011311150.2295@ppc970.osdl.org> <1094118362.4847.23.camel@localhost.localdomain> <Pine.LNX.4.58.0409021045210.2295@ppc970.osdl.org> <20040902175034.GA18861@lst.de> <Pine.LNX.4.58.0409021059230.2295@ppc970.osdl.org> <wn5k6vc6ufp.fsf@linhd-2.ca.nortel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: ppp-33-131.29-151.libero.it
X-Newsreader: MicroPlanet Gravity v2.60
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linh Dang wrote:
> On such a system, one would have multiple virtual views mounted (by
> root) under:
> 
>         /view/tar, /view/dpkg, /view/rpm, etc.
> 
> for every regular file /home/joe/blah.tar
> 
> the path /view/tar/home/joe/blah.tar/ is a directory where member of
> the archives directly accessible.
> 
> old tools continue work as is. new tools can take a look on virtual
> views for virtual access. 
> 
> Not sure how such a system would work with the dentry cache.

How does it cope with 'view withint view'? Say you have a 
.zipped ISO. Can you do

cd /view/iso/view/zip/home/joe/mycd.zip/mycd.iso/

?

-- 
Giuseppe "Oblomov" Bilotta

Can't you see
It all makes perfect sense
Expressed in dollar and cents
Pounds shillings and pence
                  (Roger Waters)

