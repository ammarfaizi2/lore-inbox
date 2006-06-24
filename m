Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750920AbWFXRQN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750920AbWFXRQN (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 24 Jun 2006 13:16:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750927AbWFXRQN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 24 Jun 2006 13:16:13 -0400
Received: from ogre.sisk.pl ([217.79.144.158]:27302 "EHLO ogre.sisk.pl")
	by vger.kernel.org with ESMTP id S1750918AbWFXRQL (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 24 Jun 2006 13:16:11 -0400
From: "Rafael J. Wysocki" <rjw@sisk.pl>
To: Frederik Deweerdt <deweerdt@free.fr>
Subject: Re: [linux-pm] swsusp regression [Was: 2.6.17-mm1]
Date: Sat, 24 Jun 2006 19:16:43 +0200
User-Agent: KMail/1.9.3
Cc: Pavel Machek <pavel@ucw.cz>, Andrew Morton <akpm@osdl.org>, greg@kroah.com,
       linux-kernel@vger.kernel.org, linux-pm@osdl.org,
       stern@rowland.harvard.edu
References: <4499BE99.6010508@gmail.com> <20060623221117.GA2497@elf.ucw.cz> <20060623235357.GA1181@slug>
In-Reply-To: <20060623235357.GA1181@slug>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200606241916.43892.rjw@sisk.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Saturday 24 June 2006 01:53, Frederik Deweerdt wrote:
> On Sat, Jun 24, 2006 at 12:11:18AM +0200, Pavel Machek wrote:
> > On Fri 2006-06-23 20:41:01, Russell King wrote:
> > > On Fri, Jun 23, 2006 at 11:10:21AM +0200, Pavel Machek wrote:
> > > > Serial console is currently broken by suspend, resume. _But_ I have a
> > > > patch I'd like you to try.... pretty please?
> > > 
> > > Did you bother trying my patch, which was done the Right(tm) way?
> > > There wasn't any feedback on it so I can only assume not.
> > 
> > (I actually forwarded him your patch in private email).
> And I did try it, but it make no difference: the output would still
> appear on the laptop.

You can try to use the hack at
http://www.sisk.pl/kernel/patches/2.6.17-mm1/hack-serial-suspend.patch
and see if that makes the messages get to the serial console.

Greetings,
Rafael
