Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751061AbWDJHLX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751061AbWDJHLX (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 10 Apr 2006 03:11:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751062AbWDJHLX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 10 Apr 2006 03:11:23 -0400
Received: from zproxy.gmail.com ([64.233.162.207]:14251 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1751050AbWDJHLX convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 10 Apr 2006 03:11:23 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=XDepdB3Bt10YJqPlCsmP4VHpktF1ioruxHSmYW0mn2PMMaTFkbS21/wBCuj2Fr1hGzLNEummLEPPKxgEfdTFuMDZwiHtnZH4eiM1O3DStM1M7Jq5CfS4d4/DVHeySaW3kixilaxipaij2oHAk43w7VOALq0Q5NGcG0gvjZN5keY=
Message-ID: <c70ff3ad0604100011l1ce1b7c4qbadbf1576aebb5e9@mail.gmail.com>
Date: Mon, 10 Apr 2006 10:11:22 +0300
From: "saeed bishara" <saeed.bishara@gmail.com>
To: "saeed bishara" <saeed.bishara@gmail.com>,
       "Arjan van de Ven" <arjan@infradead.org>,
       "Paolo Ornati" <ornati@fastwebnet.it>, linux-kernel@vger.kernel.org,
       linux-arm-kernel@lists.arm.linux.org.uk,
       Linux-arm-toolchain@lists.arm.linux.org.uk
Subject: Re: add new code section for kernel code
In-Reply-To: <20060409203046.GA24461@flint.arm.linux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <c70ff3ad0604060545o2e2dc8fcg2948ca53b3b3c8b0@mail.gmail.com>
	 <20060406151003.0ef4e637@localhost>
	 <c70ff3ad0604060947t728fbad9g2e3b35198f9b0f66@mail.gmail.com>
	 <c70ff3ad0604070402p355a5695y28b5806cbf7bed0a@mail.gmail.com>
	 <1144422864.3117.0.camel@laptopd505.fenrus.org>
	 <20060407154349.GB31458@flint.arm.linux.org.uk>
	 <c70ff3ad0604090253n7fe4de4che67f18380ffa2efd@mail.gmail.com>
	 <20060409203046.GA24461@flint.arm.linux.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I just want to say that this code reordering reduced the I cache
misses of my system that includes direct mapped caches,  and the
perforamance of a the optimezed tests increased up to 10% and in some
case it improved by 20%.

saeed


> Thanks for testing; I've applied this patch so 2.6.17-rc2 onwards will
> have this fixed.
>
