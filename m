Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269702AbTGULla (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 21 Jul 2003 07:41:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269706AbTGULla
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 21 Jul 2003 07:41:30 -0400
Received: from perninha.conectiva.com.br ([200.250.58.156]:56747 "EHLO
	perninha.conectiva.com.br") by vger.kernel.org with ESMTP
	id S269702AbTGULlY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 21 Jul 2003 07:41:24 -0400
Date: Mon, 21 Jul 2003 08:51:32 -0300 (BRT)
From: Marcelo Tosatti <marcelo@conectiva.com.br>
X-X-Sender: marcelo@freak.distro.conectiva
To: Stephan von Krawczynski <skraw@ithnet.com>
Cc: mason@suse.com, andrea@suse.de, riel@redhat.com,
       linux-kernel@vger.kernel.org, maillist@jg555.com
Subject: Re: Bug Report: 2.4.22-pre5: BUG in page_alloc (fwd)
In-Reply-To: <20030721104906.34ae042a.skraw@ithnet.com>
Message-ID: <Pine.LNX.4.55L.0307210849180.25063@freak.distro.conectiva>
References: <Pine.LNX.4.55L.0307150859130.5146@freak.distro.conectiva>
 <1058297936.4016.86.camel@tiny.suse.com> <Pine.LNX.4.55L.0307160836270.30825@freak.distro.conectiva>
 <20030718112758.1da7ab03.skraw@ithnet.com> <Pine.LNX.4.55L.0307180921120.6642@freak.distro.conectiva>
 <20030718145033.5ff05880.skraw@ithnet.com> <Pine.LNX.4.55L.0307181109220.7889@freak.distro.conectiva>
 <20030721104906.34ae042a.skraw@ithnet.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Mon, 21 Jul 2003, Stephan von Krawczynski wrote:

> On Fri, 18 Jul 2003 11:14:15 -0300 (BRT)
> Marcelo Tosatti <marcelo@conectiva.com.br> wrote:
>
> >
> > I have just started stress testing a 8way OSDL box to see if I can
> > reproduce the problem. I'm using pre6+axboes BH_Sync patch.
> >
> > I'm running 50 dbench clients on aic7xxx (ext2) and 50 dbench clients on
> > DAC960 (ext3). Lets see what happens.
> >
> > After lunch I'll keep looking at the oopses. During the morning I only had
> > time to setup the OSDL box and start the tests.
>
> Hello Marcelo,
>
> have you seen anything in your tests? My box just froze again after 3 days
> during NFS action. This was with pre6, I am switching over to pre7.

No. I just checked it and the 8way is alive and well:

bash-2.05a$ uptime
  4:53am  up 2 days, 18:04,  2 users,  load average: 100.57, 96.27, 95.22


Could you try to reproduce the tests with something else other than NFS?
(local disk, SMB, ...) as Andrea suggested?
