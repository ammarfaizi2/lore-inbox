Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288768AbSADVDP>; Fri, 4 Jan 2002 16:03:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S288766AbSADVCz>; Fri, 4 Jan 2002 16:02:55 -0500
Received: from ns.ithnet.com ([217.64.64.10]:54538 "HELO heather.ithnet.com")
	by vger.kernel.org with SMTP id <S288762AbSADVCp>;
	Fri, 4 Jan 2002 16:02:45 -0500
Date: Fri, 4 Jan 2002 22:02:40 +0100
From: Stephan von Krawczynski <skraw@ithnet.com>
To: "Phil Oester" <kernel@theoesters.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 1gb RAM + 1gb SWAP + make -j bzImage = OOM
Message-Id: <20020104220240.233ae66a.skraw@ithnet.com>
In-Reply-To: <004b01c1955e$ecbc9190$6400a8c0@philxp>
In-Reply-To: <004b01c1955e$ecbc9190$6400a8c0@philxp>
Organization: ith Kommunikationstechnik GmbH
X-Mailer: Sylpheed version 0.6.6 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 4 Jan 2002 12:32:27 -0800
"Phil Oester" <kernel@theoesters.com> wrote:

> On 2.4.17, I can't make -j bzImage without OOM kicking in.  Relatively
> light .config here - bzImage compiles to less than 1mb.
> 
> Seems with 1 gb of RAM and swap, the box should be able to handle this
> (box is dual P3 600 btw).  
> 
> Is this unreasonable?  How much RAM should it take to accomplish this???

You should give a bit more info on that, especially vmstat and the like.
I cannot reproduce this. Neither on 1GB/256MB nor on 2GB/256MB RAM/SWAP.
(P3-1GHz, dual SMP, 2.4.17)

Regards,
Stephan

