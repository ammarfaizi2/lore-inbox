Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289222AbSANMGb>; Mon, 14 Jan 2002 07:06:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289220AbSANMGW>; Mon, 14 Jan 2002 07:06:22 -0500
Received: from garrincha.netbank.com.br ([200.203.199.88]:38927 "HELO
	netbank.com.br") by vger.kernel.org with SMTP id <S289212AbSANMGL>;
	Mon, 14 Jan 2002 07:06:11 -0500
Date: Mon, 14 Jan 2002 10:05:26 -0200 (BRST)
From: Rik van Riel <riel@conectiva.com.br>
X-X-Sender: <riel@imladris.surriel.com>
To: "David S. Miller" <davem@redhat.com>
Cc: <ebiederm@xmission.com>, <akropel1@rochester.rr.com>,
        <linux-kernel@vger.kernel.org>
Subject: Re: Linux 2.4.18pre3-ac1
In-Reply-To: <20020114.012831.44983761.davem@redhat.com>
Message-ID: <Pine.LNX.4.33L.0201141003420.32617-100000@imladris.surriel.com>
X-spambait: aardvark@kernelnewbies.org
X-spammeplease: aardvark@nl.linux.org
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 14 Jan 2002, David S. Miller wrote:
>  From: ebiederm@xmission.com (Eric W. Biederman)
>
>    But for make -j the forking is done by make and it is nearly a
>    fork bomb
>
> Someone has probably mentioned this, but it is important to recognize
> that make uses vfork().

Indeed.  In the beginning I was also afraid I'd hit the fork()
problem Eric mentions, but after running lots of tests I can't
really say it has shown up in the profiles anywhere.

I'm sure you could make a benchmark to clearly show it, but for
most common workloads it doesn't seem to be much of an issue.
A possible exception to this is apache, I need to look into that
a bit more.

regards,

Rik
-- 
"Linux holds advantages over the single-vendor commercial OS"
    -- Microsoft's "Competing with Linux" document

http://www.surriel.com/		http://distro.conectiva.com/

