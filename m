Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267742AbTADAdZ>; Fri, 3 Jan 2003 19:33:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267743AbTADAdZ>; Fri, 3 Jan 2003 19:33:25 -0500
Received: from smtp07.iddeo.es ([62.81.186.17]:65498 "EHLO smtp07.retemail.es")
	by vger.kernel.org with ESMTP id <S267742AbTADAdX>;
	Fri, 3 Jan 2003 19:33:23 -0500
Date: Sat, 4 Jan 2003 01:41:53 +0100
From: "J.A. Magallon" <jamagallon@able.es>
To: linux-kernel@vger.kernel.org
Subject: Re: TCP Zero Copy for mmapped files
Message-ID: <20030104004153.GA16238@werewolf.able.es>
References: <3E161DFD.AB8D25AE@tin.it>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: 7BIT
In-Reply-To: <3E161DFD.AB8D25AE@tin.it>; from adefacc@tin.it on Sat, Jan 04, 2003 at 00:34:21 +0100
X-Mailer: Balsa 2.0.4
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On 2003.01.04 A.D.F. wrote:
> FreeBSD 5.0 should already have a zero copy for mmapped files and
> IMHO it would be worth to have it in Linux 2.6 too.
> 
> It would also be very nice to be able to enable zero copy for mmapped files
> by a config option.
> 
> Many applications use mapped memory to serve lots of small and
> medium sized files (4 - 1024 KB) or even a few big files
> (think at web servers, i.e. Apache 2, etc.);  this is done to better
> serve multiple / parallel downloads being done on the same files.
> 

Apache2 uses mmap() to open files ??
So then there is a reason to include it in my patchset...

-- 
J.A. Magallon <jamagallon@able.es>      \                 Software is like sex:
werewolf.able.es                         \           It's better when it's free
Mandrake Linux release 9.1 (Cooker) for i586
Linux 2.4.21-pre2-jam2 (gcc 3.2.1 (Mandrake Linux 9.1 3.2.1-2mdk))
