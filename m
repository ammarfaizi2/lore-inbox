Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S291605AbSBAIPa>; Fri, 1 Feb 2002 03:15:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S291606AbSBAIPT>; Fri, 1 Feb 2002 03:15:19 -0500
Received: from dell-paw-3.cambridge.redhat.com ([195.224.55.237]:55035 "EHLO
	passion.cambridge.redhat.com") by vger.kernel.org with ESMTP
	id <S291605AbSBAIPR>; Fri, 1 Feb 2002 03:15:17 -0500
X-Mailer: exmh version 2.4 06/23/2000 with nmh-1.0.4
From: David Woodhouse <dwmw2@infradead.org>
X-Accept-Language: en_GB
In-Reply-To: <20020131232119.GN10772@conectiva.com.br> 
In-Reply-To: <20020131232119.GN10772@conectiva.com.br>  <20020131.145904.41634460.davem@redhat.com> <E16WQYs-0003Ux-00@the-village.bc.nu> 
To: Arnaldo Carvalho de Melo <acme@conectiva.com.br>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, davem@redhat.com (David S. Miller),
        vandrove@vc.cvut.cz, torvalds@transmeta.com, garzik@havoc.gtf.org,
        linux-kernel@vger.kernel.org, paulus@samba.org, davidm@hpl.hp.com,
        ralf@gnu.org
Subject: Re: [PATCH] Re: crc32 and lib.a (was Re: [PATCH] nbd in 2.5.3 does 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Fri, 01 Feb 2002 08:14:10 +0000
Message-ID: <28871.1012551250@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


acme@conectiva.com.br said:
>  heh, after I've read that you managed to boot 2.4 + rmap in a machine
> with just 4 MB after tweaking some table sizes I thought about
> devoting some time to identify those tables and making them options in
> make *config, with even a nice CONFIG_TINY, like you said 8)

> I'll eventually do this, and I'd appreciate if people send me
> suggestions of tables/data structures that can be trimmed/reduced.
> Yeah, I'll take a look at the .config files used in the embedded
> distros. 

CONFIG_BLK_DEV=n should allow you to trim a lot of cruft that most of my 
embedded boxen never use.


--
dwmw2


