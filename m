Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S143428AbRA1QUx>; Sun, 28 Jan 2001 11:20:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S143435AbRA1QUn>; Sun, 28 Jan 2001 11:20:43 -0500
Received: from 4-035.cwb-adsl.brasiltelecom.net.br ([200.193.163.35]:63991
	"HELO brinquedo.distro.conectiva") by vger.kernel.org with SMTP
	id <S143428AbRA1QUi>; Sun, 28 Jan 2001 11:20:38 -0500
Date: Sun, 28 Jan 2001 12:36:30 -0200
From: Arnaldo Carvalho de Melo <acme@conectiva.com.br>
To: Manfred Spraul <manfred@colorfullife.com>
Cc: dwmw2@infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [ANNOUNCE] Kernel Janitor's TODO list
Message-ID: <20010128123630.K19833@conectiva.com.br>
Mail-Followup-To: Arnaldo Carvalho de Melo <acme@conectiva.com.br>,
	Manfred Spraul <manfred@colorfullife.com>, dwmw2@infradead.org,
	linux-kernel@vger.kernel.org
In-Reply-To: <3A74456D.7AE44855@colorfullife.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <3A74456D.7AE44855@colorfullife.com>; from manfred@colorfullife.com on Sun, Jan 28, 2001 at 05:14:37PM +0100
X-Url: http://advogato.org/person/acme
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Em Sun, Jan 28, 2001 at 05:14:37PM +0100, Manfred Spraul escreveu:
> > 
> > Anything which uses sleep_on() has a 90% chance of being broken. Fix 
> > them all, because we want to remove sleep_on() and friends in 2.5. 
> >
> 
> Then you can add 'calling schedule() with disabled local interrupts()'
> to your list.

any example of code doing this now? That way we can at least point it to
interested people and say "look at driver foobar in kernel x.y.z and see
how its wrong"

- Arnaldo
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
