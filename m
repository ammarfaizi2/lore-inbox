Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261587AbTCOX2W>; Sat, 15 Mar 2003 18:28:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261606AbTCOX2W>; Sat, 15 Mar 2003 18:28:22 -0500
Received: from pasky.ji.cz ([62.44.12.54]:52732 "HELO machine.sinus.cz")
	by vger.kernel.org with SMTP id <S261587AbTCOX2V>;
	Sat, 15 Mar 2003 18:28:21 -0500
Date: Sun, 16 Mar 2003 00:39:10 +0100
From: Petr Baudis <pasky@ucw.cz>
To: Pavel Machek <pavel@ucw.cz>, Daniel Phillips <phillips@arcor.de>,
       "Martin J. Bligh" <mbligh@aracnet.com>,
       Zack Brown <zbrown@tumblerings.org>, linux-kernel@vger.kernel.org
Subject: Re: BitBucket: GPL-ed KitBeeper clone
Message-ID: <20030315233910.GA11761@pasky.ji.cz>
Mail-Followup-To: Pavel Machek <pavel@ucw.cz>,
	Daniel Phillips <phillips@arcor.de>,
	"Martin J. Bligh" <mbligh@aracnet.com>,
	Zack Brown <zbrown@tumblerings.org>, linux-kernel@vger.kernel.org
References: <200303020011.QAA13450@adam.yggdrasil.com> <20030311184043.GA24925@renegade> <22230000.1047408397@flay> <20030311192639.E72163C5BE@mx01.nexgo.de> <20030314122903.GC8057@zaurus.ucw.cz> <20030315213246.GD31875@pasky.ji.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030315213246.GD31875@pasky.ji.cz>
User-Agent: Mutt/1.4i
X-message-flag: Outlook : A program to spread viri, but it can do mail too.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dear diary, on Sat, Mar 15, 2003 at 10:32:46PM CET, I got a letter,
where Petr Baudis <pasky@ucw.cz> told me, that...
..snip..
> Changeset unique id should probably include author of that changeset and time
> (with seconds precision) of commiting such a changeset to the [original]
> repository [of the changeset]. However some insane scripts could make, checkin
> and commit several changesets in line fast enough or so, thus you want
> something else in the id as well, which could further differentiate commitins
> happenning at same time. Checksum of the changeset changes (in some suitable
> form) would do. Now, if you want to annoy Larry, separate the fields by '|'s
> and you could get something familiar.
..snip..

Okay, you will also need to define some project (let's define project as a
group of files with a history, where the instances of a project are called
"repositories" and are nodes of a DAG with common root, which we will call the
initial repository) unique id and include it in the changeset id. I think the
best for a project unique id would be some checksum (so that it isn't too
long..?) of the initial repository owner (project founder), project name (such
as 'linux' or 'foobar' or "this isn't going to be unique, who cares") and some
roughly random number (be it a timestamp, /dev/urandom output snippet or
metheorogical situation snapshot).

We could maybe raise the precision for timestamp of changeset ids instead of
having the checksum there, is it really neccessary? I fear of changeset id
being too annoyingly long and complicated. And yes I'm looking at BK heavily
regarding these concepts --- they seem to get these concepts fairly right so
why not.

Kind regards,

-- 
 
				Petr "Pasky" Baudis
.
The pure and simple truth is rarely pure and never simple.
		-- Oscar Wilde
.
Stuff: http://pasky.ji.cz/
