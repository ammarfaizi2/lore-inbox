Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750951AbWDXQM0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750951AbWDXQM0 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 24 Apr 2006 12:12:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750953AbWDXQM0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 24 Apr 2006 12:12:26 -0400
Received: from nz-out-0102.google.com ([64.233.162.203]:57897 "EHLO
	nz-out-0102.google.com") by vger.kernel.org with ESMTP
	id S1750916AbWDXQM0 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 24 Apr 2006 12:12:26 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=LBul2CC1MGkzwlea++qXbkfLEwey5fVUIevCmclRE9yIRQtq4TGlZtqln/0hHjwcuyyIbBgMk2zJCP9+uLeJrumh7h0WQPomGW/DJyyYsIuXLsAynsT6zj0Tje9UbhN8nRacpknvg9ccZ84Bv28qV1BLf/hH+EhYyX19FrBTy0w=
Message-ID: <cda58cb80604240912o61ab1491i13946fe2f0f03c27@mail.gmail.com>
Date: Mon, 24 Apr 2006 18:12:24 +0200
From: "Franck Bui-Huu" <vagabon.xyz@gmail.com>
To: "David Woodhouse" <dwmw2@infradead.org>
Subject: Re: How can I prevent MTD to access the end of a flash device ?
Cc: "Nicolas Pitre" <nico@cam.org>, lkml <linux-kernel@vger.kernel.org>
In-Reply-To: <1145893231.16166.340.camel@shinybook.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <cda58cb80511070248o6d7a18bex@mail.gmail.com>
	 <cda58cb80511220658n671bc070v@mail.gmail.com>
	 <Pine.LNX.4.64.0511221042560.6022@localhost.localdomain>
	 <cda58cb80604231006x4911598bg6c1e3d62f07d80e7@mail.gmail.com>
	 <Pine.LNX.4.64.0604231323180.3603@localhost.localdomain>
	 <cda58cb80604231157g58088e0dhb93a91c46deda627@mail.gmail.com>
	 <1145893231.16166.340.camel@shinybook.infradead.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

2006/4/24, David Woodhouse <dwmw2@infradead.org>:
> MTD partitions aren't like block device partitions. You just get a set
> of MTD devices which are like a wrapper around the original.
>
> MTD concat is the same. You should be able to partition and concat and
> partition and concat on top of each other to your heart's content. If
> you so desire.
>

oh ok...should I simply use add_mtd_partitions(...) function to create
a new MTD device based on a given partition ?

> > Do you think it's possible to change the size of a mtd device rigth
> > after probing it ?
>
> Yes, that works too.
>

In your opinion, what is the right thing to do ?

thanks
--
               Franck
