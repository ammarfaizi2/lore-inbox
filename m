Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S286902AbRL1NN7>; Fri, 28 Dec 2001 08:13:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S286898AbRL1NNt>; Fri, 28 Dec 2001 08:13:49 -0500
Received: from garrincha.netbank.com.br ([200.203.199.88]:3847 "HELO
	netbank.com.br") by vger.kernel.org with SMTP id <S286902AbRL1NNh>;
	Fri, 28 Dec 2001 08:13:37 -0500
Date: Fri, 28 Dec 2001 11:13:24 -0200 (BRST)
From: Rik van Riel <riel@conectiva.com.br>
X-X-Sender: <riel@imladris.surriel.com>
To: Amber Palekar <amber_palekar@yahoo.com>
Cc: kernel list <linux-kernel@vger.kernel.org>
Subject: Re: threads in kernel
In-Reply-To: <20011228125826.91067.qmail@web20310.mail.yahoo.com>
Message-ID: <Pine.LNX.4.33L.0112281112580.24031-100000@imladris.surriel.com>
X-spambait: aardvark@kernelnewbies.org
X-spammeplease: aardvark@nl.linux.org
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 28 Dec 2001, Amber Palekar wrote:

>    I want to do a communication module.I am using
> sock_create etc for the same purpose.I went thru some
> sample code.Everywhere threads are being used.Is it
> mandatory to create kernel threads while doing
> communication(or using socks) in the kernel ??

No. You can do asynchronous IO on sockets, using
poll(), select() and friends.

Rik
-- 
Shortwave goes a long way:  irc.starchat.net  #swl

http://www.surriel.com/		http://distro.conectiva.com/

