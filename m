Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265444AbTFWWdd (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 23 Jun 2003 18:33:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265474AbTFWWdd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 23 Jun 2003 18:33:33 -0400
Received: from x35.xmailserver.org ([208.129.208.51]:62350 "EHLO
	x35.xmailserver.org") by vger.kernel.org with ESMTP id S265444AbTFWWd3
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 23 Jun 2003 18:33:29 -0400
X-AuthUser: davidel@xmailserver.org
Date: Mon, 23 Jun 2003 15:45:59 -0700 (PDT)
From: Davide Libenzi <davidel@xmailserver.org>
X-X-Sender: davide@bigblue.dev.mcafeelabs.com
To: Mikael Pettersson <mikpe@csd.uu.se>
cc: Linus Torvalds <torvalds@transmeta.com>, kaos@ocs.com.au,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH][2.5.73] enable local APIC on P4
In-Reply-To: <200306232229.h5NMTaJU013801@harpo.it.uu.se>
Message-ID: <Pine.LNX.4.55.0306231545200.3730@bigblue.dev.mcafeelabs.com>
References: <200306232229.h5NMTaJU013801@harpo.it.uu.se>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 24 Jun 2003, Mikael Pettersson wrote:

> The current local APIC code refuses to enable the local APIC
> on a P4 if the BIOS booted us with the local APIC disabled.
> This patch removes this unnecessary restriction. Please apply.
>
> Most P4 machines do boot with the local APIC enabled, but
> Keith Owens reported that the P4 based Compaq Evo N800v
> disables the local APIC, even though the machine actually
> works if Linux enables it.
>
> It is possible that some P4 machines with broken BIOSen
> were saved by our refusal to enable the local APIC. We
> can handle them via the DMI blacklist rules instead.

I did the same thing on my Presario. BIOS disable it by default.



- Davide

