Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750734AbWE2MZi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750734AbWE2MZi (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 29 May 2006 08:25:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750735AbWE2MZi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 29 May 2006 08:25:38 -0400
Received: from boogie.lpds.sztaki.hu ([193.225.12.226]:44771 "EHLO
	boogie.lpds.sztaki.hu") by vger.kernel.org with ESMTP
	id S1750734AbWE2MZh convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 29 May 2006 08:25:37 -0400
Date: Mon, 29 May 2006 14:25:36 +0200
From: Gabor Gombas <gombasg@sztaki.hu>
To: Christian Trefzer <ctrefzer@gmx.de>
Cc: Jan Engelhardt <jengelh@linux01.gwdg.de>,
       Lennart Sorensen <lsorense@csclub.uwaterloo.ca>,
       Alistair John Strachan <s0348365@sms.ed.ac.uk>,
       Linus Torvalds <torvalds@osdl.org>, Kyle McMartin <kyle@mcmartin.ca>,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Add compile domain (was: Re: [PATCH] Well, Linus seems to like Lordi...)
Message-ID: <20060529122536.GE22245@boogie.lpds.sztaki.hu>
References: <20060525141714.GA31604@skunkworks.cabal.ca> <Pine.LNX.4.61.0605252027380.13379@yvahk01.tjqt.qr> <Pine.LNX.4.64.0605251146260.5623@g5.osdl.org> <200605251954.06227.s0348365@sms.ed.ac.uk> <20060525202917.GB21926@csclub.uwaterloo.ca> <Pine.LNX.4.61.0605261354220.899@yvahk01.tjqt.qr> <20060526211140.GC16059@hermes.uziel.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: 8BIT
In-Reply-To: <20060526211140.GC16059@hermes.uziel.local>
X-Copyright: Forwarding or publishing without permission is prohibited.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 26, 2006 at 11:11:40PM +0200, Christian Trefzer wrote:

> Well I always thought that 127.0.0.1 is localhost, and _only_ localhost,
> and the host's real name would rather be mapped to its IP on the real
> NIC.  Every interface (including local loopback) has a distinct IP;

Several mistakes: there is no "the real NIC". There may be multiple NICs
(actually quite common nowadays on desktop motherboards, and on laptops
with both wired and wireless interfaces). And one NIC may have several
IP addresses, not just one.

> hostnames are supposed to be resolved to one of these and need to be
> somewhat unique on subnets, unless a fqdn is supplied.

No. Hostname does not have to resolve to _anything_. The hostname is
just a string that identifies the machine for _humans_. It is nothing
more, nothing less. It follows that a hostname should be just as unique
as it's human users are concerned, it has no relation to subnets or
FQDN or any other network term.

> Major catch: it presumes you have at least one NIC actually in use.

You can always configure a dummy interface.

Gabor

-- 
     ---------------------------------------------------------
     MTA SZTAKI Computer and Automation Research Institute
                Hungarian Academy of Sciences
     ---------------------------------------------------------
