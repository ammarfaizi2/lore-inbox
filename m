Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312770AbSDBPGC>; Tue, 2 Apr 2002 10:06:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S312792AbSDBPFx>; Tue, 2 Apr 2002 10:05:53 -0500
Received: from perninha.conectiva.com.br ([200.250.58.156]:36626 "HELO
	perninha.conectiva.com.br") by vger.kernel.org with SMTP
	id <S312770AbSDBPFm>; Tue, 2 Apr 2002 10:05:42 -0500
Date: Tue, 2 Apr 2002 12:16:46 -0300
From: Arnaldo Carvalho de Melo <acme@conectiva.com.br>
To: "Madhavan N.S." <madhavan.nair@wipro.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Frame Relay stack on Linux
Message-ID: <20020402151646.GC12823@conectiva.com.br>
Mail-Followup-To: Arnaldo Carvalho de Melo <acme@conectiva.com.br>,
	"Madhavan N.S." <madhavan.nair@wipro.com>,
	linux-kernel@vger.kernel.org
In-Reply-To: <3CA99EA0.1B2391FF@wipro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
X-Url: http://advogato.org/person/acme
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Em Tue, Apr 02, 2002 at 05:35:52PM +0530, Madhavan N.S. escreveu:
> We are developing  Frame Relay stack on Linux 2.4 kernel.
> It's implemented as a dynamically loadable software module and it is
> registered
> as a network driver.  Frame Relay module uses the services of lower
> layer
> hardware driver module for transmission & reception of data packets.

Have you looked at the wanrouter framework? Look at net/wanrouter and
driver/net/wan, specifically for the cycx_*.c, sdla_*.c files and see
if this fits your needs... From what I've read here, yes, its what you
need.

- Arnaldo
