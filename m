Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131637AbQKUWz4>; Tue, 21 Nov 2000 17:55:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131648AbQKUWzr>; Tue, 21 Nov 2000 17:55:47 -0500
Received: from einhorn.colt.in-berlin.de ([213.61.118.8]:31238 "EHLO
	einhorn.in-berlin.de") by vger.kernel.org with ESMTP
	id <S131636AbQKUWzb>; Tue, 21 Nov 2000 17:55:31 -0500
To: linux-kernel@vger.kernel.org
Path: kraxel
From: kraxel@bytesex.org (Gerd Knorr)
Newsgroups: lists.linux.kernel
Subject: Re: Defective Red Hat Distribution poorly represents Linux
Date: 21 Nov 2000 22:21:47 GMT
Organization: Strusel 007
Message-ID: <slrn91ltbr.2er.kraxel@bogomips.masq.in-berlin.de>
In-Reply-To: Message from David Riley <oscar@the-rileys.net>  of "Tue, 21 Nov 2000 16:34:08 CDT." <3A1AEA47.ECF2D50A@the-rileys.net>  <200011212201.eALM1CZ02022@pincoya.inf.utfsm.cl>
NNTP-Posting-Host: bogomips.masq.in-berlin.de
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
X-Trace: goldbach.masq.in-berlin.de 974845307 23646 192.168.69.77 (21 Nov 2000 22:21:47 GMT)
X-Complaints-To: news@goldbach.in-berlin.de
NNTP-Posting-Date: 21 Nov 2000 22:21:47 GMT
User-Agent: slrn/0.9.6.3 (Linux)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > This is true.  What I suppose would be the solution is that if faulty
> > hardware is found, a reduction in performance should be made.
> 
> Finding out if you've got bad RAM might take a few hours running mem86. Not
> exactly what I have in mind to do each boot...

Even if memtest doesn't find anything you can't be sure the box is fine.
I've seen boxed which passed memtest just fine, but compiling kernels in
a endless loop with "make -j" still bombed after some time with gcc sig11.

  Gerd

-- 
Wirtschaftsinformatiker == Leute, die zwar die aktuellen Aktienkurse
jedes Softwareherstellers kennen, aber keines der Produkte auch nur
ansatzweise bedienen können.		-- Benedict Mangelsdorff
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
