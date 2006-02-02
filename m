Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751182AbWBBUZk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751182AbWBBUZk (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 2 Feb 2006 15:25:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751187AbWBBUZk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 2 Feb 2006 15:25:40 -0500
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:2476 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S1751182AbWBBUZk (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 2 Feb 2006 15:25:40 -0500
Date: Thu, 2 Feb 2006 21:25:27 +0100
From: Pavel Machek <pavel@ucw.cz>
To: Olivier Galibert <galibert@pobox.com>,
       Nigel Cunningham <nigel@suspend2.net>,
       Pekka Enberg <penberg@cs.helsinki.fi>, linux-kernel@vger.kernel.org
Subject: Re: [ 00/10] [Suspend2] Modules support.
Message-ID: <20060202202527.GC2264@elf.ucw.cz>
References: <20060201113710.6320.68289.stgit@localhost.localdomain> <200602022131.59928.nigel@suspend2.net> <84144f020602020344p228e20b2x34226f341c296578@mail.gmail.com> <200602022228.20032.nigel@suspend2.net> <20060202154319.GA96923@dspnet.fr.eu.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20060202154319.GA96923@dspnet.fr.eu.org>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Čt 02-02-06 16:43:19, Olivier Galibert wrote:
> On Thu, Feb 02, 2006 at 10:28:15PM +1000, Nigel Cunningham wrote:
> > Shouldn't the question be "Why are we making this more complicated by moving 
> > it to userspace?"
> 
> Indeed.  It seems that turning the kernel into Hurd is the latest
> fad.

Heh, try reading suspend2.

> One question I'm wondering about though is that 99% of the "suspend
> doesn't work reliably" messages were answered by "it's a driver's
> fault".  I'm rather curious on how moving things to userspace is going
> to fix that.

uswsusp is not going to fix driver's problems, but at least should not
add new problems. It is aimed at solving graphical bars, compression,
encryption etc.
								Pavel
-- 
Thanks, Sharp!
