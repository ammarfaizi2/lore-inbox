Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316500AbSFDHLO>; Tue, 4 Jun 2002 03:11:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316503AbSFDHLN>; Tue, 4 Jun 2002 03:11:13 -0400
Received: from garrincha.netbank.com.br ([200.203.199.88]:40976 "HELO
	garrincha.netbank.com.br") by vger.kernel.org with SMTP
	id <S316500AbSFDHLM>; Tue, 4 Jun 2002 03:11:12 -0400
Date: Tue, 4 Jun 2002 04:10:55 -0300 (BRT)
From: Rik van Riel <riel@conectiva.com.br>
X-X-Sender: riel@imladris.surriel.com
To: Matti Aarnio <matti.aarnio@zmailer.org>
cc: Larry McVoy <lm@work.bitmover.com>, <linux-kernel@vger.kernel.org>
Subject: Re: please kindly get back to me
In-Reply-To: <20020603222338.F18899@mea-ext.zmailer.org>
Message-ID: <Pine.LNX.4.44L.0206040406510.24135-100000@imladris.surriel.com>
X-spambait: aardvark@kernelnewbies.org
X-spammeplease: aardvark@nl.linux.org
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 3 Jun 2002, Matti Aarnio wrote:

>   Best technologies (as I see them, but I am not omniscient, of course)
>   are those that do scoring.  E.g. naving some word NN might not alone

>   I think there are several free codes of this kind available, but my time
>   has been chronically over-subscribed to do radical things like taking
>   this kind of codes into use.

1) mv resend resend.mj

2) use this script as resend

--------------
#!/bin/sh

/path/to/spamassassin -L | /path/to/resend.mj $*
--------------

3) add X-Spam-Flag:.*YES to taboo_headers

I'm doing this for the listar setup on nl.linux.org and things
work great. Only took 10 minutes to install, too.

Rik
-- 
Bravely reimplemented by the knights who say "NIH".

http://www.surriel.com/		http://distro.conectiva.com/

