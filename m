Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S280873AbRKYNXw>; Sun, 25 Nov 2001 08:23:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S280878AbRKYNXm>; Sun, 25 Nov 2001 08:23:42 -0500
Received: from vega.ipal.net ([206.97.148.120]:1210 "HELO vega.ipal.net")
	by vger.kernel.org with SMTP id <S280873AbRKYNX3>;
	Sun, 25 Nov 2001 08:23:29 -0500
Date: Sun, 25 Nov 2001 07:23:26 -0600
From: Phil Howard <phil-linux-kernel@ipal.net>
To: linux-kernel@vger.kernel.org
Subject: Re: IDE: 2.2.19+IDE patches works fine; 2.4.x fails miserably; please help me figure out why!
Message-ID: <20011125072326.A26870@vega.ipal.net>
In-Reply-To: <200111250457.fAP4vIt03205@jik.kamens.brookline.ma.us>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200111250457.fAP4vIt03205@jik.kamens.brookline.ma.us>
User-Agent: Mutt/1.3.23i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Nov 24, 2001 at 11:57:18PM -0500, Jonathan Kamens wrote:

| I've seen people mention in comp.os.linux.development.system that the
| BadCRC error may indicate a cable problem.  However, (a) I'm pretty
| certain that I'm using Ultra66 cables for both hde and hdg, and (b) if
| that's the problem, why don't I get the same errors with 2.2.19?
| 
| As for (a), I believe I've got the right cables because I checked when
| I installed them and because the controller (Promise Ultra66)
| recognizes both hde and hdg as Ultra-capable drives when it starts up
| (which it wouldn't do if I didn't have the correct cables -- I know
| this because it wasn't doing it when I didn't have the correct cables
| ;-).

I've had drive problems simply as a result of bad _instances_ of cables,
even though it was the right kind of cable.  I've also had drive problems
as a result of looseness of connections.  Some connector _instances_
seem to be more prone to this, and some headers on some motherboards
also seem to be more prone to this.

<paranoid>
Pull the cable and clean all the connections on the cable, board, and
drive.  High pressure air is good enough in most cases, but liquid
cleaner might be needed in some.  Check the cable for dings, nicks,
and sharp bends.  These have more impact on ATA66 cables.  If it has
any, get a new cable and cut the old one in half.  If you have a
single ATA66 drive, be sure it is on the _end_ connector.  While you
can cut off the end of older IDE cables to make short ones, not so
with ATA66 cables.  Leave the middle connector dangling or get a cable
with just 2 connectors.  Also, don't "round" an ATA66 cable.
</paranoid>

And finally, I actually have a couple drives that exhibit these problems
no matter what I do.  The drives _can_ simply be bad.

-- 
-----------------------------------------------------------------
| Phil Howard - KA9WGN |   Dallas   | http://linuxhomepage.com/ |
| phil-nospam@ipal.net | Texas, USA | http://phil.ipal.org/     |
-----------------------------------------------------------------
