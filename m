Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288840AbSAEPUh>; Sat, 5 Jan 2002 10:20:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S288843AbSAEPU1>; Sat, 5 Jan 2002 10:20:27 -0500
Received: from ns.ithnet.com ([217.64.64.10]:9477 "HELO heather.ithnet.com")
	by vger.kernel.org with SMTP id <S288840AbSAEPUJ>;
	Sat, 5 Jan 2002 10:20:09 -0500
Date: Sat, 5 Jan 2002 16:19:58 +0100
From: Stephan von Krawczynski <skraw@ithnet.com>
To: nknight@pocketinet.com
Cc: kernel@theoesters.com, linux-kernel@vger.kernel.org
Subject: Re: 1gb RAM + 1gb SWAP + make -j bzImage = OOM
Message-Id: <20020105161958.43d7ab25.skraw@ithnet.com>
In-Reply-To: <WHITExcPbVzv2N2Ku2000000c76@white.pocketinet.com>
In-Reply-To: <004b01c1955e$ecbc9190$6400a8c0@philxp>
	<20020104220240.233ae66a.skraw@ithnet.com>
	<WHITExcPbVzv2N2Ku2000000c76@white.pocketinet.com>
Organization: ith Kommunikationstechnik GmbH
X-Mailer: Sylpheed version 0.6.6 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 4 Jan 2002 16:42:43 -0800
Nicholas Knight <nknight@pocketinet.com> wrote:


> I have absilutely no trouble reproducing on an 800MHz Athlon with 256MB 
> RAM/256MB swap on 2.4.17

The simple question is: is the RAM sufficient at all to spawn such a lot of cc
processes? In my setup I get around 1000 concurrently working during -j. This
sounds like a real problem for 256/256, or not?

Regards,
Stephan

