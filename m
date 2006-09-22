Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932170AbWIVKyQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932170AbWIVKyQ (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 22 Sep 2006 06:54:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932171AbWIVKyP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 22 Sep 2006 06:54:15 -0400
Received: from ogre.sisk.pl ([217.79.144.158]:439 "EHLO ogre.sisk.pl")
	by vger.kernel.org with ESMTP id S932170AbWIVKyP (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 22 Sep 2006 06:54:15 -0400
From: "Rafael J. Wysocki" <rjw@sisk.pl>
To: Jason Lunz <lunz@falooley.org>
Subject: Re: [PATCH -mm 5/6] mm: Print first block offset for swap areas
Date: Fri, 22 Sep 2006 12:57:11 +0200
User-Agent: KMail/1.9.1
Cc: Pavel Machek <pavel@ucw.cz>, Andrew Morton <akpm@osdl.org>,
       LKML <linux-kernel@vger.kernel.org>, Dave Jones <davej@redhat.com>
References: <20060921235340.DBD89822B@knob.reflex> <20060921235817.GA27170@knob.reflex>
In-Reply-To: <20060921235817.GA27170@knob.reflex>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200609221257.12303.rjw@sisk.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday, 22 September 2006 01:58, Jason Lunz wrote:
> > The entire problem is we can't use file names during resume, because
> > we can't mount filesystems at that time, so we need to represent the
> > swap header's location in a filesystem-independent way.
> 
> grub reads files without mounting the filesystem. And it has to find the
> entire file, not just the beginning. Maybe swsusp could use that
> technique? If not the in-kernel one, surely the userland version
> could.

This is filesystem-dependent.  AFAICT not all filesystems are supported
by GRUB.

Greetings,
Rafael


-- 
You never change things by fighting the existing reality.
		R. Buckminster Fuller
