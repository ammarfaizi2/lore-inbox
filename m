Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266666AbUBFHPd (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 6 Feb 2004 02:15:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266669AbUBFHPc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 6 Feb 2004 02:15:32 -0500
Received: from tomts5.bellnexxia.net ([209.226.175.25]:39643 "EHLO
	tomts5-srv.bellnexxia.net") by vger.kernel.org with ESMTP
	id S266666AbUBFHP2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 6 Feb 2004 02:15:28 -0500
Date: Fri, 6 Feb 2004 02:15:22 -0500
From: Mike Houston <mikeserv@bmts.com>
To: linux-kernel@vger.kernel.org
Subject: Re: psmouse.c, throwing 3 bytes away
Message-Id: <20040206021522.12dfd362.mikeserv@bmts.com>
In-Reply-To: <20040205171028.652a694c.mikeserv@bmts.com>
References: <200402041820.39742.wnelsonjr@comcast.net>
	<200402051517.37466.murilo_pontes@yahoo.com.br>
	<20040205203840.GA13114@ucw.cz>
	<20040205171028.652a694c.mikeserv@bmts.com>
X-Mailer: Sylpheed version 0.9.8a (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 5 Feb 2004 17:10:27 -0500
Mike Houston <mikeserv@bmts.com> wrote:

> I am using ACPI and IO-APIC. Next time my mouse acts up, I will consider trying
> 2.6.2 without ACPI and IO-APIC (though I'd hate to lose that functionality).
> Trouble is it might take a long time for the mouse glitch to occur.

Ok, shortly after posting earlier today, it did indeed happen again with 2.6.2. I was just clicking on mails in my sylpheed client. There wasn't much load, I wasn't doing anything but reading mails.

So I built another 2.6.2 with acpi and io-apic disabled and ran it for about 5 hours and the problem reoccurred. I was just chatting on IRC and moved my mouse and it happened. Again, I was doing nothing else so load wasn't a factor.

psmouse.c: MX Mouse at isa0060/serio1/input0 lost synchronization, throwing 2 bytes away.

Gee whiz, it just happened again while composing this mail :-)

So it doesn't have anything to do with acpi, or being under load for that matter, on my system, anyway.

Mike
