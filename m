Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S285732AbRLHBZj>; Fri, 7 Dec 2001 20:25:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S285734AbRLHBZa>; Fri, 7 Dec 2001 20:25:30 -0500
Received: from sm10.texas.rr.com ([24.93.35.222]:28333 "EHLO sm10.texas.rr.com")
	by vger.kernel.org with ESMTP id <S285732AbRLHBZU>;
	Fri, 7 Dec 2001 20:25:20 -0500
Content-Type: text/plain; charset=US-ASCII
From: Marvin Justice <mjustice@austin.rr.com>
Reply-To: mjustice@austin.rr.com
To: "H. Peter Anvin" <hpa@zytor.com>, linux-kernel@vger.kernel.org
Subject: Re: highmem question
Date: Fri, 7 Dec 2001 19:30:01 -0600
X-Mailer: KMail [version 1.2]
In-Reply-To: <Pine.LNX.4.30.0112071404280.29154-100000@mustard.heime.net> <9url8t$nmo$1@cesium.transmeta.com>
In-Reply-To: <9url8t$nmo$1@cesium.transmeta.com>
MIME-Version: 1.0
Message-Id: <01120719300102.00764@bozo>
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>
> > I heard that himem slows down systems.
>
> It does, because it's a hack to extend 32-bit machines beyond their
> architectural lifetime.
>

While it certainly makes sense to expect a performance hit for mem above 4GB 
on 32 bit systems I don't see why there should be any a priori reason to 
either move to 64 bit or take a performance hit for if you need, say,  2GB of 
RAM. The problem is that 2.4 Linux considers HIGHMEM to be anything above 
896MB. 

>From what I've read it looks like there will be changes in 2.5 to fix all 
this.

Marvin Justice
