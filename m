Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270153AbTGUOuY (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 21 Jul 2003 10:50:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270158AbTGUOuY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 21 Jul 2003 10:50:24 -0400
Received: from mail3.ithnet.com ([217.64.64.7]:43662 "HELO
	heather-ng.ithnet.com") by vger.kernel.org with SMTP
	id S270153AbTGUOuR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 21 Jul 2003 10:50:17 -0400
X-Sender-Authentification: SMTPafterPOP by <info@euro-tv.de> from 217.64.64.14
Date: Mon, 21 Jul 2003 17:05:17 +0200
From: Stephan von Krawczynski <skraw@ithnet.com>
To: marcelo@conectiva.com.br
Cc: mason@suse.com, andrea@suse.de, riel@redhat.com,
       linux-kernel@vger.kernel.org, maillist@jg555.com
Subject: Re: Bug Report: 2.4.22-pre5: BUG in page_alloc (fwd)
Message-Id: <20030721170517.1dd1f910.skraw@ithnet.com>
In-Reply-To: <20030721104906.34ae042a.skraw@ithnet.com>
References: <Pine.LNX.4.55L.0307150859130.5146@freak.distro.conectiva>
	<1058297936.4016.86.camel@tiny.suse.com>
	<Pine.LNX.4.55L.0307160836270.30825@freak.distro.conectiva>
	<20030718112758.1da7ab03.skraw@ithnet.com>
	<Pine.LNX.4.55L.0307180921120.6642@freak.distro.conectiva>
	<20030718145033.5ff05880.skraw@ithnet.com>
	<Pine.LNX.4.55L.0307181109220.7889@freak.distro.conectiva>
	<20030721104906.34ae042a.skraw@ithnet.com>
Organization: ith Kommunikationstechnik GmbH
X-Mailer: Sylpheed version 0.9.3 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 21 Jul 2003 10:49:06 +0200
Stephan von Krawczynski <skraw@ithnet.com> wrote:

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

I managed to freeze the pre7 box within these few hours. There was no nfs
involved, only tar-to-tape.
I switched back to 2.4.21 to see if it is still stable.
Is there a possibility that the i/o-scheduler has another flaw somewhere (just
like during mount previously) ...


Regards,
Stephan
