Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269575AbTHFPgo (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 6 Aug 2003 11:36:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269589AbTHFPgo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 6 Aug 2003 11:36:44 -0400
Received: from [195.141.226.27] ([195.141.226.27]:1298 "EHLO
	netline-mail1.netline.ch") by vger.kernel.org with ESMTP
	id S269575AbTHFPgm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 6 Aug 2003 11:36:42 -0400
Subject: Re: [Dri-devel] Re: any DRM update scheduled for 2.4.23-pre?
From: Michel =?ISO-8859-1?Q?D=E4nzer?= <michel@daenzer.net>
To: Marc-Christian Petersen <m.c.p@wolk-project.de>
Cc: Mikael Pettersson <mikpe@csd.uu.se>, faith@valinux.com,
       dri-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org,
       Mitch@0Bits.COM
In-Reply-To: <200308061714.36595.m.c.p@wolk-project.de>
References: <16177.5641.6571.273023@gargle.gargle.HOWL>
	 <200308061714.36595.m.c.p@wolk-project.de>
Content-Type: text/plain; charset=UTF-8
Organization: Debian, XFree86
Message-Id: <1060184195.32133.98.camel@thor.holligenstrasse29.lan>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.3 
Date: 06 Aug 2003 17:36:36 +0200
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2003-08-06 at 17:16, Marc-Christian Petersen wrote:
> On Wednesday 06 August 2003 16:51, Mikael Pettersson wrote:
> 
> > Is anyone planning to update the apparently obsolete(*)
> > DRM drivers currently in 2.4.22-pre/rc for 2.4.23?
> 
> I have a pending DRM 4.3 update for .23-pre1. Marcelo did not accept it for 
> .22 ( I sent it first while -pre9 time or so. )
> 
> It's a complete DRM-4.3 tree. 

Literally from XFree86 4.3, or from DRI CVS? The latter would be better,
as the former is no longer actively maintained.

> He has to decide between an update of existing 4.2 code or an 
> addition of a new subdirectory drm-4.3 + proper config.in entry.

There's no need for a separate directory, the DRM has been backwards
compatible since 4.2 at least, and countless bugs have been fixed since
then.

It would also be great if you could isolate DRM fixes in the kernel and
post patches here - some kernel developers keep complaining how broken
the DRM code is, but never submit patches...


-- 
Earthling Michel Dänzer   \  Debian (powerpc), XFree86 and DRI developer
Software libre enthusiast  \     http://svcs.affero.net/rm.php?r=daenzer

