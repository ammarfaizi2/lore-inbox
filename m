Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S136490AbRAHB5U>; Sun, 7 Jan 2001 20:57:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S136465AbRAHB5A>; Sun, 7 Jan 2001 20:57:00 -0500
Received: from alcove.wittsend.com ([130.205.0.20]:6406 "EHLO
	alcove.wittsend.com") by vger.kernel.org with ESMTP
	id <S136419AbRAHB4w>; Sun, 7 Jan 2001 20:56:52 -0500
Date: Sun, 7 Jan 2001 20:56:32 -0500
From: "Michael H. Warfield" <mhw@wittsend.com>
To: Matt Beland <matt@pluto.rearviewmirror.org>
Cc: "Michael H. Warfield" <mhw@wittsend.com>,
        Gregory Maxwell <greg@linuxpower.cx>,
        "Pedro M. Rodrigues" <pmanuel@myrealbox.com>,
        "John O'Donnell" <johnod@voicefx.com>, linux-kernel@vger.kernel.org
Subject: Re: [OT] Re: .br blacklisted ?
Message-ID: <20010107205632.E11964@alcove.wittsend.com>
Mail-Followup-To: Matt Beland <matt@pluto.rearviewmirror.org>,
	"Michael H. Warfield" <mhw@wittsend.com>,
	Gregory Maxwell <greg@linuxpower.cx>,
	"Pedro M. Rodrigues" <pmanuel@myrealbox.com>,
	John O'Donnell <johnod@voicefx.com>, linux-kernel@vger.kernel.org
In-Reply-To: <3A58F35C.6070905@voicefx.com> <20010107192745.B26540@xi.linuxpower.cx> <20010107202228.A21268@alcove.wittsend.com> <01010718311100.03478@thoth.rearviewmirror.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.2i
In-Reply-To: <01010718311100.03478@thoth.rearviewmirror.org>; from matt@pluto.rearviewmirror.org on Sun, Jan 07, 2001 at 06:31:11PM -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jan 07, 2001 at 06:31:11PM -0700, Matt Beland wrote:

> Thereby killing how many hundreds of innocent people? China doesn't much 
> believe in fining minor offenders, remember. 

> You don't like Spam? Join the club. Blacklisting any domain - ANY domain - 
> for spamming, unless you can absolutely prove that no legitimate email has 
> ever been sent from that server, is completely unacceptable. You complain 
> about the wasted time and bandwidth caused by Spam messages - how much time 
> do you waste every year blocking legitimate messages?

	Not nearly as much time wasted as the time and bandwidth that
gets wasted for doing nothing.  The problem is bad enough.  Letting
them run wild will make the cesspool stink even worse.

	The sites that get blocked are misconfigured and need to be
fixed.  They're just getting a little more incentive.  Most of the spam
I reject gets rejected before the data transfered (blackhole tagged).
That preserves my resources.  Spot checking indicates that I'm loosing
very little legitimate mail.  Example...  By using DULS RBL, I block the
majority of directed mail from dialup sites.  Spot checking reveals that
my kill ratio is better than 100:1 on that (100 spam to less than 1 legit).
Only site I have ever needed to code an exception for was Bruce Peren's
Map site when he had to move it to a personal connection.  (BTW...  I
spot check by running some sites configured to drop rejected mail in spam
cans and occasionally do this on my main server.  I also check logs for
legit traffic being rejected.)

	Anyone who hits one of my teergrubes has absolutely no legitimate
business what so ever!  There is not a single legitimate address on those
tarpits.  Oh!  The poor sucky spammer got stuck talking to a few thousand
addresses on a machine that takes three minutes to tell him "OK".  Sorry,
no tears...  They get exactly what they deserve.  They got the addresses
by violating the robots.txt rules and harvesting poisoned pages.  That's
the only way they will find those addresses.  Tough.

	BTW...  I'm seeing several spam address harvestors chewing on my
sugarplums every week.  It's getting close to seeing more spam address
harvestors than seeing legitimate search engines through my web sites.

	Mind you...  What I do is actually pretty minor.  The potential
for real damage really exists.  Several anti-spam sites jokingly suggest
that rejection codes should be "4xx" codes instead of "5xx" codes.  Think
about that for a second...  They haven't transferred any data to you but
you tell them to hold that data and try back later (4xx codes signify
temporary errors that may be retried).  So that data sits on their
system until their final retries time out several days (5 days typical)
later.  Now...  Take that and take advantage of the old "percent hack"
that thousands of servers around the net still support (and are vulnerable
open relays in and of their own right).  Send a message to each of those
servers pecent hacking a huge message at the chump you want to target
with a final address of a system that blocks him with a 4xx code.  With
little effort you can totally shut down his mail spool and backup mail
onto the percent hackable servers.  Even if he manually cleans his spool,
he's got another shit load or two waiting for him.

	Sites which permit open relaying are vulnerable to the 4xx code
attacks.  They have an open death trap DoS security vulnerability on them.
The fact that we don't take advantage of it, means we're the nice guys.
We only give them 5xx codes and tell them to go away...

	I have the right to decide, based on what ever criterion I chose,
to accept or reject E-Mail.  For the sites that I administer for a large
E-Mail base, that needs to be in accordance with the established policies.
In most cases, I have a hard time coming up with rules strict enough
to adhere to those policies while still keeping the mail flowing.  The
owners of those sites have a right to dictate those policies.  Not
the senders.

> Matt

	Mike
-- 
 Michael H. Warfield    |  (770) 985-6132   |  mhw@WittsEnd.com
  (The Mad Wizard)      |  (678) 463-0932   |  http://www.wittsend.com/mhw/
  NIC whois:  MHW9      |  An optimist believes we live in the best of all
 PGP Key: 0xDF1DD471    |  possible worlds.  A pessimist is sure of it!

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
