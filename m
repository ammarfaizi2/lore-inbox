Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317423AbSGQWQl>; Wed, 17 Jul 2002 18:16:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317546AbSGQWQk>; Wed, 17 Jul 2002 18:16:40 -0400
Received: from jalon.able.es ([212.97.163.2]:7667 "EHLO jalon.able.es")
	by vger.kernel.org with ESMTP id <S317423AbSGQWQk>;
	Wed, 17 Jul 2002 18:16:40 -0400
Date: Thu, 18 Jul 2002 00:18:37 +0200
From: "J.A. Magallon" <jamagallon@able.es>
To: Adrian Bunk <bunk@fs.tum.de>
Cc: "Justin M. Forbes" <kernelmail@attbi.com>, marcelo@conectiva.com.br,
       linux-kernel@vger.kernel.org
Subject: Re: 2.4.19-rc2 compile fail
Message-ID: <20020717221837.GA2390@werewolf.able.es>
References: <Pine.NEB.4.44.0207171902230.16056-100000@mimas.fachschaften.tu-muenchen.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: 7BIT
In-Reply-To: <Pine.NEB.4.44.0207171902230.16056-100000@mimas.fachschaften.tu-muenchen.de>; from bunk@fs.tum.de on Wed, Jul 17, 2002 at 19:11:49 +0200
X-Mailer: Balsa 1.3.6
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On 2002.07.17 Adrian Bunk wrote:
>On Wed, 17 Jul 2002, Justin M. Forbes wrote:
>
>>  GCC version is 3.1 .config is attached, fairly large as I base it off of
>> the original Red Hat one to make sure everything compiles, even though I
>> am not using most of it. Strangely no compile problems on my base 7.2 box
>> (gcc 2.96).  .config is attached.
>
>The short answer ist perhaps: 3.1 is not a supported compiler...
>
>But I'm surprised that I wasn't able to reproduce it using the 20020703
>(past 3.1) snapshot of the gcc-3.1 branch that is in Debian unstable.
>

I am building kernels with Mandrakes gcc-3.1.1 snapshots since time ago,
and have no problems with it (now gcc-3.1.1-0.7mdk, branch of 2002/07/01)

Probably kernel is more sensible to binutils version...
Here: binutils-2.12.90.0.14-2mdk

-- 
J.A. Magallon             \   Software is like sex: It's better when it's free
mailto:jamagallon@able.es  \                    -- Linus Torvalds, FSF T-shirt
Linux werewolf 2.4.19-rc1-jam3, Mandrake Linux 8.3 (Cooker) for i586
gcc (GCC) 3.1.1 (Mandrake Linux 8.3 3.1.1-0.7mdk)
