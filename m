Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262132AbUCXWFg (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 24 Mar 2004 17:05:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262153AbUCXWFf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 24 Mar 2004 17:05:35 -0500
Received: from chello062178136209.2.14.vie.surfer.at ([62.178.136.209]:33540
	"EHLO mh.gaugusch.at") by vger.kernel.org with ESMTP
	id S262132AbUCXWFS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 24 Mar 2004 17:05:18 -0500
Date: Wed, 24 Mar 2004 23:05:14 +0100 (CET)
From: Markus Gaugusch <markus@gaugusch.at>
X-X-Sender: markus@phoenix.kerstin.at
To: Pavel Machek <pavel@ucw.cz>
Cc: LKML <linux-kernel@vger.kernel.org>,
       Swsusp mailing list <swsusp-devel@lists.sourceforge.net>
Subject: Re: [Swsusp-devel] Re: swsusp problems [was Re: Your opinion on the
 merge?]
In-Reply-To: <20040324102233.GC512@elf.ucw.cz>
Message-ID: <Pine.LNX.4.58.0403242259220.9887@phoenix.kerstin.at>
References: <1079659165.15559.34.camel@calvin.wpcb.org.au>
 <200403231743.01642.dtor_core@ameritech.net> <20040323233228.GK364@elf.ucw.cz>
 <200403232352.58066.dtor_core@ameritech.net> <20040324102233.GC512@elf.ucw.cz>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=ISO-8859-15
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mar 24, Pavel Machek <pavel@ucw.cz> wrote:

> On Út 23-03-04 23:52:58, Dmitry Torokhov wrote:
> > most often is your love for "panic"ing instead of trying to recover. In that
> > case you understandably want as many preceding messages as possible left
> > intact on the screen to diagnose the problem. If error recovery is ever done
> > then some eye-candy probably won't hurt.
> 
> Except when error recovery does not work.
The most valuable tool of all swsusp developers and testers was and is the
serial console. If there are errors that haven't been found yet by anyone
(and a lot already have been found and fixed!), it's time to dig out the
console cable, record it and report it. That's what happend all the time
in the last year or so.
In all cases, I never could do much with the text on the screen. Apart 
from being hard to paste into emails, it also scrolled away in most cases 
(or worse: everything was just hanging and I had to increase debug level 
which produced even more output that wouldn't fit on screen). By the way - 
higher debug levels disable nice output automatically (AFAIR).

> > 'top' running on console overwriting the very same messages. Should we ban
> > top?
> 
> Its bad idea to run top when kernel messages are not redirected
> somewhere. Unfortunately eye-candy makes that choice for you, and does
> the wrong thing automatically.
> 								Pavel
Did I say redirect to serial console or what? ;-)

Markus

-- 
__________________    /"\ 
Markus Gaugusch       \ /    ASCII Ribbon Campaign
markus(at)gaugusch.at  X     Against HTML Mail
                      / \
