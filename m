Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261213AbRFKPQY>; Mon, 11 Jun 2001 11:16:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261217AbRFKPQO>; Mon, 11 Jun 2001 11:16:14 -0400
Received: from perninha.conectiva.com.br ([200.250.58.156]:65032 "HELO
	perninha.conectiva.com.br") by vger.kernel.org with SMTP
	id <S261213AbRFKPQB>; Mon, 11 Jun 2001 11:16:01 -0400
Date: Mon, 11 Jun 2001 12:15:19 -0300
From: Arnaldo Carvalho de Melo <acme@conectiva.com.br>
To: Lauri Tischler <lauri.tischler@efore.fi>
Cc: linux-kernel@vger.kernel.org
Subject: Re: IPX to Netware 5.1
Message-ID: <20010611121519.D2145@conectiva.com.br>
Mail-Followup-To: Arnaldo Carvalho de Melo <acme@conectiva.com.br>,
	Lauri Tischler <lauri.tischler@efore.fi>,
	linux-kernel@vger.kernel.org
In-Reply-To: <3B24BE9F.AA4C8CCB@efore.fi>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.17i
In-Reply-To: <3B24BE9F.AA4C8CCB@efore.fi>; from lauri.tischler@efore.fi on Mon, Jun 11, 2001 at 03:50:39PM +0300
X-Url: http://advogato.org/person/acme
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Em Mon, Jun 11, 2001 at 03:50:39PM +0300, Lauri Tischler escreveu:
> I've been mounting Netware volumes from Netware 4.1x to linux for
> a quite a while now, works just fine.
> We installed new Netware server with Netware 5.1 and I can't now
> mount any volumes.  The error message is:
>   ncpmount: Unknown Server error (0x8901) in nds login
>   Login denied.
> The error is same if I try bindery login.
> Any IPX gurus here or hints or links about ??

See if this makes sense:

http://developer.novell.com/support/sample/tids/bs98au6h/nwerrors.txt

#define ERR_INSUFFICIENT_SPACE          0x8901  /* 001 */
#define NWE_INSUFFICIENT_SPACE          0x8901  /* 001 */

And can you, just in case, check if IPX is enabled? ncpfs can work with
tcp/ip as well and this can possibly be not related to IPX

- Arnaldo
