Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261757AbTICJaa (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 3 Sep 2003 05:30:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261761AbTICJa3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 3 Sep 2003 05:30:29 -0400
Received: from meryl.it.uu.se ([130.238.12.42]:23481 "EHLO meryl.it.uu.se")
	by vger.kernel.org with ESMTP id S261757AbTICJaZ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 3 Sep 2003 05:30:25 -0400
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16213.46254.376174.466098@gargle.gargle.HOWL>
Date: Wed, 3 Sep 2003 11:30:22 +0200
From: Mikael Pettersson <mikpe@csd.uu.se>
To: Damian Kolkowski <deimos@deimos.one.pl>
Cc: Danny ter Haar <dth@ncc1701.cistron.net>, linux-kernel@vger.kernel.org
Subject: Re: 2.6.0-test4(-mmX) via-rhine ethernet onboard C3 mini-itx doesn't work
In-Reply-To: <20030903074902.GA1786@deimos.one.pl>
References: <bj447c$el6$1@news.cistron.nl>
	<20030903074902.GA1786@deimos.one.pl>
X-Mailer: VM 6.90 under Emacs 20.7.1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Damian Kolkowski writes:
 > On Wed, Sep 03, 2003 at 07:11:40AM +0000, Danny ter Haar wrote:
 > > vanilla 2.6.0-test4 & test4-mm[45] & the onboard ethernet doesn't seem to work.
 > > No kernel panics, it just doesn't work :-(
 > 
 > It's standard APIC bug that no one care!

It's impossible to have an APIC bug on a C3 board, because the processor
simply doesn't have one!

Another respondent today said that disabling ACPI (note ACPI != APIC)
solved his problems.

 > > Haven't seen anyone else report this, but this is repeatable and i suspect
 > > more people must have experienced this ?!
 > 
 > I report this bug probably 4 times! And it was since early 2.4.20, then APIC
 > changes, so I can use if.

I saw your previous report. It was basically information-free and impossible
to base any problem analysis on. If you want your bug reports to have a
chance of being acted upon, follow the documented bug reporting procedure.
