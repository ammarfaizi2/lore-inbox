Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264052AbTE3XSq (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 30 May 2003 19:18:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264054AbTE3XSp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 30 May 2003 19:18:45 -0400
Received: from x35.xmailserver.org ([208.129.208.51]:46519 "EHLO
	x35.xmailserver.org") by vger.kernel.org with ESMTP id S264052AbTE3XSp
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 30 May 2003 19:18:45 -0400
X-AuthUser: davidel@xmailserver.org
Date: Fri, 30 May 2003 16:29:35 -0700 (PDT)
From: Davide Libenzi <davidel@xmailserver.org>
X-X-Sender: davide@bigblue.dev.mcafeelabs.com
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
cc: =?X-UNKNOWN?Q?J=F6rn_Engel?= <joern@wohnheim.fh-wedel.de>,
       Linus Torvalds <torvalds@transmeta.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] 2.5 Documentation/CodingStyle ANSI C function declarations.
In-Reply-To: <1054333383.27312.1.camel@dhcp22.swansea.linux.org.uk>
Message-ID: <Pine.LNX.4.55.0305301627340.4421@bigblue.dev.mcafeelabs.com>
References: <20030530212013.GE3308@wohnheim.fh-wedel.de> 
 <Pine.LNX.4.44.0305301431390.2671-100000@home.transmeta.com> 
 <20030530222630.GF3308@wohnheim.fh-wedel.de> 
 <Pine.LNX.4.55.0305301535100.4421@bigblue.dev.mcafeelabs.com>
 <1054333383.27312.1.camel@dhcp22.swansea.linux.org.uk>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 30 May 2003, Alan Cox wrote:

> On Gwe, 2003-05-30 at 23:39, Davide Libenzi wrote:
> > Talking about the code, there are still a bunch of files that uses spaces
> > with tabsize=4. Shouldn't those be reformatted with real TABs ? An emacs
> > lisp (indent+tabify) might do it pretty fast ...
>
> indent -kr -i8 -bri0 -l255
>
> seems to do the job even faster. I did a pile of the scsi drivers when I
> went over them. The big thing is not to mix indent with real changes.
> Its always a temptation but its vital that there are no outstanding
> changes and that a patch exists where you can test before and after
> indent to verify that change didnt cause the problems

GNU indent was broken last time I tried. When I was using it I was forced
to put its *DO NO INDENT* macros to prevent it to screwing up the code in
few places. Maybe they fixed it ...



- Davide

