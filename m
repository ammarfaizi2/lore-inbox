Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261514AbTIOQFz (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 15 Sep 2003 12:05:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261515AbTIOQFz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 15 Sep 2003 12:05:55 -0400
Received: from keetweej.xs4all.nl ([213.84.46.114]:30865 "EHLO
	keetweej.vanheusden.com") by vger.kernel.org with ESMTP
	id S261514AbTIOQFy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 15 Sep 2003 12:05:54 -0400
From: Folkert van Heusden <folkert@vanheusden.com>
Reply-To: folkert@vanheusden.com
Organization: vanheusdendotcom
To: Alan Cox <alan@lxorguk.ukuu.org.uk>, alexander.riesen@synopsys.COM
Subject: Re: logging when SIGSEGV is processed?
Date: Mon, 15 Sep 2003 18:05:51 +0200
User-Agent: KMail/1.5.3
Cc: bert hubert <ahu@ds9a.nl>, Mo McKinlay <lkml@ekto.ekol.co.uk>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <20030914111408.GA14514@strawberry.blancmange.org> <20030915070945.GD1091@Synopsys.COM> <1063612045.3734.6.camel@dhcp23.swansea.linux.org.uk>
In-Reply-To: <1063612045.3734.6.camel@dhcp23.swansea.linux.org.uk>
WebSite: http://www.vanheusden.com/
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200309151805.52153.folkert@vanheusden.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> On Llu, 2003-09-15 at 08:09, Alex Riesen wrote:
> > Probably ptrace the daemon (following all its children) would server
> > better. The feature (logging the coredumps) is definitely no needed for
> > everything, just some suspectables.
> accton() will turn on logging and that gives you log records of process
> termination including if it segfaulted.

Sound's good. You probably mean acct()? There's one little problem with that 
one:
NOTES
       No accounting is produced  for  programs  running  when  a
       crash occurs.  In particular, nonterminating processes are
       never accounted for.


Folkert van Heusden

+--------------------------------------------------------------------------+
| UNIX sysop? Then give MultiTail ( http://www.vanheusden.com/multitail/ ) |
| a try, it brings monitoring logfiles (and such) to a different level!    |
+---------------------------------------------------= www.vanheusden.com =-+

