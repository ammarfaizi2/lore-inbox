Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S277223AbRJINuZ>; Tue, 9 Oct 2001 09:50:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S277220AbRJINuI>; Tue, 9 Oct 2001 09:50:08 -0400
Received: from garrincha.netbank.com.br ([200.203.199.88]:47376 "HELO
	netbank.com.br") by vger.kernel.org with SMTP id <S277217AbRJINts>;
	Tue, 9 Oct 2001 09:49:48 -0400
Date: Tue, 9 Oct 2001 10:50:01 -0300 (BRST)
From: Rik van Riel <riel@conectiva.com.br>
X-X-Sender: <riel@imladris.rielhome.conectiva>
To: BALBIR SINGH <balbir.singh@wipro.com>
Cc: Kirill Ratkin <kratkin@yahoo.com>, <linux-kernel@vger.kernel.org>
Subject: Re: No locking is needed ... why?
In-Reply-To: <3BC2FF97.4090204@wipro.com>
Message-ID: <Pine.LNX.4.33L.0110091049220.2847-100000@imladris.rielhome.conectiva>
X-spambait: aardvark@kernelnewbies.org
X-spammeplease: aardvark@nl.linux.org
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; CHARSET=US-ASCII; FORMAT=flowed
Content-ID: <Pine.LNX.4.33L.0110091049222.2847@imladris.rielhome.conectiva>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 9 Oct 2001, BALBIR SINGH wrote:

> >Each CPU has its own data structure here. This means no
> >other CPU will touch this queue (they have their own)
> >so there is nobody we could ever race against.
>
> We would still require locking or interrupt disabling if this data is used
> from an interrupt context (due to re-enterency issues), wouldn't we Rik?

I think this code is only run from interrupt context anyway.

regards,

Rik
-- 
DMCA, SSSCA, W3C?  Who cares?  http://thefreeworld.net/  (volunteers needed)

http://www.surriel.com/		http://distro.conectiva.com/

