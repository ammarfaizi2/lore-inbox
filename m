Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261265AbTICJTH (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 3 Sep 2003 05:19:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261537AbTICJTH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 3 Sep 2003 05:19:07 -0400
Received: from mail3.bluewin.ch ([195.186.1.75]:1738 "EHLO mail3.bluewin.ch")
	by vger.kernel.org with ESMTP id S261265AbTICJTF (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 3 Sep 2003 05:19:05 -0400
Date: Wed, 3 Sep 2003 11:17:29 +0200
From: Roger Luethi <rl@hellgate.ch>
To: Arjan van de Ven <arjanv@redhat.com>
Cc: Damian Kolkowski <deimos@deimos.one.pl>,
       Danny ter Haar <dth@ncc1701.cistron.net>, linux-kernel@vger.kernel.org
Subject: Re: 2.6.0-test4(-mmX) via-rhine ethernet onboard C3 mini-itx doesn't work
Message-ID: <20030903091729.GA28495@k3.hellgate.ch>
Mail-Followup-To: Arjan van de Ven <arjanv@redhat.com>,
	Damian Kolkowski <deimos@deimos.one.pl>,
	Danny ter Haar <dth@ncc1701.cistron.net>,
	linux-kernel@vger.kernel.org
References: <bj447c$el6$1@news.cistron.nl> <20030903074902.GA1786@deimos.one.pl> <1062576819.5058.2.camel@laptop.fenrus.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1062576819.5058.2.camel@laptop.fenrus.com>
X-Operating-System: Linux 2.6.0-test4 on i686
X-GPG-Fingerprint: 92 F4 DC 20 57 46 7B 95  24 4E 9E E7 5A 54 DC 1B
X-GPG: 1024/80E744BD wwwkeys.ch.pgp.net
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 03 Sep 2003 10:13:39 +0200, Arjan van de Ven wrote:
> if you enable APIC (and not ACPI) then you start using a different BIOS
> table for IRQ routing. Several BIOSes have bugs in this table since it's
> not a table that is generally used by Windows on UP boxes. Saying that
> it's the kernel's fault is rather unfair; most (if not all) distros for

What I've been seeing lately is people complaining it used to work with
previous kernels but later ones don't. One possible explanation would be
that VIA chip sets (explicitly or through one of their specific properties)
used to be blacklisted before (and thus APIC silently disabled).

The reports I get indicate that _something_ in the kernel changed. I
suspect it's the ACPI code (best viewed with Intel chipsets), but that's
speculation.

Roger
