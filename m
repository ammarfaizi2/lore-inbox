Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750891AbWE2MIX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750891AbWE2MIX (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 29 May 2006 08:08:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750909AbWE2MIX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 29 May 2006 08:08:23 -0400
Received: from boogie.lpds.sztaki.hu ([193.225.12.226]:51173 "EHLO
	boogie.lpds.sztaki.hu") by vger.kernel.org with ESMTP
	id S1750857AbWE2MIX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 29 May 2006 08:08:23 -0400
Date: Mon, 29 May 2006 14:08:21 +0200
From: Gabor Gombas <gombasg@sztaki.hu>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Jan Engelhardt <jengelh@linux01.gwdg.de>, Kyle McMartin <kyle@mcmartin.ca>,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Add compile domain (was: Re: [PATCH] Well, Linus seems to like Lordi...)
Message-ID: <20060529120821.GD22245@boogie.lpds.sztaki.hu>
References: <20060525141714.GA31604@skunkworks.cabal.ca> <Pine.LNX.4.61.0605251829410.6951@yvahk01.tjqt.qr> <Pine.LNX.4.64.0605250943520.5623@g5.osdl.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0605250943520.5623@g5.osdl.org>
X-Copyright: Forwarding or publishing without permission is prohibited.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 25, 2006 at 09:48:34AM -0700, Linus Torvalds wrote:

> So just fix your hostname to give the full hostname. Nothing less makes 
> any sense anyway.

Which full hostname? I have access to a machine with 2 NICs having 5
IPv4 addresses total, and none of the associated DNS records correspond
to the hostname.

And if I move a laptop from one foreign network to an other, I most
certainly do not want the hostname to change. It is the same machine
with the same name even if it's network address/domain is completely
different compared to what it was 5 minutes ago. It would make
absolutely no sense to include the current network address in the kernel
version.

Anything that assumes that the hostname has anything to do with IP
networking and DNS records is just utterly broken IMHO.

Gabor

-- 
     ---------------------------------------------------------
     MTA SZTAKI Computer and Automation Research Institute
                Hungarian Academy of Sciences
     ---------------------------------------------------------
