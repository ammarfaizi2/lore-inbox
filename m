Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135443AbRD3PwC>; Mon, 30 Apr 2001 11:52:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135427AbRD3Pvw>; Mon, 30 Apr 2001 11:51:52 -0400
Received: from leibniz.math.psu.edu ([146.186.130.2]:12287 "EHLO math.psu.edu")
	by vger.kernel.org with ESMTP id <S135413AbRD3Pvp>;
	Mon, 30 Apr 2001 11:51:45 -0400
Date: Mon, 30 Apr 2001 11:51:43 -0400 (EDT)
From: Alexander Viro <viro@math.psu.edu>
To: Ola Garstad <olag@eunet.no>
cc: Linux-Kernel <linux-kernel@vger.kernel.org>
Subject: Re: Mounting same device many times/mountpoints. Is this legal?
In-Reply-To: <000901c0d17d$75ab1f40$01000001@pompel>
Message-ID: <Pine.GSO.4.21.0104301148280.5737-100000@weyl.math.psu.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Mon, 30 Apr 2001, Ola Garstad wrote:

> I am running kernel 2.4.3 on RH 7.0
> 
> By mistake I mounted the same device two places. Is this legal???

Yes, it is.

> On 2.2.x I got an error if I did this.
> It guess thus could have destoryed the filesystem if had written to it.

No (well, aside of the potential filesystem bugs, but their chances of
fs corruption do not depend on number of mountpoints).

