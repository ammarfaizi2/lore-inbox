Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S286893AbRL1MlP>; Fri, 28 Dec 2001 07:41:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S286889AbRL1Mk4>; Fri, 28 Dec 2001 07:40:56 -0500
Received: from garrincha.netbank.com.br ([200.203.199.88]:20229 "HELO
	netbank.com.br") by vger.kernel.org with SMTP id <S286887AbRL1Mkg>;
	Fri, 28 Dec 2001 07:40:36 -0500
Date: Fri, 28 Dec 2001 10:40:26 -0200 (BRST)
From: Rik van Riel <riel@conectiva.com.br>
X-X-Sender: <riel@imladris.surriel.com>
To: <isp01ljl@taurus.zsu.edu.cn>
Cc: <linux-kernel@vger.kernel.org>
Subject: Re: whether the thread   is implemented in the kernel ?
In-Reply-To: <586590797.20001228140112@student.zsu.edu.cn>
Message-ID: <Pine.LNX.4.33L.0112281039380.24031-100000@imladris.surriel.com>
X-spambait: aardvark@kernelnewbies.org
X-spammeplease: aardvark@nl.linux.org
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 28 Dec 2000 isp01ljl@taurus.zsu.edu.cn wrote:

>     I encountered a interesting problem , that is whether the thread
>  is implemented in the kernel ?  if yes , then what is the system
>  call to generate a thread ?  is it similar to fork() ?

clone(2), which is the exact same code path as fork().

For more information, see
	man 2 clone
	kernel/fork.c::do_fork()

regards,

Rik
-- 
Shortwave goes a long way:  irc.starchat.net  #swl

http://www.surriel.com/		http://distro.conectiva.com/

