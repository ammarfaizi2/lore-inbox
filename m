Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262451AbUCRHVi (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 18 Mar 2004 02:21:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262454AbUCRHVi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 18 Mar 2004 02:21:38 -0500
Received: from inova102.correio.tnext.com.br ([200.222.67.102]:35472 "HELO
	leia-auth.correio.tnext.com.br") by vger.kernel.org with SMTP
	id S262451AbUCRHVg convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 18 Mar 2004 02:21:36 -0500
X-Analyze: Velop Mail Shield v0.0.3
Date: Thu, 18 Mar 2004 04:21:33 -0300 (BRT)
From: =?ISO-8859-1?Q?Fr=E9d=E9ric_L=2E_W=2E_Meunier?= <1@pervalidus.net>
To: Vojtech Pavlik <vojtech@suse.cz>
cc: Peter Williams <peterw@aurema.com>, linux-kernel@vger.kernel.org
Subject: Re: XFree86 seems to be being wrongly accused of doing the wrong
 thing
In-Reply-To: <20040318071754.GA499@ucw.cz>
Message-ID: <Pine.LNX.4.58.0403180417470.1276@pervalidus.dyndns.org>
References: <40593015.9090507@aurema.com> <Pine.LNX.4.58.0403180346000.1276@pervalidus.dyndns.org>
 <20040318071754.GA499@ucw.cz>
X-Archive: encrypt
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 18 Mar 2004, Vojtech Pavlik wrote:

> On Thu, Mar 18, 2004 at 03:56:35AM -0300, Frédéric L. W. Meunier wrote:
>
> > Wrongly ? I don't think so, as it has presumably been fixed in
> > XFree86 after 4.4.0.
> >
> > http://www.xfree86.org/cvs/changes.html:
> >
> > 6. Do the Linux KDKBDREP ioctl on the correct fd.  This
> > prevents the fallback that tries to directly program the
> > keyboard repeat rate, and the related warning messages that
> > recent Linux kernels generate (David Dawes).
> >
> > I'm attaching the patch I extracted from CVS.
> >
> > Vojtech, what about adding such information to your HOWTO ? And
> > better, adding the URL to atkbd.c, so people stop reporting it.
>
> I'll add the info and the URL into the HOWTO and kill the message.

Here are the URLs directly from CVS (just in case someone
doesn't trust the diff I sent):

http://cvsweb.xfree86.org/cvsweb/xc/programs/Xserver/hw/xfree86/os-support/linux/lnx_io.c.diff?r1=3.26&r2=3.27
http://cvsweb.xfree86.org/cvsweb/xc/programs/Xserver/hw/xfree86/os-support/linux/lnx_kbd.c.diff?r1=1.5&r2=1.6

-- 
http://www.pervalidus.net/contact.html
