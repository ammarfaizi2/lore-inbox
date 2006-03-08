Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932449AbWCHUjw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932449AbWCHUjw (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 8 Mar 2006 15:39:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932452AbWCHUjw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 8 Mar 2006 15:39:52 -0500
Received: from ogre.sisk.pl ([217.79.144.158]:41359 "EHLO ogre.sisk.pl")
	by vger.kernel.org with ESMTP id S932449AbWCHUjv convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 8 Mar 2006 15:39:51 -0500
From: "Rafael J. Wysocki" <rjw@sisk.pl>
To: Thomas Maier <Thomas.Maier@uni-kassel.de>
Subject: Re: [Suspend2-announce] Nigel's work and the future of Suspend2.
Date: Wed, 8 Mar 2006 21:39:05 +0100
User-Agent: KMail/1.9.1
Cc: Pavel Machek <pavel@ucw.cz>, linux-kernel@vger.kernel.org
References: <200603071005.56453.nigel@suspend2.net> <20060308122500.GB3274@elf.ucw.cz> <1141839915.5382.49.camel@marvin.se.eecs.uni-kassel.de>
In-Reply-To: <1141839915.5382.49.camel@marvin.se.eecs.uni-kassel.de>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 8BIT
Content-Disposition: inline
Message-Id: <200603082139.06259.rjw@sisk.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 08 March 2006 18:45, Thomas Maier wrote:
> Am Mittwoch, den 08.03.2006, 13:25 +0100 schrieb Pavel Machek:
> > On Út 07-03-06 14:14:00, Thomas Maier wrote:
}-- snip --{
> > > Mainline swsusp never worked for me and
> > > so with you leaving I am tempted to leave Linux behind after more than
> > > ten years and switch to that other OS that at least has working suspend
> > > and resume.

Frankly that's something I really don't understand.  swsusp is supposed to
work (actually with 2.6.16-rc5-mm2 it works for me 100% of the time) and
if it doesn't work for you, there's a bug and it should be fixed.  Yet, you
don't report it, so it is unknown to anyone except for you and there's no
hope anyone will actually work on fixing it.

> > Your choice... But it would be more productive to read the docs, go to
> > the latest kernel, and if it does not work there, file
> > bugzilla.kernel.org report.

> 
> This is sort of a mandelbug to me.  Might you give me a hint what to do
> if I only got problems every now and then?   Because it works sometimes
> but hangs my machine silently occasionally on resume (suspend actually
> always works).  Sometimes I get 20 suspend/resume cycles, sometimes I do
> not even get a single one.  With growing kernel versions (from 2.6.9 to
> 2.6.13 or 14 (last one I checked)) the number of cycles seemed to drop
> down to lower values (like two to five), although I do not really have
> collected data and this is more of a feeling.

Then could you please get some data?  Also full dmesg and lsmod listing
from your system will help, as well as the output of lspci -vvv.

> I doubt it is a different set of modules loaded as my typical session is
> always very similar with always the same hardware plugged in (a notebook,
> Gnome, Firefox, Evolution, Eclipse, several terminals).  I use the hibernate
> script from the hibernate Debian package.
> 
> Unfortunately, I am not kernel developer's darling, as I will not be
> able to test different kernel versions and/or patches quickly.  This is
> my work machine and it is my only one, so I can at most hack it on
> weekends (and these days I even work on weekends).  Plus I am more the
> luser kind of user.  Sure, I patched and compiled several kernels but I
> always felt uncomfortable doing it :).

If you can try 2.6.16 when it's out and see how it works for you wrt
suspend/resume, that will help either.

Greetings,
Rafael
