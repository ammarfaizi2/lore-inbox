Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1756917AbWKVGmO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756917AbWKVGmO (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 22 Nov 2006 01:42:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756918AbWKVGmO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 22 Nov 2006 01:42:14 -0500
Received: from 85.8.24.16.se.wasadata.net ([85.8.24.16]:3223 "EHLO
	smtp.drzeus.cx") by vger.kernel.org with ESMTP id S1756917AbWKVGmN
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 22 Nov 2006 01:42:13 -0500
Message-ID: <4563F14C.9060100@drzeus.cx>
Date: Wed, 22 Nov 2006 07:42:20 +0100
From: Pierre Ossman <drzeus-mmc@drzeus.cx>
User-Agent: Thunderbird 1.5.0.7 (X11/20061027)
MIME-Version: 1.0
To: Alex Dubov <oakad@yahoo.com>
CC: kernel list <linux-kernel@vger.kernel.org>, Andrew Morton <akpm@osdl.org>
Subject: Re: [PATCH 1/1] MMC: new version of the TI Flash Media card reader
 driver
References: <281931.6630.qm@web36709.mail.mud.yahoo.com>
In-Reply-To: <281931.6630.qm@web36709.mail.mud.yahoo.com>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alex Dubov wrote:
> I know that the patch is too big, but I have no way to split it up. Basically, I've changed so
> many things (I had quite a few problems with interrupts after suspend/resume) that it can be
> regarded as a brand new driver. My SVN became somewhat messy too.
> 
> I can post the driver in it full (non-diff) form or as a 4 per-file diffs, but I have no way to
> split it up into per-issue form (except for issues 3 and 5, which are one-liners).
> 

That's a start. But 4 sounds like it could be broken out with some work.

I'm not saying it's trivial to break this apart, but it is something
that needs to be done. At the very least the commit messages need to
reflect what is changed and why.

See it as practice as this is an issue you will be hit by now and then
as a kernel developer. :)

Rgds
-- 
     -- Pierre Ossman

  Linux kernel, MMC maintainer        http://www.kernel.org
  PulseAudio, core developer          http://pulseaudio.org
  rdesktop, core developer          http://www.rdesktop.org
