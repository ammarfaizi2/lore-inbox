Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S271630AbRH0AIq>; Sun, 26 Aug 2001 20:08:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S271631AbRH0AIg>; Sun, 26 Aug 2001 20:08:36 -0400
Received: from garrincha.netbank.com.br ([200.203.199.88]:58889 "HELO
	netbank.com.br") by vger.kernel.org with SMTP id <S271630AbRH0AIZ>;
	Sun, 26 Aug 2001 20:08:25 -0400
Date: Sun, 26 Aug 2001 21:07:45 -0300 (BRST)
From: Rik van Riel <riel@conectiva.com.br>
X-X-Sender: <riel@imladris.rielhome.conectiva>
To: Daniel Phillips <phillips@bonn-fries.net>
Cc: Russell King <rmk@arm.linux.org.uk>, <pcg@goof.com>,
        Roger Larsson <roger.larsson@skelleftea.mail.telia.com>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [resent PATCH] Re: very slow parallel read performance
In-Reply-To: <20010826231743Z16325-32383+1526@humbolt.nl.linux.org>
Message-ID: <Pine.LNX.4.33L.0108262107090.5646-100000@imladris.rielhome.conectiva>
X-spambait: aardvark@kernelnewbies.org
X-spammeplease: aardvark@nl.linux.org
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 27 Aug 2001, Daniel Phillips wrote:

> This is a nice dump format.  One thing that would be very helpful is
> the page executable flag, another would be the writable flag.  The
> 4687 anonymous pages are the elephant under the rug, but we don't know
> how they break down between executable (evictable) and otherwise.

Anonymous pages and executable pages are mutually exclusive.

Executable pages are ALWAYS mapped from a file, and thus
never anonymous.

regards,

Rik
-- 
IA64: a worthy successor to i860.

http://www.surriel.com/		http://distro.conectiva.com/

Send all your spam to aardvark@nl.linux.org (spam digging piggy)

