Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S273662AbRIWV7l>; Sun, 23 Sep 2001 17:59:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S273661AbRIWV72>; Sun, 23 Sep 2001 17:59:28 -0400
Received: from perninha.conectiva.com.br ([200.250.58.156]:3588 "HELO
	perninha.conectiva.com.br") by vger.kernel.org with SMTP
	id <S273656AbRIWV7R>; Sun, 23 Sep 2001 17:59:17 -0400
Date: Sun, 23 Sep 2001 18:59:14 -0300
From: Arnaldo Carvalho de Melo <acme@conectiva.com.br>
To: "Pei Zheng" <zhengpei@msu.edu>
Cc: <linux-kernel@vger.kernel.org>
Subject: Re: an IP stack problem regarding routing and ARP
Message-ID: <20010923185914.C2048@conectiva.com.br>
Mail-Followup-To: Arnaldo Carvalho de Melo <acme@conectiva.com.br>,
	"Pei Zheng" <zhengpei@msu.edu>, <linux-kernel@vger.kernel.org>
In-Reply-To: <LIECKFOKGFCHAPOBKPECEECGCLAA.zhengpei@msu.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.17i
In-Reply-To: <LIECKFOKGFCHAPOBKPECEECGCLAA.zhengpei@msu.edu>; from zhengpei@msu.edu on Sun, Sep 23, 2001 at 05:56:14PM -0400
X-Url: http://advogato.org/person/acme
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Em Sun, Sep 23, 2001 at 05:56:14PM -0400, Pei Zheng escreveu:

> If a Linux box has 2 NICs, I would like to generate some packets in the
> kernel, sent them out from one NIC to an Ethernet switch, and then
> receive them on the other NIC. Is it possible, with the help of appropriate
> routing table, routing rules and ARP configuration? Or the kernel IP
> stack must be modified? It seems to me that if the kernel figures
> out that a packet's next hop is its local network interface, it will
> deliver to that interface through IP stack directly.

look at snull in Rubini's ldd2, available as FDL (iirc) at www.oreilly.com

- Arnaldo
