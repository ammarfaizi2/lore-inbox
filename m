Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265385AbUAXQYk (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 24 Jan 2004 11:24:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266957AbUAXQYk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 24 Jan 2004 11:24:40 -0500
Received: from ns.suse.de ([195.135.220.2]:62416 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id S265385AbUAXQYj (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 24 Jan 2004 11:24:39 -0500
To: "Dr. David Alan Gilbert" <gilbertd@treblig.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: RFC: Representation of large hex values
References: <20040124151156.GB1029@gallifrey>
From: Andreas Schwab <schwab@suse.de>
X-Yow: Now I'm being INVOLUNTARILY shuffled closer to the CLAM DIP
 with the BROKEN PLASTIC FORKS in it!!
Date: Sat, 24 Jan 2004 17:24:38 +0100
In-Reply-To: <20040124151156.GB1029@gallifrey> (David Alan Gilbert's message
 of "Sat, 24 Jan 2004 15:11:56 +0000")
Message-ID: <jesmi5l3g9.fsf@sykes.suse.de>
User-Agent: Gnus/5.1006 (Gnus v5.10.6) Emacs/21.3.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Dr. David Alan Gilbert" <gilbertd@treblig.org> writes:

> For clarity, it would seem best to use a distinct format character;
> so perhaps prefix these numbers by 0y (read Oi!) and then you
> could use %y (and %Y if you REALLY want) in printf.

POSIX defines the ' flag to enable use of thousand separators for decimal
formats.  This could easily be extended to hex formats.

Andreas.

-- 
Andreas Schwab, SuSE Labs, schwab@suse.de
SuSE Linux AG, Maxfeldstraße 5, 90409 Nürnberg, Germany
Key fingerprint = 58CA 54C7 6D53 942B 1756  01D3 44D5 214B 8276 4ED5
"And now for something completely different."
