Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132690AbRDUPgR>; Sat, 21 Apr 2001 11:36:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132697AbRDUPgH>; Sat, 21 Apr 2001 11:36:07 -0400
Received: from garrincha.netbank.com.br ([200.203.199.88]:27658 "HELO
	netbank.com.br") by vger.kernel.org with SMTP id <S132690AbRDUPgC>;
	Sat, 21 Apr 2001 11:36:02 -0400
Date: Sat, 21 Apr 2001 12:31:32 -0300 (BRST)
From: Rik van Riel <riel@conectiva.com.br>
To: gis88530 <gis88530@cis.nctu.edu.tw>
Cc: linux-kernel@vger.kernel.org
Subject: Re: I can't find out the answer
In-Reply-To: <005201c0ca44$755203f0$ae58718c@cis.nctu.edu.tw>
Message-ID: <Pine.LNX.4.21.0104211230250.1685-100000@imladris.rielhome.conectiva>
X-spambait: aardvark@kernelnewbies.org
X-spammeplease: aardvark@nl.linux.org
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 21 Apr 2001, gis88530 wrote:

> I want to calculate the total memory usage of kernel.
> I wonder that we just need to add these(*1) in slabinfo or 
> we need to add each line(*1 and *2) in slabinfo. Thanks.
> AND
> I know the size of size-512 is 512 bytes, but I want to know
> the size of tcp_tw_bucket, tcp_open_request, etc.
> How can I find out this answer? Thanks a lot.


> size-4096              8     12

1) you want to use only the values from the second column

2) the sizes of the structures you want to know are somewhere
   in the kernel header files, grep should be able to find them

regards,

Rik
--
Virtual memory is like a game you can't win;
However, without VM there's truly nothing to lose...

		http://www.surriel.com/
http://www.conectiva.com/	http://distro.conectiva.com.br/

