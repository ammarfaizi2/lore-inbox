Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S271625AbRHZXYi>; Sun, 26 Aug 2001 19:24:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S271623AbRHZXYS>; Sun, 26 Aug 2001 19:24:18 -0400
Received: from smtp.mailbox.net.uk ([195.82.125.32]:27369 "EHLO
	smtp.mailbox.net.uk") by vger.kernel.org with ESMTP
	id <S271619AbRHZXYM>; Sun, 26 Aug 2001 19:24:12 -0400
Date: Mon, 27 Aug 2001 00:24:27 +0100
From: Russell King <rmk@arm.linux.org.uk>
To: Daniel Phillips <phillips@bonn-fries.net>
Cc: Rik van Riel <riel@conectiva.com.br>, pcg@goof.com,
        Roger Larsson <roger.larsson@skelleftea.mail.telia.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [resent PATCH] Re: very slow parallel read performance
Message-ID: <20010827002427.B6193@flint.arm.linux.org.uk>
In-Reply-To: <Pine.LNX.4.33L.0108261651080.5646-100000@imladris.rielhome.conectiva> <20010826200133Z16190-32385+242@humbolt.nl.linux.org> <20010826233343.A6193@flint.arm.linux.org.uk> <20010826231743Z16325-32383+1526@humbolt.nl.linux.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20010826231743Z16325-32383+1526@humbolt.nl.linux.org>; from phillips@bonn-fries.net on Mon, Aug 27, 2001 at 01:24:23AM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 27, 2001 at 01:24:23AM +0200, Daniel Phillips wrote:
> This is a nice dump format.  One thing that would be very helpful is the page 
> executable flag, another would be the writable flag.  The 4687 anonymous 
> pages are the elephant under the rug, but we don't know how they break down 
> between executable (evictable) and otherwise.

You can't get at that information without doing a complete scan for each
page table in all tasks, unless you want to dump out the page tables.
This could done separately of course.

--
Russell King (rmk@arm.linux.org.uk)                The developer of ARM Linux
             http://www.arm.linux.org.uk/personal/aboutme.html

