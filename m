Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268061AbUIFOaH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268061AbUIFOaH (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 6 Sep 2004 10:30:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268063AbUIFOaH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 6 Sep 2004 10:30:07 -0400
Received: from main.gmane.org ([80.91.224.249]:14812 "EHLO main.gmane.org")
	by vger.kernel.org with ESMTP id S268061AbUIFO3t (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 6 Sep 2004 10:29:49 -0400
X-Injected-Via-Gmane: http://gmane.org/
To: linux-kernel@vger.kernel.org
From: Kalin KOZHUHAROV <kalin@thinrope.net>
Subject: Re: [Transmeta hardware] Update of the CMS under Linux ?
Date: Mon, 06 Sep 2004 23:29:43 +0900
Message-ID: <chhs8o$rtd$1@sea.gmane.org>
References: <1093165082.11189.20.camel@aphrodite.olympus.net>	 <ch8lop$m3t$1@sea.gmane.org> <1094457952.22441.34.camel@rade7.e.cs.auc.dk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: j110113.ppp.asahi-net.or.jp
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7) Gecko/20040627
X-Accept-Language: bg, en, ja, ru, de
In-Reply-To: <1094457952.22441.34.camel@rade7.e.cs.auc.dk>
X-Enigmail-Version: 0.84.1.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Emmanuel Fleury wrote:
> Hi,
> 
> Actually, I have an answer to my question by now.
> 
> The way the CMS is built-in on the hardware allow one way to upgrade the
> firmware (and only one, as far as I understood in
> http://www.realworldtech.com/page.cfm?ArticleID=RWT010204000000 and
> http://www.realworldtech.com/page.cfm?ArticleID=RWT012704012616).
Wow, these tow articles are eye-openers :-)

I couldn't even remotley think of debugging my CPU :-D

> Each upgrade has to be signed with a certain private key (this private
> key is known by the seller of the laptop (Toshiba in your case) and by
> Transmeta itself... well I assume that in fact each entity has a partial
> knowledge of the private key which makes impossible to one of these to
> do something without the agreement of the other one).
> 
> So, the process for upgrading the CMS firmware is the following:
> 
> 1) Load the upgrade in memory,
> 2) Check the signature of the upgrade with the public key stored in the
>    ROM.
> 3) If the signature match with the upgrade, then apply the upgrade.
> 
> As you see, an upgrade (for Linux or Windows, whatever) requires the
> agreement of both Transmeta AND the laptop seller. And you cannot easily
> hack your way through.
> 
> I see only two solutions to do our own upgrade of the CMS:
> 
> 1) Take the EPROM out and write our own public key on it...
>    (risky and need a lot of hardware. I wouldn't recommand this way)
> 
> 2) Crack the public/private keys of the hardware.
>    (this is a known plaintext attack for the HP tablet-PC, and for the
>     other hardwares we can only have access to the public-key which is
>     making it more difficult but nothing that can resist to a brute
>     force attack in the case we have enough Seti-like softwares
>     running).
Hmm, uniting a few hundred Crusoe users can easily be done, but...

> I have no idea if it is legal or not... it is not my concern now. 
... how legal is it?

> I'm just seeking for solutions ! :)
> I guess it depends if you are in the States or in Europe.
or Japan.

> So, I am about here in my investigations and I still have this annoying
> bug with the Xserver... Moreover, it seems that Transmeta is fully on
> the Efficeon now and does not want to invest time and money on looking
> for a bug in the Crusoe CMS (except if one of its customer is
> specifically asking for it, which is very unlikely from Sony and/or
> Fujitsu).
> 
> I am gathering some informations on a bug in the CMS here:
> http://www.cs.auc.dk/~fleury/bug_cms/index.html
> 
> But, it looks like we are f**ked. :)
> 
> That's pretty annoying as these Transmeta laptops are an extremely cool
> piece of hardware !!! :-/
> 
> Anyway, I won't give up so easily (for once that we have a nice bug to
> fight with) !!! :)

I don't have X on this laptop, but I'll put tonight.

Actually, I was given this laptop after a few major falls (and a hard kick!),
so it is barely mobile, strapped/fixed to a metal board and used mainly via ssh.

I had some nasty bug appearing every couple of days without any trace left with linux-2.6.3
(machine stays on, but no reaction to KBD, network, USB, etc; nothing in the logs, on hte screen, no beeps).
But now with 2.6.8.1 I have 15d uptime :-)

If you get closer to a smaller (than X running) testcase, post it here, so other people (and me) can try easily.

I'd be happy to swich a few (fast) CPUs from SETI@Home to Transmeta@Home if not illegal :-)

Kalin.


-- 
 || ~~~~~~~~~~~~~~~~~~~~~~ ||
(  ) http://ThinRope.net/ (  )
 || ______________________ ||

