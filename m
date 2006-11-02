Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1752714AbWKBHqI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752714AbWKBHqI (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 2 Nov 2006 02:46:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752718AbWKBHqI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 2 Nov 2006 02:46:08 -0500
Received: from holoclan.de ([62.75.158.126]:2794 "EHLO mail.holoclan.de")
	by vger.kernel.org with ESMTP id S1752714AbWKBHqF (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 2 Nov 2006 02:46:05 -0500
Date: Thu, 2 Nov 2006 08:33:53 +0100
From: Martin Lorenz <martin@lorenz.eu.org>
To: Linus Torvalds <torvalds@osdl.org>
Cc: "Rafael J. Wysocki" <rjw@sisk.pl>, Dave Jones <davej@redhat.com>,
       Linux Kernel <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>, Pavel Machek <pavel@ucw.cz>
Subject: Re: Remove hotplug cpu crap from cpufreq.
Message-ID: <20061102073353.GH6170@gimli>
Mail-Followup-To: Linus Torvalds <torvalds@osdl.org>,
	"Rafael J. Wysocki" <rjw@sisk.pl>, Dave Jones <davej@redhat.com>,
	Linux Kernel <linux-kernel@vger.kernel.org>,
	Andrew Morton <akpm@osdl.org>, Pavel Machek <pavel@ucw.cz>
References: <20061101225925.GA17363@redhat.com> <200611020009.17711.rjw@sisk.pl> <Pine.LNX.4.64.0611011512450.25218@g5.osdl.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0611011512450.25218@g5.osdl.org>
User-Agent: Mutt/1.5.13 (2006-08-11)
X-Spam-Score: -1.4 (-)
X-Spam-Report: Spam detection software, running on the system "www.holoclan.de", has
	identified this incoming email as possible spam.  The original message
	has been attached to this so you can view it (if it isn't spam) or label
	similar future email.  If you have any questions, see
	the administrator of that system for details.
	Content preview:  On Wed, Nov 01, 2006 at 03:21:09PM -0800, Linus Torvalds
	wrote: > > > On Thu, 2 Nov 2006, Rafael J. Wysocki wrote: > > > > Won't
	there be any problems with suspend on SMP vs cpufreq if this stuff is >
	> removed? > > Well, at least traditionally, the hotplug locking has
	caused more problems > than it has fixed, but at least right _now_ it
	seems to work. [...] 
	Content analysis details:   (-1.4 points, 5.0 required)
	pts rule name              description
	---- ---------------------- --------------------------------------------------
	-1.4 ALL_TRUSTED            Passed through trusted hosts only via SMTP
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 01, 2006 at 03:21:09PM -0800, Linus Torvalds wrote:
> 
> 
> On Thu, 2 Nov 2006, Rafael J. Wysocki wrote:
> > 
> > Won't there be any problems with suspend on SMP vs cpufreq if this stuff is
> > removed?
> 
> Well, at least traditionally, the hotplug locking has caused more problems 
> than it has fixed, but at least right _now_ it seems to work.

if I am not completely mistaken I also need this for proper 
suspend/resume on my X60s (CoreDUO machine) and THIS is one of 
the things that DO work.

gruss
  mlo
--
Dipl.-Ing. Martin Lorenz

            They that can give up essential liberty 
	    to obtain a little temporary safety 
	    deserve neither liberty nor safety.
                                   Benjamin Franklin

please encrypt your mail to me
GnuPG key-ID: F1AAD37D
get it here:
http://blackhole.pca.dfn.de:11371/pks/lookup?op=get&search=0xF1AAD37D

ICQ UIN: 33588107
