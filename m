Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132670AbRC2M6T>; Thu, 29 Mar 2001 07:58:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132673AbRC2M6K>; Thu, 29 Mar 2001 07:58:10 -0500
Received: from mailhost.tue.nl ([131.155.2.5]:46402 "EHLO mailhost.tue.nl")
	by vger.kernel.org with ESMTP id <S132670AbRC2M5y>;
	Thu, 29 Mar 2001 07:57:54 -0500
Message-ID: <20010329145712.A8739@win.tue.nl>
Date: Thu, 29 Mar 2001 14:57:12 +0200
From: Guest section DW <dwguest@win.tue.nl>
To: Sean Hunter <sean-lk@dev.sportingbet.com>, linux-kernel@vger.kernel.org
Subject: Re: OOM killer???
In-Reply-To: <200103282138.f2SLcT824292@webber.adilger.int> <Pine.A32.3.95.1010329111147.63156A-100000@werner.exp-math.uni-essen.de> <20010329130154.A8701@win.tue.nl> <20010329130238.G10301@dev.sportingbet.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 0.93i
In-Reply-To: <20010329130238.G10301@dev.sportingbet.com>; from Sean Hunter on Thu, Mar 29, 2001 at 01:02:38PM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 29, 2001 at 01:02:38PM +0100, Sean Hunter wrote:

> The reason the aero engineers don't need to select a passanger to throw out
> when the plane is overloaded is simply that the plane operators do not allow
> the plane to become overloaded.

Yes. But today Linux willing overcommits. It would be better if
the default was not to.

> Furthermore, why do you suppose an aeroplane has more than one altimeter,
> artifical horizon and compass?  Do you think it's because they are unable to
> make one of each that is reliable?  Or do you think its because they are
> concerned about what happens if one fails _however unlikely that is_.

Unix V6 did not overcommit, and panicked if is was out of swap
because that was a cannot happen situation.
If you argue that we must design things so that there is no overcommit
and still have an OOM killer just in case, I have no objections at all.

