Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132310AbRAKVOR>; Thu, 11 Jan 2001 16:14:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131768AbRAKVOH>; Thu, 11 Jan 2001 16:14:07 -0500
Received: from brutus.conectiva.com.br ([200.250.58.146]:19190 "HELO
	brinquedo.distro.conectiva") by vger.kernel.org with SMTP
	id <S132310AbRAKVOA>; Thu, 11 Jan 2001 16:14:00 -0500
Date: Thu, 11 Jan 2001 17:26:46 -0200
From: Arnaldo Carvalho de Melo <acme@conectiva.com.br>
To: "Richard B. Johnson" <root@chaos.analogic.com>
Cc: Paul Powell <moloch16@yahoo.com>, linux-kernel@vger.kernel.org
Subject: Re: Linux driver:  __get_free_pages()
Message-ID: <20010111172646.C9711@conectiva.com.br>
Mail-Followup-To: Arnaldo Carvalho de Melo <acme@conectiva.com.br>,
	"Richard B. Johnson" <root@chaos.analogic.com>,
	Paul Powell <moloch16@yahoo.com>, linux-kernel@vger.kernel.org
In-Reply-To: <20010111203933.17385.qmail@web119.yahoomail.com> <Pine.LNX.3.95.1010111154554.379A-100000@chaos.analogic.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <Pine.LNX.3.95.1010111154554.379A-100000@chaos.analogic.com>; from root@chaos.analogic.com on Thu, Jan 11, 2001 at 04:01:08PM -0500
X-Url: http://advogato.org/person/acme
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Em Thu, Jan 11, 2001 at 04:01:08PM -0500, Richard B. Johnson escreveu:
> If all you need is a kernel buffer to store the stuff that will be
> written to NVRAM, then just use kmalloc(). It is virtual and will

s/kmalloc/vmalloc/

> seem contiguous to your driver.

- Arnaldo
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
