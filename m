Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268400AbTBNOPT>; Fri, 14 Feb 2003 09:15:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268401AbTBNOPT>; Fri, 14 Feb 2003 09:15:19 -0500
Received: from smtpzilla1.xs4all.nl ([194.109.127.137]:40710 "EHLO
	smtpzilla1.xs4all.nl") by vger.kernel.org with ESMTP
	id <S268400AbTBNOPS>; Fri, 14 Feb 2003 09:15:18 -0500
Date: Fri, 14 Feb 2003 15:24:48 +0100 (CET)
From: Roman Zippel <zippel@linux-m68k.org>
X-X-Sender: roman@serv
To: Werner Almesberger <wa@almesberger.net>
cc: Rusty Russell <rusty@rustcorp.com.au>, <kuznet@ms2.inr.ac.ru>,
       <davem@redhat.com>, <kronos@kronoz.cjb.net>,
       <linux-kernel@vger.kernel.org>
Subject: Re: [RFC] Migrating net/sched to new module interface
In-Reply-To: <20030214105338.E2092@almesberger.net>
Message-ID: <Pine.LNX.4.44.0302141500540.1336-100000@serv>
References: <20030214120628.208112C464@lists.samba.org>
 <Pine.LNX.4.44.0302141410540.1336-100000@serv> <20030214105338.E2092@almesberger.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Fri, 14 Feb 2003, Werner Almesberger wrote:

> The module changes only make this a little worse, because they
> follow the philosophy that this can't be fixed, so try_module_get
> and friends try to implement the right kind of locking for unload
> races (but for little else) without tripping over those "unfixable"
> bugs.

If you see these bugs as "unfixable", you already gave up and you end up 
putting one band-aid over another, each only solving part of the problem.
Please try work with me here and we might find a more general solution.
I could just post possible solutions, but as long nobody understands the 
problem, they will be rejected anyway.

bye, Roman

