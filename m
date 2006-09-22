Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932528AbWIVOaF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932528AbWIVOaF (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 22 Sep 2006 10:30:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932532AbWIVOaF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 22 Sep 2006 10:30:05 -0400
Received: from ogre.sisk.pl ([217.79.144.158]:23481 "EHLO ogre.sisk.pl")
	by vger.kernel.org with ESMTP id S932528AbWIVOaB (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 22 Sep 2006 10:30:01 -0400
From: "Rafael J. Wysocki" <rjw@sisk.pl>
To: Jason Lunz <lunz@falooley.org>
Subject: Re: [PATCH -mm 5/6] mm: Print first block offset for swap areas
Date: Fri, 22 Sep 2006 16:32:54 +0200
User-Agent: KMail/1.9.1
Cc: Pavel Machek <pavel@ucw.cz>, Andrew Morton <akpm@osdl.org>,
       LKML <linux-kernel@vger.kernel.org>, Dave Jones <davej@redhat.com>
References: <20060921235340.DBD89822B@knob.reflex> <200609221257.12303.rjw@sisk.pl> <20060922141346.GA28949@opus.vpn-dev.reflex>
In-Reply-To: <20060922141346.GA28949@opus.vpn-dev.reflex>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200609221632.55169.rjw@sisk.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday, 22 September 2006 16:13, Jason Lunz wrote:
> On Fri, Sep 22, 2006 at 12:57:11PM +0200, Rafael J. Wysocki wrote:
> > This is filesystem-dependent.  AFAICT not all filesystems are supported
> > by GRUB.
> 
> of course, but it shows the technique is viable. Grub is 
> widespread, and if it's good enough for so many x86 users to boot with
> then the same approach ought to be adequate for resume, no?

Well, I'd like to avoid making _any_ assumptions regarding the partition
on which the "resume" swap file is located.

Also I think we can implement a simpler approach (ie. one that requires less
code changes in both the kernel and userland) first and then look for a
"nicer" one.

Greetings,
Rafael


-- 
You never change things by fighting the existing reality.
		R. Buckminster Fuller
