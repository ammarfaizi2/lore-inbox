Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269444AbTGJRmv (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 10 Jul 2003 13:42:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269447AbTGJRmv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 10 Jul 2003 13:42:51 -0400
Received: from perninha.conectiva.com.br ([200.250.58.156]:31971 "EHLO
	perninha.conectiva.com.br") by vger.kernel.org with ESMTP
	id S269444AbTGJRmr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 10 Jul 2003 13:42:47 -0400
Date: Thu, 10 Jul 2003 14:55:02 -0300 (BRT)
From: Marcelo Tosatti <marcelo@conectiva.com.br>
X-X-Sender: marcelo@freak.distro.conectiva
To: Stephan von Krawczynski <skraw@ithnet.com>
Cc: green@namesys.com, mason@suse.com, linux-kernel@vger.kernel.org
Subject: Re: 2.4.22-pre3 and reiserfs boot problem
In-Reply-To: <20030710180633.2c7085d9.skraw@ithnet.com>
Message-ID: <Pine.LNX.4.55L.0307101453001.25229@freak.distro.conectiva>
References: <E19adfc-000Cax-00.ia6432-inbox-ru@f9.mail.ru>
 <20030710180633.2c7085d9.skraw@ithnet.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Thu, 10 Jul 2003, Stephan von Krawczynski wrote:

> On Thu, 10 Jul 2003 19:49:20 +0400
> "Peter Lojkin" <ia6432@inbox.ru> wrote:
>
> > Hello,
> >
> > I am not on the list so please CC me if replying...
> >
> > I've found the problem, it's patch with description:
> >
> > Fix potential IO hangs and increase interactiveness during heavy IO
> >
> > http://linux.bkbits.net:8080/linux-2.4/user=mason/cset@1.1024?nav=!-|index.html|stats|!+|index.html|ChangeSet@-7d
> >
> > After removing all changes from this cset, a had no problems
> > mounting big reiserfs volumes...
>
> Hello Marcelo,
>
> can you please send me a separated patch for reversal to verify this.

Its attached (iostalls). Use patch -R.

Also, when the hang happens, sysrq works right?

If so get us the tasks backtraces with sysrq, ok?

