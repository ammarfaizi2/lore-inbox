Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132681AbRC2MAe>; Thu, 29 Mar 2001 07:00:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132721AbRC2MAZ>; Thu, 29 Mar 2001 07:00:25 -0500
Received: from sportingbet.gw.dircon.net ([195.157.147.30]:41992 "HELO
	sysadmin.sportingbet.com") by vger.kernel.org with SMTP
	id <S132681AbRC2MAL>; Thu, 29 Mar 2001 07:00:11 -0500
Date: Thu, 29 Mar 2001 13:02:38 +0100
From: Sean Hunter <sean-lk@dev.sportingbet.com>
To: Guest section DW <dwguest@win.tue.nl>
Cc: linux-kernel@vger.kernel.org
Subject: Re: OOM killer???
Message-ID: <20010329130238.G10301@dev.sportingbet.com>
Mail-Followup-To: Sean Hunter <sean-lk@dev.sportingbet.com>,
	Guest section DW <dwguest@win.tue.nl>, linux-kernel@vger.kernel.org
In-Reply-To: <200103282138.f2SLcT824292@webber.adilger.int> <Pine.A32.3.95.1010329111147.63156A-100000@werner.exp-math.uni-essen.de> <20010329130154.A8701@win.tue.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment
User-Agent: Mutt/1.2.5i
In-Reply-To: <20010329130154.A8701@win.tue.nl>; from dwguest@win.tue.nl on Thu, Mar 29, 2001 at 01:01:54PM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 29, 2001 at 01:01:54PM +0200, Guest section DW wrote:
> [Never use planes where the company's engineers spend their
> time designing algorithms for selecting which passenger
> must be thrown out when the plane is overloaded.]

This is (as far as I can see) a fantastically specious argument.  A plane is
designed to function in an entirely constrained mode of operation and in an
entirely well-understood and circumscribed problem space, whereas a linux host
is a general-purpose device which can be used for many different applications.

The reason the aero engineers don't need to select a passanger to throw out
when the plane is overloaded is simply that the plane operators do not allow
the plane to become overloaded.  If I put a 100 people in a trilander it may
take off, but won't fly, and will probably crash.  The plane's designers don't
have to do anything about that- we do.

Furthermore, why do you suppose an aeroplane has more than one altimeter,
artifical horizon and compass?  Do you think it's because they are unable to
make one of each that is reliable?  Or do you think its because they are
concerned about what happens if one fails _however unlikely that is_.

In fact, aeroplane engineers do design in ways of mitigating the effects of all
kinds of failures, including lessening the impact of a crash (directly
analogous to our OOM killer).  For example, they provide means of jettisonning
fuel prior to crash landing to attempt to minimise explosions.

Risk management is about lessening impact as well as lessening probability.  If
something is important, you don't only make it work as well as you can, you
mitigate the effect of failure.  A reliable system is not just a strong belt,
it is belt, braces, suspenders and bicycle clips.

I have seen the OOM killer in operation three times on our production servers.
In each case it kept the machine alive in the face of hostile runaway
processes.  I don't want to see things killed, but if that is the only way to
keep the host alive, I vote to keep it alive.

When I'm on a plane, I want more than one engine _and_ lifejackets.

Sean
