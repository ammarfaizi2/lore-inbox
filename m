Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267545AbRGXOXu>; Tue, 24 Jul 2001 10:23:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267546AbRGXOXj>; Tue, 24 Jul 2001 10:23:39 -0400
Received: from [193.120.224.170] ([193.120.224.170]:31374 "EHLO
	florence.itg.ie") by vger.kernel.org with ESMTP id <S267545AbRGXOXb>;
	Tue, 24 Jul 2001 10:23:31 -0400
Date: Tue, 24 Jul 2001 15:20:27 +0100 (IST)
From: Paul Jakma <paulj@alphyra.ie>
To: Dominik Kubla <kubla@sciobyte.de>
cc: Paul Jakma <paul@clubi.ie>, <linux-kernel@vger.kernel.org>
Subject: Re: Arp problem
In-Reply-To: <20010724140916.F31198@intern.kubla.de>
Message-ID: <Pine.LNX.4.33.0107241515100.14727-100000@rossi.itg.ie>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org
Original-Recipient: rfc822;linux-kernel-outgoing

On Tue, 24 Jul 2001, Dominik Kubla wrote:

> IMHO this is definitely a linux bug, since the kernel can not now about
> the true network topology:

but it does.. (see my other longer mail).

> Cable sharing might just be used for this one system doing the
> routing/filtering/whatever between the two networks, while all the
> other hosts are in seperated switch segments. Not a common setup
> but you will see this often enough: head count is already 2... ;-)

it should at least be possible..

eg, the linux router in question also runs an IDS to monitor traffic.
so even if windows /could/ follow redirects to other subnets i still
would want the linux box to route the traffic.. (rather than going
direct through the switch and never being seen by the linux IDS).

anyway..

(and yeah, i know it is not secure, just presume i have the switch
configured to lock certain ports to certain subnets).

> Dominik

--paulj

