Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262331AbTLQAOU (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 16 Dec 2003 19:14:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262427AbTLQAOU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 16 Dec 2003 19:14:20 -0500
Received: from adsl-206-170-148-147.dsl.snfc21.pacbell.net ([206.170.148.147]:8387
	"EHLO gw.goop.org") by vger.kernel.org with ESMTP id S262331AbTLQAON
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 16 Dec 2003 19:14:13 -0500
Subject: Re: [OT] "unauthorized" mini-pci wlan cards in thinkpads
From: Jeremy Fitzhardinge <jeremy@goop.org>
To: Scott Mcdermott <vaxerdec@frontiernet.net>
Cc: linux-kernel <linux-kernel@vger.kernel.org>,
       "Bryan O'Sullivan" <bos@serpentine.com>
In-Reply-To: <20031215174349.C17007@newbox.localdomain>
References: <20031215174349.C17007@newbox.localdomain>
Content-Type: multipart/mixed; boundary="=-F4fwfRPYtMWUgrD18nuj"
Message-Id: <1071619961.6205.28.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 
Date: Tue, 16 Dec 2003 16:12:41 -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-F4fwfRPYtMWUgrD18nuj
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

On Mon, 2003-12-15 at 14:43, Scott Mcdermott wrote:
> Has anyone heard more about this from IBM or know of some
> way to disable the whitelist checking? It's really a shame
> to not be able to use the nice builtin antennas in these
> laptops with newer Mini-PCI cards (like the a/b/g combo that
> IBM themselves make, which is still "unauthorized" on both
> my X31 and T30 with latest BIOS) and instead be forced to
> waste a PCMCIA slot and not get as good a signal.

Bryan O'Sullivan just posted saying that he got an Atheros card from IBM
which works, but only after a BIOS update.  I've attached his message. 
I'm hoping to try one of these out myself soon (I've got a Cisco card,
but the driver is really only just works).

	J

--=-F4fwfRPYtMWUgrD18nuj
Content-Disposition: inline
Content-Type: message/rfc822

Return-Path: <cyrus@gw.goop.org>
X-Sieve: cmu-sieve 2.0
Return-Path: <linux-kernel-owner+jeremy=40goop.org@vger.kernel.org>
Received: by gw.goop.org (Postfix, from userid 525) id 1F06B78507; Wed, 10
	Dec 2003 08:48:43 -0800 (PST)
Received: from vger.kernel.org (vger.kernel.org [67.72.78.212]) by
	gw.goop.org (Postfix) with ESMTP id 8F9B7784A7 for <jeremy@goop.org>; Wed,
	10 Dec 2003 08:48:31 -0800 (PST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
	S263636AbTLJQph (ORCPT <rfc822;jeremy@goop.org>); Wed, 10 Dec 2003 11:45:37
	-0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263740AbTLJQph
	(ORCPT <rfc822;linux-kernel-outgoing>); Wed, 10 Dec 2003 11:45:37 -0500
Received: from dsl092-013-071.sfo1.dsl.speakeasy.net ([66.92.13.71]:3248
	"EHLO pelerin.serpentine.com") by vger.kernel.org with ESMTP id
	S263636AbTLJQph (ORCPT <rfc822;linux-kernel@vger.kernel.org>); Wed, 10 Dec
	2003 11:45:37 -0500
Received: from [192.168.16.5] (camp4.serpentine.com [192.168.16.5]) by
	pelerin.serpentine.com (Postfix) with ESMTP id 4B35776C330; Wed, 10 Dec
	2003 08:45:36 -0800 (PST)
Subject: Update for IBM Thinkpad X31 and T40 users wishing to use miniPCI
	wifi cards
From: Bryan O'Sullivan <bos@serpentine.com>
To: linux-kernel@vger.kernel.org
Cc: durey@EmperorLinux.com
Content-Type: text/plain
Message-Id: <1071074736.16162.12.camel@camp4.serpentine.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 (1.4.5-7) 
Date: Wed, 10 Dec 2003 08:45:36 -0800
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
X-Spam-Checker-Version: SpamAssassin 2.60 (1.212-2003-09-23-exp) on 
	gw.goop.org
X-Spam-Status: No, hits=-4.3 required=6.0 tests=AWL,BAYES_00 autolearn=ham 
	version=2.60
X-Spam-Level: 
X-Evolution-Source: imap://jeremy@mail.goop.org/
Content-Transfer-Encoding: 7bit

IBM has a newish Atheros-based 802.11a/b/g card, model number 31P9701,
which works with the Thinkpad X31.  I received mine last night and got
the infamous error 1802 (card not authorized).

I unplugged the miniPCI card and updated the X31's BIOS to revision
2.04, version 1QET66WW, dated 2003/12/02.  (I believe you must still
have Windows available to do this.)  The system now boots happily, and
the madwifi driver drives the card OK for me under both 2.4 and 2.6.

I assume that the PCI whitelist of infamy is still in place in the
latest BIOS, but at least it now supports a modern wifi card model.

	<b

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
Please read the FAQ at  http://www.tux.org/lkml/

--=-F4fwfRPYtMWUgrD18nuj--

