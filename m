Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288820AbSANGet>; Mon, 14 Jan 2002 01:34:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S288833AbSANGej>; Mon, 14 Jan 2002 01:34:39 -0500
Received: from garrincha.netbank.com.br ([200.203.199.88]:12306 "HELO
	netbank.com.br") by vger.kernel.org with SMTP id <S288820AbSANGea>;
	Mon, 14 Jan 2002 01:34:30 -0500
Date: Mon, 14 Jan 2002 04:34:09 -0200 (BRST)
From: Rik van Riel <riel@conectiva.com.br>
X-X-Sender: <riel@imladris.surriel.com>
To: Andres Salomon <dilinger@mp3revolution.net>
Cc: <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] oom_kill() race?
In-Reply-To: <20020114053708.GA32597@mp3revolution.net>
Message-ID: <Pine.LNX.4.33L.0201140433480.32617-100000@imladris.surriel.com>
X-spambait: aardvark@kernelnewbies.org
X-spammeplease: aardvark@nl.linux.org
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; CHARSET=US-ASCII
Content-ID: <Pine.LNX.4.33L.0201140433482.32617@imladris.surriel.com>
Content-Disposition: INLINE
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 14 Jan 2002, Andres Salomon wrote:

> In oom_kill(), is there any chance the task_struct can be unmapped
> between being returned from select_bad_process() (where the tasklist
> is locked) and where it walks the tasklist again, looking for threads?

Indeed you're right.  Thanks for the patch!

regards,

Rik
-- 
"Linux holds advantages over the single-vendor commercial OS"
    -- Microsoft's "Competing with Linux" document

http://www.surriel.com/		http://distro.conectiva.com/

