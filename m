Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261738AbTICJ6k (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 3 Sep 2003 05:58:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261756AbTICJ6j
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 3 Sep 2003 05:58:39 -0400
Received: from news.cistron.nl ([62.216.30.38]:6412 "EHLO ncc1701.cistron.net")
	by vger.kernel.org with ESMTP id S261738AbTICJ6i (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 3 Sep 2003 05:58:38 -0400
From: dth@ncc1701.cistron.net (Danny ter Haar)
Subject: Re: 2.6.0-test4(-mmX) via-rhine ethernet onboard C3 mini-itx
	doesn't work
Date: Wed, 3 Sep 2003 09:58:37 +0000 (UTC)
Organization: Cistron
Message-ID: <bj4e0d$5e5$1@news.cistron.nl>
References: <bj447c$el6$1@news.cistron.nl> <20030903074902.GA1786@deimos.one.pl> <1062576819.5058.2.camel@laptop.fenrus.com>
X-Trace: ncc1701.cistron.net 1062583117 5573 62.216.30.38 (3 Sep 2003 09:58:37 GMT)
X-Complaints-To: abuse@cistron.nl
X-Newsreader: trn 4.0-test76 (Apr 2, 2001)
Originator: dth@ncc1701.cistron.net (Danny ter Haar)
To: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Arjan van de Ven  <arjanv@redhat.com> wrote:
>if you enable APIC (and not ACPI) then you start using a different BIOS
>table for IRQ routing. Several BIOSes have bugs in this table since it's
>not a table that is generally used by Windows on UP boxes. Saying that
>it's the kernel's fault is rather unfair; most (if not all) distros for
>example ship with APIC disabled for this reason. It's nice if it works
>for you but there's quite a few boxes out there that just can't work....
>Don't configure it if you have such a box.

I tried 2.6.0-test4-mm2 on other C3 (bought several units including for in my car ;) and that one simply froze after detecting the partiton table of the ide harddisk. adding acpi=off even made then one move again.

When confuses me if that it works with prior kernels and suddenly fails
with later/greater kernels.

Ah well, it's now better known and probably some clever individual will
eventually figure it out and post a patch ! ;-)

Danny

-- 
I think so Brain, but why does a forklift 
have to be so big if all it does is lift forks?

