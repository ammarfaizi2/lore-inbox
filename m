Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S136702AbREAT2t>; Tue, 1 May 2001 15:28:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S136701AbREAT2j>; Tue, 1 May 2001 15:28:39 -0400
Received: from [200.181.138.209] ([200.181.138.209]:10995 "HELO
	brinquedo.distro.conectiva") by vger.kernel.org with SMTP
	id <S136700AbREAT2d>; Tue, 1 May 2001 15:28:33 -0400
Date: Tue, 1 May 2001 01:32:19 -0300
From: Arnaldo Carvalho de Melo <acme@conectiva.com.br>
To: mike_phillips@urscorp.com
Cc: linux-kernel@vger.kernel.org, netdev@oss.sgi.com
Subject: Re: isa_read/write not available on ppc - solution suggestions ??
Message-ID: <20010501013219.F2339@conectiva.com.br>
Mail-Followup-To: Arnaldo Carvalho de Melo <acme@conectiva.com.br>,
	mike_phillips@urscorp.com, linux-kernel@vger.kernel.org,
	netdev@oss.sgi.com
In-Reply-To: <OFED368CB7.D5C74726-ON85256A3F.004547C6@urscorp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.17i
In-Reply-To: <OFED368CB7.D5C74726-ON85256A3F.004547C6@urscorp.com>; from mike_phillips@urscorp.com on Tue, May 01, 2001 at 09:52:30AM -0400
X-Url: http://advogato.org/person/acme
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Em Tue, May 01, 2001 at 09:52:30AM -0400, mike_phillips@urscorp.com escreveu:
> Personally I'd rather not have arch dependent macros in the driver, but I 
> know there is a good reason why the isa_read/write functions were 
> introduced in the first place. 

I did that because I was lazy to use ioremap in my driver, but I found time
and fixed it properly eventually, too late, lots of other drivers started
using it, now its in the janitor's TODO list to get rid of that and use
ioremap, then we'll be able to get rid of that hack 8)

- Arnaldo
