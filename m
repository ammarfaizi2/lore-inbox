Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262859AbSJGD5f>; Sun, 6 Oct 2002 23:57:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262860AbSJGD5f>; Sun, 6 Oct 2002 23:57:35 -0400
Received: from orion.netbank.com.br ([200.203.199.90]:51463 "EHLO
	orion.netbank.com.br") by vger.kernel.org with ESMTP
	id <S262859AbSJGD5e>; Sun, 6 Oct 2002 23:57:34 -0400
Date: Mon, 7 Oct 2002 01:03:05 -0300
From: Arnaldo Carvalho de Melo <acme@conectiva.com.br>
To: Alexander Viro <viro@math.psu.edu>
Cc: "David S. Miller" <davem@redhat.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [BKPATCH] X25: use seq_file for proc stuff
Message-ID: <20021007040305.GE1201@conectiva.com.br>
Mail-Followup-To: Arnaldo Carvalho de Melo <acme@conectiva.com.br>,
	Alexander Viro <viro@math.psu.edu>,
	"David S. Miller" <davem@redhat.com>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <20021007033155.GB1201@conectiva.com.br> <Pine.GSO.4.21.0210062351380.29030-100000@weyl.math.psu.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.GSO.4.21.0210062351380.29030-100000@weyl.math.psu.edu>
User-Agent: Mutt/1.4i
X-Url: http://advogato.org/person/acme
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Em Sun, Oct 06, 2002 at 11:56:20PM -0400, Alexander Viro escreveu:
> Huh???
> 
> a) ->permission() always returning 0 on a read-only file is... interesting.
> b) if you want it world-readable, kernel is perfectly capable of doing that;
> had been since the very beginning.  Just set mode to 0444 and be done with
> that; no need to have anything special in ->proc_iops.

Just that? Cool, I'll be sending a fix in some minutes.

Thanks Al.

- Arnaldo

