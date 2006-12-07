Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1031993AbWLGKaZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1031993AbWLGKaZ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 7 Dec 2006 05:30:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1031995AbWLGKaZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 7 Dec 2006 05:30:25 -0500
Received: from mx2.suse.de ([195.135.220.15]:44152 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1031993AbWLGKaY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 7 Dec 2006 05:30:24 -0500
From: Andreas Schwab <schwab@suse.de>
To: Jan Blunck <jblunck@suse.de>
Cc: Phil Endecott <phil_arcwk_endecott@chezphil.org>,
       linux-kernel@vger.kernel.org
Subject: Re: Subtleties of __attribute__((packed))
References: <4de7f8a60612060704k7d7c1ea3o1d43bee6c5e372d4@mail.gmail.com>
	<1165418558832@dmwebmail.belize.chezphil.org>
	<20061206155439.GA6727@hasse.suse.de>
	<20061206175423.GA9959@flint.arm.linux.org.uk>
	<20061207094833.GD4942@hasse.suse.de>
X-Yow: FEELINGS are cascading over me!!!
Date: Thu, 07 Dec 2006 11:30:19 +0100
In-Reply-To: <20061207094833.GD4942@hasse.suse.de> (Jan Blunck's message of
	"Thu, 7 Dec 2006 10:48:33 +0100")
Message-ID: <jeirgoathg.fsf@sykes.suse.de>
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/22.0.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jan Blunck <jblunck@suse.de> writes:

> Once again: I refered to "packed attribute on the struct vs. packed attribute
> on each member of the struct". The alignment shouldn't be different.

You are mistaken.  The alignment of a non-packed structure can be greater
than the maximum alignment of the containing members.

Andreas.

-- 
Andreas Schwab, SuSE Labs, schwab@suse.de
SuSE Linux Products GmbH, Maxfeldstraße 5, 90409 Nürnberg, Germany
PGP key fingerprint = 58CA 54C7 6D53 942B 1756  01D3 44D5 214B 8276 4ED5
"And now for something completely different."
