Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S280547AbRKXXmB>; Sat, 24 Nov 2001 18:42:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S280537AbRKXXlu>; Sat, 24 Nov 2001 18:41:50 -0500
Received: from vega.ipal.net ([206.97.148.120]:43190 "HELO vega.ipal.net")
	by vger.kernel.org with SMTP id <S280531AbRKXXlf>;
	Sat, 24 Nov 2001 18:41:35 -0500
Date: Sat, 24 Nov 2001 17:41:34 -0600
From: Phil Howard <phil-linux-kernel@ipal.net>
To: linux-kernel@vger.kernel.org
Subject: Re: Journaling pointless with today's hard disks?
Message-ID: <20011124174134.B4372@vega.ipal.net>
In-Reply-To: <Pine.LNX.4.33L.0111241729110.4079-100000@imladris.surriel.com> <Pine.LNX.4.20.0111241451010.30843-100000@otter.mbay.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.20.0111241451010.30843-100000@otter.mbay.net>
User-Agent: Mutt/1.3.23i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Nov 24, 2001 at 02:51:38PM -0800, John Alvord wrote:

| On Sat, 24 Nov 2001, Rik van Riel wrote:
| 
| > On 24 Nov 2001, Florian Weimer wrote:
| > 
| > > They do, even IBM admits that (on
| > >
| > >         http://www.cooling-solutions.de/dtla-faq
| > >
| > > you find a quote from IBM confirming this).  IBM says it's okay,
| > 
| > That quote is priceless. I know I'll be avoiding IBM
| > disks from now on ;)
| 
| It could be true for many disks and only IBM has admitted it...

Only the IBM drives are having the high return rates.  And IBM seems
to be blaming this on powering off during writes.  But why would the
other brands not be having this situation?  Is it because they don't
get powered off?

It could be that other drives have the capability to detect and write
over sectors made bad by power off.  Or maybe they lock out the sector
and map to a spare.  They might even have enough spin left to finish
the sector correctly in more cases.

So I doubt the issue is present in other drives, unless the issue is
not really as big of one as we might think and the problems with IBM
drives are something else.

I do worry that the lighter the platters are, the faster they try to
make the drives spin with smaller motors, and the quicker they slow
down when power is lost.

-- 
-----------------------------------------------------------------
| Phil Howard - KA9WGN |   Dallas   | http://linuxhomepage.com/ |
| phil-nospam@ipal.net | Texas, USA | http://phil.ipal.org/     |
-----------------------------------------------------------------
