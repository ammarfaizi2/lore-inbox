Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S287966AbSBDAdQ>; Sun, 3 Feb 2002 19:33:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S287979AbSBDAc5>; Sun, 3 Feb 2002 19:32:57 -0500
Received: from garrincha.netbank.com.br ([200.203.199.88]:2313 "HELO
	netbank.com.br") by vger.kernel.org with SMTP id <S287966AbSBDAcv>;
	Sun, 3 Feb 2002 19:32:51 -0500
Date: Sun, 3 Feb 2002 22:32:28 -0200
From: Arnaldo Carvalho de Melo <acme@conectiva.com.br>
To: Tim Coleman <tim@timcoleman.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.5.3 Compile errors
Message-ID: <20020204003228.GA1733@conectiva.com.br>
Mail-Followup-To: Arnaldo Carvalho de Melo <acme@conectiva.com.br>,
	Tim Coleman <tim@timcoleman.com>, linux-kernel@vger.kernel.org
In-Reply-To: <1012530613.1169.2.camel@tux.epenguin.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1012530613.1169.2.camel@tux.epenguin.org>
User-Agent: Mutt/1.3.25i
X-Url: http://advogato.org/person/acme
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Em Thu, Jan 31, 2002 at 09:30:11PM -0500, Tim Coleman escreveu:

> I'm getting some more compiler errors when trying to compile kernel
> 2.5.3.
 
> deflate.c is complaining about no linux/zutil.h which then breaks a whole
> bunch of stuff included from defutil.h

mv linux/* include/linux
rmdir linux

- Arnaldo
