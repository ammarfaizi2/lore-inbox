Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S270587AbRHIUjX>; Thu, 9 Aug 2001 16:39:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S270592AbRHIUjL>; Thu, 9 Aug 2001 16:39:11 -0400
Received: from perninha.conectiva.com.br ([200.250.58.156]:2833 "HELO
	perninha.conectiva.com.br") by vger.kernel.org with SMTP
	id <S270583AbRHIUim>; Thu, 9 Aug 2001 16:38:42 -0400
Date: Thu, 9 Aug 2001 17:38:33 -0300 (BRST)
From: Rik van Riel <riel@conectiva.com.br>
X-X-Sender: <riel@duckman.distro.conectiva>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: "Dirk W. Steinberg" <dws@dirksteinberg.de>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: Swapping for diskless nodes
In-Reply-To: <E15Ulnx-0006zZ-00@the-village.bc.nu>
Message-ID: <Pine.LNX.4.33L.0108091737370.1439-100000@duckman.distro.conectiva>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 9 Aug 2001, Alan Cox wrote:

> > what is the best/recommended way to do remote swapping via the network
> > for diskless workstations or compute nodes in clusters in Linux 2.4?=20
> > Last time i checked was linux 2.2, and there were some races related=20
> > to network swapping back then. Has this been fixed for 2.4?
>
> The best answer probably is "don't". Networks are high latency
> things for paging and paging is latency sensitive.

Actually, swap over network can be faster than local swap
at times. ;)

Don't forget that disks are really high latency devices
and with local swap you are SURE that the data isn't
in memory while with remote swap you have a chance that
the server is caching your data ...

regards,

Rik
--
IA64: a worthy successor to the i860.

		http://www.surriel.com/
http://www.conectiva.com/	http://distro.conectiva.com/

