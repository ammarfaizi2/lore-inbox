Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132186AbRCYUan>; Sun, 25 Mar 2001 15:30:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132188AbRCYUae>; Sun, 25 Mar 2001 15:30:34 -0500
Received: from [209.205.76.166] ([209.205.76.166]:51468 "EHLO
	krusty.linuxcolombia.com.co") by vger.kernel.org with ESMTP
	id <S132186AbRCYUaV>; Sun, 25 Mar 2001 15:30:21 -0500
Date: Sun, 25 Mar 2001 15:50:39 -0500 (COT)
From: <diego@linuxcolombia.com.co>
To: Guest section DW <dwguest@win.tue.nl>
cc: Wichert Akkerman <wichert@cistron.nl>, linux-kernel@vger.kernel.org
Subject: Re: Larger dev_t
In-Reply-To: <20010325202115.D6759@win.tue.nl>
Message-ID: <Pine.LNX.4.21.0103251549260.14138-100000@krusty.linuxcolombia.com.co>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 25 Mar 2001, Guest section DW wrote:

> On Sun, Mar 25, 2001 at 05:35:01PM +0200, Wichert Akkerman wrote:
> > In article <UTC200103251231.OAA10795.aeb@vlet.cwi.nl>,
> >  <Andries.Brouwer@cwi.nl> wrote:
> > >a large name space allows one to omit checking what part can be
> > >reused - reuse is unnecessary.
> > 
> > You are just delaying the problem then, at some point your uptime will
> > be large enough that you have run through all 64bit pids for example.
> > 
> > Wichert.
> 
> Yes indeed. If my box, after continually spawning 1000000000 processes
> per second for 500 years crashes because pid_t overflows, I'll think
> about whether I should put the test back in, or should upgrade to a
> 128-bit machine.

this is a no point thread, we are not going to live 500 years? a 64 bits
space is more that we are going to need anyway...

Juan Diego

