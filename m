Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964861AbVLEXZ7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964861AbVLEXZ7 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 5 Dec 2005 18:25:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964864AbVLEXZq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 5 Dec 2005 18:25:46 -0500
Received: from anf141.internetdsl.tpnet.pl ([83.17.87.141]:19376 "EHLO
	anf141.internetdsl.tpnet.pl") by vger.kernel.org with ESMTP
	id S964862AbVLEXZb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 5 Dec 2005 18:25:31 -0500
From: "Rafael J. Wysocki" <rjw@sisk.pl>
To: Pavel Machek <pavel@suse.cz>
Subject: Re: swsusp performance problems in 2.6.15-rc3-mm1
Date: Mon, 5 Dec 2005 23:44:00 +0100
User-Agent: KMail/1.9
Cc: Nigel Cunningham <ncunningham@cyclades.com>,
       Andy Isaacson <adi@hexapodia.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <20051205081935.GI22168@hexapodia.org> <1133791084.3872.53.camel@laptop.cunninghams> <20051205172938.GC25114@atrey.karlin.mff.cuni.cz>
In-Reply-To: <20051205172938.GC25114@atrey.karlin.mff.cuni.cz>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200512052344.01506.rjw@sisk.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Monday, 5 December 2005 18:29, Pavel Machek wrote:
> [BTW right function to modify is swsusp_shrink_memory, it is quite
> clear what it is doing, so finding formula that frees enough to make
> it fast but not so much to make it unresponsive should be easy.]

Agreed.

}-- snip --{
> Yes, it is not completely fair. But as I started to use X32 with good
> battery... well I'm not really using swsusp any more.

Unfortunately I can't make my box suspend to RAM ... :-(

> > > * compress the image. Needs to be done in userspace, so it needs
> > > uswsusp to be merged, first. Patches for that are available. Should
> > > speed it up about twice.

Frankly, I would think that compression could be done in the kernel.
Encryption is different, as it should depend on a user-provided key, but
compression does not seem to depend on anything "external", at first sight.

}-- snip --{
 
> If goal is "make it work with least effort", answer is of course
> suspend2; but I need someone to help me doing it right.

Well, in the Andy's case this may or may not help.  Actually I'd like him to try
and say what's the result, but only if he's so kind, has some free time
to was^H^H^Hdo this, etc. ;-)

Greetings,
Rafael


-- 
Beer is proof that God loves us and wants us to be happy - Benjamin Franklin

