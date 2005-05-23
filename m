Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261854AbVEWISu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261854AbVEWISu (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 23 May 2005 04:18:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261863AbVEWISu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 23 May 2005 04:18:50 -0400
Received: from odin2.bull.net ([192.90.70.84]:12206 "EHLO odin2.bull.net")
	by vger.kernel.org with ESMTP id S261854AbVEWISs convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 23 May 2005 04:18:48 -0400
Subject: Re: weird X problem - priority inversion?
From: "Serge Noiraud" <serge.noiraud@bull.net>
To: Ingo Molnar <mingo@elte.hu>
Cc: Lee Revell <rlrevell@joe-job.com>,
       linux-kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <20050523075508.GC9287@elte.hu>
References: <1113428938.16635.13.camel@mindpipe>
	 <20050523075508.GC9287@elte.hu>
Content-Type: text/plain; charset=iso-8859-15
Organization: BTS
Message-Id: <1116835728.9576.42.camel@ibiza.btsn.frna.bull.fr>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6-5.1.100mdk 
Date: Mon, 23 May 2005 10:08:49 +0200
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Le lun 23/05/2005 à 09:55, Ingo Molnar a écrit :
> does this still occur with the latest tree? (.47-05 or later)
> 
> 	Ingo
> 
> * Lee Revell <rlrevell@joe-job.com> wrote:
> 
> > I am having a problem with the RT preempt kernels where xscreensaver
> > will cause the X server to consume excessive CPU, starving other
> > processes.  This should not happen as xscreensaver runs at the highest
> > nice value.  It seems that there's some kind of priority inversion
> > happening between the high prio X server and low prio xscreensaver.
> > 
> > This seems like an X problem to me, but could the kernel be involved?
I have a problem with X too. It could be the same.

I have a test program which made a loop in RT to mesure the system perturbation.
It works finely in a tty environment.
When I run it in an X environment ( xterm ), I get something like if I click the Enter key.
If I open a new xterm, this is the active window which receive these events.
These events stop when the program stop.


