Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262377AbTCIC6l>; Sat, 8 Mar 2003 21:58:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262381AbTCIC6k>; Sat, 8 Mar 2003 21:58:40 -0500
Received: from modemcable092.130-200-24.mtl.mc.videotron.ca ([24.200.130.92]:16972
	"EHLO montezuma.mastecende.com") by vger.kernel.org with ESMTP
	id <S262377AbTCIC6k>; Sat, 8 Mar 2003 21:58:40 -0500
Date: Sat, 8 Mar 2003 22:07:04 -0500 (EST)
From: Zwane Mwaikambo <zwane@linuxpower.ca>
X-X-Sender: zwane@montezuma.mastecende.com
To: rwhron@earthlink.net
cc: linux-kernel@vger.kernel.org
Subject: Re: scheduler starvation running irman with 2.5.64bk2
In-Reply-To: <20030309025015.GA2843@rushmore>
Message-ID: <Pine.LNX.4.50.0303082205570.24347-100000@montezuma.mastecende.com>
References: <20030309025015.GA2843@rushmore>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 8 Mar 2003 rwhron@earthlink.net wrote:

> There are probably less than 50 processes running.  
> "ps aux" doesn't hear <ctrl z> or <ctrl c>.
> 
> Machine doesn't accept new ssh connections.
> 
> It's as if after starting irman, new processes don't get any CPU time.

Try doing a sysrq-T to get task state for all the processes and even 
sysrq-P at any random point will give you an idea of where the cpu is.

	Zwane
-- 
function.linuxpower.ca
