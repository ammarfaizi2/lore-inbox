Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270668AbTGUSy4 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 21 Jul 2003 14:54:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270669AbTGUSy4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 21 Jul 2003 14:54:56 -0400
Received: from mail3.ithnet.com ([217.64.64.7]:23450 "HELO
	heather-ng.ithnet.com") by vger.kernel.org with SMTP
	id S270668AbTGUSyy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 21 Jul 2003 14:54:54 -0400
X-Sender-Authentification: SMTPafterPOP by <info@euro-tv.de> from 217.64.64.14
Date: Mon, 21 Jul 2003 21:09:54 +0200
From: Stephan von Krawczynski <skraw@ithnet.com>
To: Marcelo Tosatti <marcelo@conectiva.com.br>
Cc: mason@suse.com, andrea@suse.de, riel@redhat.com,
       linux-kernel@vger.kernel.org, maillist@jg555.com
Subject: Re: Bug Report: 2.4.22-pre5: BUG in page_alloc (fwd)
Message-Id: <20030721210954.644b20ba.skraw@ithnet.com>
In-Reply-To: <Pine.LNX.4.55L.0307211422010.26736@freak.distro.conectiva>
References: <Pine.LNX.4.55L.0307150859130.5146@freak.distro.conectiva>
	<1058297936.4016.86.camel@tiny.suse.com>
	<Pine.LNX.4.55L.0307160836270.30825@freak.distro.conectiva>
	<20030718112758.1da7ab03.skraw@ithnet.com>
	<Pine.LNX.4.55L.0307180921120.6642@freak.distro.conectiva>
	<20030718145033.5ff05880.skraw@ithnet.com>
	<Pine.LNX.4.55L.0307181109220.7889@freak.distro.conectiva>
	<20030721104906.34ae042a.skraw@ithnet.com>
	<20030721170517.1dd1f910.skraw@ithnet.com>
	<Pine.LNX.4.55L.0307211422010.26736@freak.distro.conectiva>
Organization: ith Kommunikationstechnik GmbH
X-Mailer: Sylpheed version 0.9.3 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 21 Jul 2003 14:23:53 -0300 (BRT)
Marcelo Tosatti <marcelo@conectiva.com.br> wrote:

> > > Hello Marcelo,
> > >
> > > have you seen anything in your tests? My box just froze again after 3
> > > days during NFS action. This was with pre6, I am switching over to pre7.
> >
> > I managed to freeze the pre7 box within these few hours. There was no nfs
> > involved, only tar-to-tape.
> 
> You had NMI on, correct? Sysrq doesnt work, correct?

Yes, that's right.
 
> > I switched back to 2.4.21 to see if it is still stable. Is there a
> > possibility that the i/o-scheduler has another flaw somewhere (just like
> > during mount previously) ...
> 
> It might be a problem in the IO scheduler, yes.
> 
> Lets isolate the problems: If 2.4.21 doenst lockup, try 2.4.22-pre7
> without drivers/block/ll_rw_blk{.c,.h} changes.

I am pretty confident that 2.4.21 does not lock up, I tested it long time ago
and to my memory it had no problems. Anyway I re-check to make sure the box is
still ok.

Can you send me patches off-list to reverse from -pre7. Just to make sure we
are talking of the same stuff...

Regards,
Stephan

