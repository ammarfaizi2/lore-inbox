Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263906AbTJFAKW (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 5 Oct 2003 20:10:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263907AbTJFAKW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 5 Oct 2003 20:10:22 -0400
Received: from EPRONET.01.dios.net ([65.222.230.105]:16514 "EHLO
	mail.eproinet.com") by vger.kernel.org with ESMTP id S263906AbTJFAKR
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 5 Oct 2003 20:10:17 -0400
Date: Sun, 5 Oct 2003 19:37:42 -0400 (EDT)
From: "Mark W. Alexander" <slash@dotnetslash.net>
To: Matthias Urlichs <smurf@smurf.noris.de>,
       linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: 2.6.0-test5 & test6 cd burning/scheduler/ide-scsi.c bug
In-Reply-To: <pan.2003.10.04.15.19.41.905451@smurf.noris.de>
Message-ID: <Pine.LNX.4.44.0310051928440.25623-100000@llave.eproinet.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 4 Oct 2003, Matthias Urlichs wrote:

> Hi, Zwane Mwaikambo wrote:
> 
> >>  This is my first bug submission, so please have patience with my noobness :)
> > 
> > The general consensus is that you should be using the direct ATAPI 
> > interface for cd-writing in 2.6.
> 
> That doesn't change the fact that programs which worked perfectly well
> under 2.4.xx now hang, instead of either working perfectly ;-) or getting
> hit with an error, or at least a deprecation warning.

The first problem is that those applications need to be notified that
"the times, they are a changin'." I suggest you submit bug reports to
them so they can at least fail hard and be given time to prepare for
the 2.6 way.

Second, it would be helpfull if somewhere in Documentation there was a
list of applications and what levels support the direct ATAPI
interface. I, too, am keeping ide_scsi arround. Sometimes I can play
DVD's without it, sometimes I have to manually futz with what modules
are loaded to get it to work without it, sometime I just can't get it
to work with out it. I suspect it's the arbitrary sequence of things I
do that hit the CD and I'm basicaly doing battle with the kernel
module loader.

In a nutshell, if I knew which application revs supported the ATAPI
interface I'd go get them and just be done with it.

mwa
-- 
Mark W. Alexander
slash@dotnetslash.net

