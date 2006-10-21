Return-Path: <linux-kernel-owner+willy=40w.ods.org-S2993114AbWJUSRn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S2993114AbWJUSRn (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 21 Oct 2006 14:17:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1423378AbWJUSRn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 21 Oct 2006 14:17:43 -0400
Received: from mail.suse.de ([195.135.220.2]:60074 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S1423377AbWJUSRm (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 21 Oct 2006 14:17:42 -0400
From: Andreas Schwab <schwab@suse.de>
To: Andi Kleen <ak@suse.de>
Cc: Jeremy Fitzhardinge <jeremy@goop.org>, Andi Kleen <ak@muc.de>,
       Andrew Morton <akpm@osdl.org>, patches@x86-64.org,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] [11/19] i386: Fix fake return address
References: <20061021 651.356252000@suse.de>
	<20061021165131.4FDD813C4D@wotan.suse.de>
X-Yow: NOW do I get to blow out the CANDLES??
Date: Sat, 21 Oct 2006 20:17:40 +0200
In-Reply-To: <20061021165131.4FDD813C4D@wotan.suse.de> (Andi Kleen's message
	of "Sat, 21 Oct 2006 18:51:31 +0200 (CEST)")
Message-ID: <je7iytedob.fsf@sykes.suse.de>
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/22.0.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andi Kleen <ak@suse.de> writes:

> From: Jeremy Fitzhardinge <jeremy@goop.org>
> The fake return address was being set to __KERNEL_PDA, rather than 0.
> Push it earlier while %eax still equals 0.

There is a slight discrepancy between the description and what is really
implemented by the patch.

Andreas.

-- 
Andreas Schwab, SuSE Labs, schwab@suse.de
SuSE Linux Products GmbH, Maxfeldstraße 5, 90409 Nürnberg, Germany
PGP key fingerprint = 58CA 54C7 6D53 942B 1756  01D3 44D5 214B 8276 4ED5
"And now for something completely different."
