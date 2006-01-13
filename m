Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422991AbWAMVhs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422991AbWAMVhs (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 13 Jan 2006 16:37:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422989AbWAMVhs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 13 Jan 2006 16:37:48 -0500
Received: from ra.tuxdriver.com ([24.172.12.4]:12560 "EHLO ra.tuxdriver.com")
	by vger.kernel.org with ESMTP id S1422988AbWAMVhr (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 13 Jan 2006 16:37:47 -0500
Date: Fri, 13 Jan 2006 16:26:08 -0500
From: "John W. Linville" <linville@tuxdriver.com>
To: netdev@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, Jiri Benc <jbenc@suse.cz>,
       Stefan Rompf <stefan@loplof.de>,
       Mike Kershaw <dragorn@kismetwireless.net>,
       Krzysztof Halasa <khc@pm.waw.pl>, Robert Hancock <hancockr@shaw.ca>,
       Alistair John Strachan <s0348365@sms.ed.ac.uk>,
       Dominik Brodowski <linux@dominikbrodowski.net>,
       Denis Vlasenko <vda@ilport.com.ua>,
       Danny van Dyk <kugelfang@gentoo.org>,
       Stephen Hemminger <shemminger@osdl.org>, feyd <feyd@nmskb.cz>,
       Chase Venters <chase.venters@clientec.com>,
       Andreas Mohr <andim2@users.sourceforge.net>,
       Bas Vermeulen <bvermeul@blackstar.nl>, Jean Tourrilhes <jt@hpl.hp.com>,
       Daniel Drake <dsd@gentoo.org>, Ulrich Kunitz <kune@deine-taler.de>,
       Phil Dibowitz <phil@ipom.com>, Simon Kelley <simon@thekelleys.org.uk>,
       Michael Buesch <mbuesch@freenet.de>,
       Marcel Holtmann <marcel@holtmann.org>,
       Patrick McHardy <kaber@trash.net>, Ingo Oeser <netdev@axxeo.de>,
       Harald Welte <laforge@gnumonks.org>,
       Ben Greear <greearb@candelatech.com>, Thomas Graf <tgraf@suug.ch>
Subject: wireless: recap of current issues (intro)
Message-ID: <20060113212605.GD16166@tuxdriver.com>
Mail-Followup-To: netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	Jiri Benc <jbenc@suse.cz>, Stefan Rompf <stefan@loplof.de>,
	Mike Kershaw <dragorn@kismetwireless.net>,
	Krzysztof Halasa <khc@pm.waw.pl>, Robert Hancock <hancockr@shaw.ca>,
	Alistair John Strachan <s0348365@sms.ed.ac.uk>,
	Dominik Brodowski <linux@dominikbrodowski.net>,
	Denis Vlasenko <vda@ilport.com.ua>,
	Danny van Dyk <kugelfang@gentoo.org>,
	Stephen Hemminger <shemminger@osdl.org>, feyd <feyd@nmskb.cz>,
	Chase Venters <chase.venters@clientec.com>,
	Andreas Mohr <andim2@users.sourceforge.net>,
	Bas Vermeulen <bvermeul@blackstar.nl>,
	Jean Tourrilhes <jt@hpl.hp.com>, Daniel Drake <dsd@gentoo.org>,
	Ulrich Kunitz <kune@deine-taler.de>, Phil Dibowitz <phil@ipom.com>,
	Simon Kelley <simon@thekelleys.org.uk>,
	Michael Buesch <mbuesch@freenet.de>,
	Marcel Holtmann <marcel@holtmann.org>,
	Patrick McHardy <kaber@trash.net>, Ingo Oeser <netdev@axxeo.de>,
	Harald Welte <laforge@gnumonks.org>,
	Ben Greear <greearb@candelatech.com>, Thomas Graf <tgraf@suug.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060113195723.GB16166@tuxdriver.com>
User-Agent: Mutt/1.4.1i
X-Original-Status: RO
X-Original-Status: RO
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

My original post got eaten by the lists -- probably too big...

I'm reposting in sections.  After this intro follow sections on
Configuration, Compatibility, Stack, Other Issues, and Actions.
Enjoy! :-)

---

WiFi-ers...

Here I am, still feeling "up to the challenge"...  I have stopped
hyper-ventilating and the nervous vomiting is all over... :-)

Having accepted the wireless role, I wanted to review the discussions
prompted by Jeff's "State of the Union" message from a little over a
week ago.  There is lots of good talent involved in these discussions,
and I believe a surprisingly high level of agreement (some of it
nearly violent!) amongst the players.

Below I have recapped what I saw as most of the important issues.
I have endorsed some of the ideas, mostly those which seem to have
broad agreement.  I have also thrown-out a few ideas of my own.
Please do comment on all of them, as neither my summaries nor my
original ideas are likely to be without fault. :-)

I have primarily grouped the issues into configuration, compatibility,
and stack concerns.  I also included an "other" group for a few other
concerns that I though were worth mentioning.

Finally, I have included an "actions" section to reveal some of my
near-term plans and some of what I am thinking about beyond that.
I would love to hear any comments you might have on these items
as well.

Thanks for taking the time to look this over.  Creating this recap
has reinforced one thing: this is far too big for just a single person
(or even a small group) to tackle alone!

Thanks,

John
-- 
John W. Linville
linville@tuxdriver.com
