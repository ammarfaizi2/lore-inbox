Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312182AbSCRDE5>; Sun, 17 Mar 2002 22:04:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S312183AbSCRDEq>; Sun, 17 Mar 2002 22:04:46 -0500
Received: from garrincha.netbank.com.br ([200.203.199.88]:38921 "HELO
	netbank.com.br") by vger.kernel.org with SMTP id <S312182AbSCRDEe>;
	Sun, 17 Mar 2002 22:04:34 -0500
Date: Mon, 18 Mar 2002 00:03:34 -0300 (BRT)
From: Rik van Riel <riel@conectiva.com.br>
X-X-Sender: riel@imladris.surriel.com
To: Mike Fedyk <mfedyk@matchmail.com>
Cc: MrChuoi <MrChuoi@yahoo.com>, Alan Cox <alan@lxorguk.ukuu.org.uk>,
        <linux-kernel@vger.kernel.org>
Subject: Re: Linux 2.4.19-pre3-ac1
In-Reply-To: <20020318030145.GB2254@matchmail.com>
Message-ID: <Pine.LNX.4.44L.0203180002210.2181-100000@imladris.surriel.com>
X-spambait: aardvark@kernelnewbies.org
X-spammeplease: aardvark@nl.linux.org
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 17 Mar 2002, Mike Fedyk wrote:

> Can you reproduce with just rmap12h from http://www.surriel.com/patches/
> on top of 2.4.18?

He probably can.

> Rik, can you confirm that OOM kill should work with rmap12 (the rmap VM
> is in -ac...)?

There's a known issue with OOM not knowing about the number of
freeable pages and killing processes while freeable pages are
still being written out to disk.  This is something that really
wants fixing, when I figure out how to do this nicely.

regards,

Rik
-- 
<insert bitkeeper endorsement here>

http://www.surriel.com/		http://distro.conectiva.com/

