Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261294AbTFCU7l (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 3 Jun 2003 16:59:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261322AbTFCU7k
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 3 Jun 2003 16:59:40 -0400
Received: from aneto.able.es ([212.97.163.22]:17106 "EHLO aneto.able.es")
	by vger.kernel.org with ESMTP id S261294AbTFCU6l (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 3 Jun 2003 16:58:41 -0400
Date: Tue, 3 Jun 2003 23:12:07 +0200
From: "J.A. Magallon" <jamagallon@able.es>
To: Anders Karlsson <anders@trudheim.com>
Cc: Marc-Christian Petersen <m.c.p@wolk-project.de>,
       Michael Frank <mflt1@micrologica.com.hk>,
       Marcelo Tosatti <marcelo@conectiva.com.br>, Marc Wilson <msw@cox.net>,
       LKML <linux-kernel@vger.kernel.org>
Subject: Re: Linux 2.4.21-rc6
Message-ID: <20030603211207.GG3661@werewolf.able.es>
References: <20030529052425.GA1566@moonkingdom.net> <200306040030.27640.mflt1@micrologica.com.hk> <200306031859.59197.m.c.p@wolk-project.de> <200306031903.06297.m.c.p@wolk-project.de> <1054663333.2066.5.camel@tor.trudheim.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: 7BIT
In-Reply-To: <1054663333.2066.5.camel@tor.trudheim.com>; from anders@trudheim.com on Tue, Jun 03, 2003 at 20:02:13 +0200
X-Mailer: Balsa 2.0.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On 06.03, Anders Karlsson wrote:
> Good Evening,
> 
> On Tue, 2003-06-03 at 18:03, Marc-Christian Petersen wrote:
> > On Tuesday 03 June 2003 18:59, Marc-Christian Petersen wrote:
> > 
> > Hi again,
> > 
> > > well, very easy one:
> > > dd if=/dev/zero of=/home/largefile bs=16384 count=131072
> > > then use your mouse, your apps, switch between them, use them, _w/o_
> > > pauses, delay, stops or kinda that. If _that_ will work flawlessly for
> > > everyone, then it is fixed, if not, it _needs_ to be fixed.
> > I forgot to mention. If you have more than 2GB free memory (the above one will 
> > create a 2GB file), the test is useless.
> > 
> > Have less memory free, so the machine will swap, doesn't matter if the same 
> > disk or another or whatever!
> 
> Would it count if I said I run 2.4.21-rc6-ac1 and had 768MB RAM, ended
> up using about 250MB swap and when I today suspended VMware and closed a
> few gnome-terminals, Galeon and Evolution, the mouse cursor would not
> move, then jump half way across the screen after a second, then 'stick'
> again before doing another jump.
> 

One vote in the opposite sense (I know, nobody uses plain rc6 ???)
I am using a -jam kernel (-aa with some additional patches), and I did
not notice anything. Dual PII box with 900 Mb, as buffers were filling
memory, no stalls. Just a very small (less than half a second) jump in the
cursor under gnome when the memory got full, and then smooth again.
I use pointer-focus and was rapidly moving the pointer from window to
window to change focus and response was ok. Launching an aterm was instant.

-- 
J.A. Magallon <jamagallon@able.es>      \                 Software is like sex:
werewolf.able.es                         \           It's better when it's free
Mandrake Linux release 9.2 (Cooker) for i586
Linux 2.4.21-rc6-jam1 (gcc 3.2.3 (Mandrake Linux 9.2 3.2.3-1mdk))
