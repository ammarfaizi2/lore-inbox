Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750830AbWKAXLH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750830AbWKAXLH (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Nov 2006 18:11:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750833AbWKAXLH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Nov 2006 18:11:07 -0500
Received: from ogre.sisk.pl ([217.79.144.158]:5302 "EHLO ogre.sisk.pl")
	by vger.kernel.org with ESMTP id S1750953AbWKAXLD (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Nov 2006 18:11:03 -0500
From: "Rafael J. Wysocki" <rjw@sisk.pl>
To: Dave Jones <davej@redhat.com>
Subject: Re: Remove hotplug cpu crap from cpufreq.
Date: Thu, 2 Nov 2006 00:09:17 +0100
User-Agent: KMail/1.9.1
Cc: Linux Kernel <linux-kernel@vger.kernel.org>,
       Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>,
       Pavel Machek <pavel@ucw.cz>
References: <20061101225925.GA17363@redhat.com>
In-Reply-To: <20061101225925.GA17363@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200611020009.17711.rjw@sisk.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Wednesday, 1 November 2006 23:59, Dave Jones wrote:
> I've had it with this stuff.  For months, we've had various warnings
> popping up from this code (which was clearly half-baked at best when it
> went in).
> 
> Until someone steps up who actually gives a damn about fixing it, can
> we just rip this crap out so I stop getting mails from users who couldn't
> care less about CPU hotplug anyway?

Won't there be any problems with suspend on SMP vs cpufreq if this stuff is
removed?

Rafael
