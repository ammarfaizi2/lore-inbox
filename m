Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932097AbVLZS4x@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932097AbVLZS4x (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 26 Dec 2005 13:56:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932100AbVLZS4x
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 26 Dec 2005 13:56:53 -0500
Received: from thunk.org ([69.25.196.29]:34789 "EHLO thunker.thunk.org")
	by vger.kernel.org with ESMTP id S932097AbVLZS4w (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 26 Dec 2005 13:56:52 -0500
Date: Mon, 26 Dec 2005 13:56:46 -0500
From: "Theodore Ts'o" <tytso@mit.edu>
To: Con Kolivas <kernel@kolivas.org>,
       linux kernel mailing list <linux-kernel@vger.kernel.org>,
       Dominik Brodowski <linux@dominikbrodowski.net>,
       Daniel Petrini <d.pensator@gmail.com>, Tony Lindgren <tony@atomide.com>,
       vatsa@in.ibm.com, ck list <ck@vds.kolivas.org>,
       Pavel Machek <pavel@ucw.cz>, Adam Belay <abelay@novell.com>,
       Zwane Mwaikambo <zwane@arm.linux.org.uk>
Subject: Re: [PATCH] i386 No Idle HZ aka dynticks 051221
Message-ID: <20051226185645.GA7045@thunk.org>
Mail-Followup-To: Theodore Ts'o <tytso@mit.edu>,
	Con Kolivas <kernel@kolivas.org>,
	linux kernel mailing list <linux-kernel@vger.kernel.org>,
	Dominik Brodowski <linux@dominikbrodowski.net>,
	Daniel Petrini <d.pensator@gmail.com>,
	Tony Lindgren <tony@atomide.com>, vatsa@in.ibm.com,
	ck list <ck@vds.kolivas.org>, Pavel Machek <pavel@ucw.cz>,
	Adam Belay <abelay@novell.com>,
	Zwane Mwaikambo <zwane@arm.linux.org.uk>
References: <200512210310.51084.kernel@kolivas.org> <20051225171617.GA6929@thunk.org> <20051226025525.GA6697@thunk.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20051226025525.GA6697@thunk.org>
User-Agent: Mutt/1.5.11
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: tytso@thunk.org
X-SA-Exim-Scanned: No (on thunker.thunk.org); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Dec 25, 2005 at 09:55:26PM -0500, Theodore Ts'o wrote:
> With dyntick enabled, the laptop never enters the C4 state, but
> instead bounces back and forth between C2 and C3 (and I notice that we
> never enter C1 state, even when the CPU is completely pegged, but
> that's true with or without dyntick).  
> 
> If dyntick is enabled, the laptop enters C4 state, which presumably is
                ^^^^^^^ this should be "disabled"
> a deeper, more power saving state, and it appears power saving effects
> of dyntick is getting balanced off against the fact that C4 is never
> getting entered when it is enabled.

My apologies for any confusion, and for not doing better copy-editing
before hitting the send butter.

						 -Ted

