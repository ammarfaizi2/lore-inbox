Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129469AbQKNAcA>; Mon, 13 Nov 2000 19:32:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129566AbQKNAbu>; Mon, 13 Nov 2000 19:31:50 -0500
Received: from perninha.conectiva.com.br ([200.250.58.156]:64018 "EHLO
	perninha.conectiva.com.br") by vger.kernel.org with ESMTP
	id <S129469AbQKNAbk>; Mon, 13 Nov 2000 19:31:40 -0500
Date: Mon, 13 Nov 2000 19:51:15 -0200 (BRST)
From: Marcelo Tosatti <marcelo@conectiva.com.br>
To: Rasmus Andersen <rasmus@jaquet.dk>
cc: linux-kernel@vger.kernel.org
Subject: Re: Oops on 2.2.17 [klogd bonus question]
In-Reply-To: <20001113162155.A18009@jaquet.dk>
Message-ID: <Pine.LNX.4.21.0011131950040.32472-100000@freak.distro.conectiva>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Mon, 13 Nov 2000, Rasmus Andersen wrote:

> Hi.
> 
> I'm getting oopses on a linux 2.2.17 box when I try to do
> tar cvIf <file> -X<file> /. Reproducably. This works fine 
> for the std. RH 6.2 kernel (2.2.14-5). The resulting file 
> is about 20MB.
> 
> I would submit the oops, but it is run through klogd and
> I seem to remember people expressing dissatisfaction 
> with klogd. So what do I do now to get a usable oops
> to submit?


I dont know anything wrong with klogd. 


Anyway, kill klogd so you'll get a non decoded oops on your screen and
then you can decoded it with ksymoops.



-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
