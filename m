Return-Path: <linux-kernel-owner+w=401wt.eu-S1762915AbWLKNho@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1762915AbWLKNho (ORCPT <rfc822;w@1wt.eu>);
	Mon, 11 Dec 2006 08:37:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1762919AbWLKNho
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 11 Dec 2006 08:37:44 -0500
Received: from mx1.suse.de ([195.135.220.2]:46448 "EHLO mx1.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1762915AbWLKNhn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 11 Dec 2006 08:37:43 -0500
From: Andreas Schwab <schwab@suse.de>
To: Jeff Garzik <jeff@garzik.org>
Cc: David Howells <dhowells@redhat.com>, Akinobu Mita <akinobu.mita@gmail.com>,
       torvalds@osdl.org, akpm@osdl.org, linux-kernel@vger.kernel.org,
       Al Viro <viro@zeniv.linux.org.uk>
Subject: Re: Mark bitrevX() functions as const
References: <29447.1165840536@redhat.com> <457D559C.2030702@garzik.org>
X-Yow: SANTA CLAUS comes down a FIRE ESCAPE wearing bright
 blue LEG WARMERS..  He scrubs the POPE with a mild
 soap or detergent for 15 minutes, starring JANE FONDA!!
Date: Mon, 11 Dec 2006 14:37:29 +0100
In-Reply-To: <457D559C.2030702@garzik.org> (Jeff Garzik's message of "Mon, 11
	Dec 2006 07:57:00 -0500")
Message-ID: <je3b7m5zae.fsf@sykes.suse.de>
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/22.0.91 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jeff Garzik <jeff@garzik.org> writes:

> * another annotation to consider is C99 keyword 'restrict'.

This is useless as long as we compile with -fno-strict-aliasing (and I
don't think this will ever change).

Andreas.

-- 
Andreas Schwab, SuSE Labs, schwab@suse.de
SuSE Linux Products GmbH, Maxfeldstraße 5, 90409 Nürnberg, Germany
PGP key fingerprint = 58CA 54C7 6D53 942B 1756  01D3 44D5 214B 8276 4ED5
"And now for something completely different."
