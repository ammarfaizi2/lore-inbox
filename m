Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265940AbTLIOwj (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 9 Dec 2003 09:52:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265943AbTLIOv0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 9 Dec 2003 09:51:26 -0500
Received: from rogue.ncsl.nist.gov ([129.6.101.41]:15524 "EHLO
	rogue.ncsl.nist.gov") by vger.kernel.org with ESMTP id S265940AbTLIOuo
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 9 Dec 2003 09:50:44 -0500
To: linux-kernel@vger.kernel.org
Subject: Re: cdrecord hangs my computer
References: <20031207110122.GB13844@zombie.inka.de>
	<Pine.LNX.4.58.0312070812080.2057@home.osdl.org>
	<br28f2$fen$1@gatekeeper.tmr.com>
	<200312081753.hB8HrQfD019477@turing-police.cc.vt.edu>
	<Pine.LNX.4.58.0312081046200.13236@home.osdl.org>
	<200312081940.hB8Je8fD023223@turing-police.cc.vt.edu>
From: Ian Soboroff <ian.soboroff@nist.gov>
Date: Tue, 09 Dec 2003 09:50:42 -0500
In-Reply-To: <200312081940.hB8Je8fD023223@turing-police.cc.vt.edu> (Valdis
 Kletnieks's message of "Mon, 08 Dec 2003 14:40:08 -0500")
Message-ID: <9cfiskqjb99.fsf@rogue.ncsl.nist.gov>
User-Agent: Gnus/5.1003 (Gnus v5.10.3) Emacs/21.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Valdis.Kletnieks@vt.edu writes:

> The stuff that supports LABEL= on a partition is a *partial*
> solution to decouple the name of the device as the system found it
> from a logical name, but as many have noted, it has its own issues.

Yes, labels and UUIDs are great for those of us with lots of SCSI
devices, so that adding a controller or changing a cable doesn't
require _two_ boots (one to figure out where everything went and edit
/etc/fstab, one for real).

I wish I could LABEL swap partitions.

Ian

