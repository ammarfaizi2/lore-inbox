Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129242AbRC2WfG>; Thu, 29 Mar 2001 17:35:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129321AbRC2We5>; Thu, 29 Mar 2001 17:34:57 -0500
Received: from jalon.able.es ([212.97.163.2]:16071 "EHLO jalon.able.es")
	by vger.kernel.org with ESMTP id <S129242AbRC2Weo>;
	Thu, 29 Mar 2001 17:34:44 -0500
Date: Fri, 30 Mar 2001 00:33:56 +0200
From: "J . A . Magallon" <jamagallon@able.es>
To: Fabio Riccardi <fabio@chromium.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: linux scheduler limitations?
Message-ID: <20010330003356.C1052@werewolf.able.es>
In-Reply-To: <3AC3A6C9.991472C0@chromium.com> <20010329233521.C6053@werewolf.able.es> <3AC3B35D.FC010700@chromium.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
In-Reply-To: <3AC3B35D.FC010700@chromium.com>; from fabio@chromium.com on Fri, Mar 30, 2001 at 00:12:45 +0200
X-Mailer: Balsa 1.1.2
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On 03.30 Fabio Riccardi wrote:
> 
> Despite of all apparences this method performs beautifully on Linux, pthreads
> are
> actually slower in many cases, since you will incur some additional overhead
> due
> to thread synchronization and scheduling.
>

It all depends on your app, as every parallel algorithm. In a web-ftp-whatever
server, you do not need any synchro. You can start threads in free run and
let them die alone.

> The problem is that beyond a certain number of processes the scheduler just
> goes
> bananas, or so it seems to me.
> 
> Since Linux threads are mapped on processes, I don't think that (p)threads
> woud
> help in any way, unless it is the VM context switch overhead that is playing a
> role here, which I wouldn't think is the case.
> 

You said, 'mapped'.
AFAIK, that is the advantage, you can avoid the VM switch by sharing memory.

-- 
J.A. Magallon                                          #  Let the source
mailto:jamagallon@able.es                              #  be with you, Luke... 

Linux werewolf 2.4.2-ac28 #1 SMP Thu Mar 29 16:41:17 CEST 2001 i686

