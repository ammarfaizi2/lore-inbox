Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751102AbWD3Mg2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751102AbWD3Mg2 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 30 Apr 2006 08:36:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751104AbWD3Mg2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 30 Apr 2006 08:36:28 -0400
Received: from 0x55511dab.adsl.cybercity.dk ([85.81.29.171]:53849 "EHLO
	hunin.borkware.net") by vger.kernel.org with ESMTP id S1751102AbWD3Mg2
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 30 Apr 2006 08:36:28 -0400
Subject: Re: World writable tarballs
From: Mark Rosenstand <mark@borkware.net>
To: Alistair John Strachan <s0348365@sms.ed.ac.uk>
Cc: Heikki Orsila <shd@zakalwe.fi>, linux-kernel@vger.kernel.org
In-Reply-To: <200604301249.16259.s0348365@sms.ed.ac.uk>
References: <1146356286.10953.7.camel@hammer>
	 <200604300148.12462.s0348365@sms.ed.ac.uk>
	 <20060430091501.GA19566@zakalwe.fi>
	 <200604301249.16259.s0348365@sms.ed.ac.uk>
Content-Type: text/plain
Date: Sun, 30 Apr 2006 14:36:54 +0200
Message-Id: <1146400614.15178.14.camel@hammer>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2006-04-30 at 12:49 +0100, Alistair John Strachan wrote:
> Going over old ground again, any administrator a) compiling the kernel as root 
> or b) relying on GNU tar to make _security policy decisions_ is completely 
> insane.

Yes, GNU tar is acting insane. Given that GNU tar is the most widely
used tar implementation (at least for extracting linux sources), why is
the kernel packaged to exploit this insane behaviour?

> Really, people that complain about security should have a modicum of a clue; 
> allowing a tar file that _somebody else_ applied _their_ security policy, to 
> define yours, is a deeply flawed concept. umask is there for a reason.

I merely asked if it was on purpose. In my point of view, it's wrong to
deliberately expose people to such big security threads.

That said, the kernel source is actually the only thing I extract as
root, mostly because I think it's weird to have symlinks in /lib/modules
point to my user's home directory.

