Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S287596AbSCFXwS>; Wed, 6 Mar 2002 18:52:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S287798AbSCFXv7>; Wed, 6 Mar 2002 18:51:59 -0500
Received: from garrincha.netbank.com.br ([200.203.199.88]:27400 "HELO
	netbank.com.br") by vger.kernel.org with SMTP id <S287596AbSCFXv6>;
	Wed, 6 Mar 2002 18:51:58 -0500
Date: Wed, 6 Mar 2002 17:06:14 -0300 (BRT)
From: Rik van Riel <riel@conectiva.com.br>
X-X-Sender: riel@imladris.surriel.com
To: "Richard B. Johnson" <root@chaos.analogic.com>
Cc: Dario Bahena Tapia <dario.bahena@correo.unam.mx>,
        <linux-c-programming@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: getting process i/o wasted time ...
In-Reply-To: <Pine.LNX.3.95.1020306144031.13735A-100000@chaos.analogic.com>
Message-ID: <Pine.LNX.4.44L.0203061705250.2181-100000@imladris.surriel.com>
X-spambait: aardvark@kernelnewbies.org
X-spammeplease: aardvark@nl.linux.org
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 6 Mar 2002, Richard B. Johnson wrote:

> Time for I/O is not generally "wasted" as you say. It is given to
> other tasks. Of course if there are no other tasks that want the
> CPU then, I guess, you could call it wasted.

I guess it may be useful to measure IO wait time in the
kernel, where IO wait time is defined as:

1) a CPU is idle

2) there are processes in D state

regards,

Rik
-- 
"Linux holds advantages over the single-vendor commercial OS"
    -- Microsoft's "Competing with Linux" document

http://www.surriel.com/		http://distro.conectiva.com/

