Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S269019AbRHPXv7>; Thu, 16 Aug 2001 19:51:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S269002AbRHPXvt>; Thu, 16 Aug 2001 19:51:49 -0400
Received: from w146.z064001233.sjc-ca.dsl.cnc.net ([64.1.233.146]:52165 "EHLO
	windmill.gghcwest.com") by vger.kernel.org with ESMTP
	id <S269019AbRHPXvj>; Thu, 16 Aug 2001 19:51:39 -0400
Date: Thu, 16 Aug 2001 16:51:03 -0700 (PDT)
From: "Jeffrey W. Baker" <jwbaker@acm.org>
X-X-Sender: <jwb@heat.gghcwest.com>
To: "Adam J. Richter" <adam@yggdrasil.com>
cc: <gibbs@scsiguy.com>, <linux-kernel@vger.kernel.org>
Subject: Re: aic7xxx driver that does not need db library?
In-Reply-To: <200108161644.JAA02547@adam.yggdrasil.com>
Message-ID: <Pine.LNX.4.33.0108161650090.4812-100000@heat.gghcwest.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Thu, 16 Aug 2001, Adam J. Richter wrote:

>
> 	Currently, building Justin Gibbs's otherwise excellent
> aic7xxx driver requires the Berkeley DB library, because the
> aic7xxx assembler that is used in the build process uses db
> basically just to implement associative arrays in memory.

You don't need berk db if you don't check "rebuild firmware" or whatever
the config option is.  I don't check it, and I never have problems.  I
believe it exists only as a convenience for the developers.

-jwb

