Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932637AbWJFVWM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932637AbWJFVWM (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 6 Oct 2006 17:22:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932636AbWJFVWM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 6 Oct 2006 17:22:12 -0400
Received: from thunk.org ([69.25.196.29]:45191 "EHLO thunker.thunk.org")
	by vger.kernel.org with ESMTP id S1422974AbWJFVWL (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 6 Oct 2006 17:22:11 -0400
Date: Fri, 6 Oct 2006 17:22:07 -0400
From: Theodore Tso <tytso@mit.edu>
To: Tim Bird <tim.bird@am.sony.com>, Darren Hart <dvhltc@us.ibm.com>,
       linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
       Ingo Molnar <mingo@elte.hu>, "Theodore Ts'o" <theotso@us.ibm.com>
Subject: Re: Realtime Wiki - http://rt.wiki.kernel.org
Message-ID: <20061006212201.GF21816@thunk.org>
Mail-Followup-To: Theodore Tso <tytso@mit.edu>,
	Tim Bird <tim.bird@am.sony.com>, Darren Hart <dvhltc@us.ibm.com>,
	linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@elte.hu>, Theodore Ts'o <theotso@us.ibm.com>
References: <200610051404.08540.dvhltc@us.ibm.com> <452696C8.9000009@am.sony.com> <20061006181503.GE21816@thunk.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20061006181503.GE21816@thunk.org>
User-Agent: Mutt/1.5.11
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: tytso@thunk.org
X-SA-Exim-Scanned: No (on thunker.thunk.org); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In case people try it, and get confused, at the moment you can go to:

	http://any-key-word.wiki.kernel.org

... and you will be pointed at a wiki.  At the moment, the only wiki
that exists is the rt wiki and the default wiki (Demeter of
kernel.org).  So if you enter http://embedded.wiki.kernel.org, you
will currently go to the default wiki, which is a little confusing
because there currently isn't any text explaining that this is what is
going on.  And, the default wiki isn't set up to allow anyone to login
or to modify its pages --- for the obvious reason that we didn't want
it to become filled with link spam.

The host demeter.kernel.org is set up to support multiple wiki's,
based on the hostname in the *.wiki.kernel.org domain, but you have to
talk to the administrators of the *.wiki.kernel.org to actually enable
a new specific wiki.  This isn't hard for them, as it's just creating
a new database and adding a few lines in a PHP file, but it does
require some minor amounts of administrative work.

I suspect the main issue is for anyone contemplating setting up a new
wiki at *.wiki.kernel.org is that you'll need to find at least 2 or 3
Wiki editors who have the time to set up the wiki and keep it
administered and groomed.  Don't underestimate the amount of work
needed to keep a wiki to be healthy and up to date; it requires active
maintenance.

Darren Hart and I have been doing this for the -rt wiki (and many
thanks to Darren, as he's done a huge amount of Yeoman's work in
getting content up on the site, organizing it, and tweaking the
formatting, as well as to Melissa McKenney for providing the logo
artwork for the site), and we can tell you that it's not a trivial
amount of work.  (Although, it can be a great way to relieve stress
between programming sessions and budget meetings.  :-)

Regards,

						- Ted
