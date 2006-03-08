Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751777AbWCHRsM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751777AbWCHRsM (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 8 Mar 2006 12:48:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751808AbWCHRsM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 8 Mar 2006 12:48:12 -0500
Received: from smtp.hrz.uni-kassel.de ([141.51.12.230]:16782 "EHLO
	hrz-ws39.hrz.uni-kassel.de") by vger.kernel.org with ESMTP
	id S1751777AbWCHRsL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 8 Mar 2006 12:48:11 -0500
Subject: Re: [Suspend2-announce] Nigel's work and the future of Suspend2.
From: Thomas Maier <Thomas.Maier@uni-kassel.de>
To: Pavel Machek <pavel@ucw.cz>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20060308122500.GB3274@elf.ucw.cz>
References: <200603071005.56453.nigel@suspend2.net>
	 <1141737241.5386.28.camel@marvin.se.eecs.uni-kassel.de>
	 <20060308122500.GB3274@elf.ucw.cz>
Content-Type: text/plain; charset=UTF-8
Date: Wed, 08 Mar 2006 18:45:15 +0100
Message-Id: <1141839915.5382.49.camel@marvin.se.eecs.uni-kassel.de>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.2.1 
Content-Transfer-Encoding: 8bit
X-UNIK-SMTP-MailScanner: Found to be clean
X-UNIK-SMTP-MailScanner-From: thomas.maier@uni-kassel.de
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Am Mittwoch, den 08.03.2006, 13:25 +0100 schrieb Pavel Machek:
> On Út 07-03-06 14:14:00, Thomas Maier wrote:
> > Hi Nigel,
> > 
> > congratulations and all the best, although this sounds like a sad
> > goodbye and resignation.  I always hoped for inclusion in mainline and
> > followed the "discussions" on lkml, although Pavel never made an effort
> > to hide his ignorant arrogance.  
> 
> At least you can't say I was dishonest :-/.

:).


> > Mainline swsusp never worked for me and
> > so with you leaving I am tempted to leave Linux behind after more than
> > ten years and switch to that other OS that at least has working suspend
> > and resume.  
> 
> Your choice... But it would be more productive to read the docs, go to
> the latest kernel, and if it does not work there, file
> bugzilla.kernel.org report.

This is sort of a mandelbug to me.  Might you give me a hint what to do
if I only got problems every now and then?   Because it works sometimes
but hangs my machine silently occasionally on resume (suspend actually
always works).  Sometimes I get 20 suspend/resume cycles, sometimes I do
not even get a single one.  With growing kernel versions (from 2.6.9 to
2.6.13 or 14 (last one I checked)) the number of cycles seemed to drop
down to lower values (like two to five), although I do not really have
collected data and this is more of a feeling.  I doubt it is a different
set of modules loaded as my typical session is always very similar with
always the same hardware plugged in (a notebook, Gnome, Firefox,
Evolution, Eclipse, several terminals).  I use the hibernate script from
the hibernate Debian package.

Unfortunately, I am not kernel developer's darling, as I will not be
able to test different kernel versions and/or patches quickly.  This is
my work machine and it is my only one, so I can at most hack it on
weekends (and these days I even work on weekends).  Plus I am more the
luser kind of user.  Sure, I patched and compiled several kernels but I
always felt uncomfortable doing it :).

The only useful thing I could imagine is to try to boot a very minimal
system and try a lot of cycles and see if it hangs there, too.  But even
then I see only little hope to file a helpful bug report that might lead
to finding a solution.

Suggestions?  Thomas.


