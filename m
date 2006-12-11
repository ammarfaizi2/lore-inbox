Return-Path: <linux-kernel-owner+w=401wt.eu-S1763145AbWLKWBE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1763145AbWLKWBE (ORCPT <rfc822;w@1wt.eu>);
	Mon, 11 Dec 2006 17:01:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1763148AbWLKWBE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 11 Dec 2006 17:01:04 -0500
Received: from outmx003.isp.belgacom.be ([195.238.4.100]:48853 "EHLO
	outmx003.isp.belgacom.be" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1763145AbWLKWBC (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 11 Dec 2006 17:01:02 -0500
Date: Mon, 11 Dec 2006 23:00:40 +0100
From: Wim Van Sebroeck <wim@iguana.be>
To: David Brownell <david-b@pacbell.net>
Cc: linux-kernel@vger.kernel.org, Andrew Victor <andrew@sanpeople.com>,
       Rudolf Marek <r.marek@sh.cvut.cz>
Subject: Re: [patch 2.6.19-git] watchdog:  at91_wdt build fix
Message-ID: <20061211220040.GA2511@infomag.infomag.iguana.be>
References: <20061208072722.85DCE1EB27F@adsl-69-226-248-13.dsl.pltn13.pacbell.net> <20061210192348.GA2507@infomag.infomag.iguana.be> <200612101310.51286.david-b@pacbell.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200612101310.51286.david-b@pacbell.net>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi David,

> > See also Andrew Victor's patch (dated 04/Dec/2006) in the
> > linux-2.6-watchdog tree. It's indeed the at91rm9200_wdt, the mpcore_wdt
> > and the omap_wdt that are affected by the miscdev changes
> 
> I was just following the "fix brown paper bags ASAP" policy.
> One that seems followed less closely than usual in the current
> kernel tree.  :(

Hmmmm, if I re-read this then my original message wasn't really clear...
I actually wanted to say that I already included Andrew's patches and
because of that I didn't add your patches also. Sorry about that. 
But you're right: we need to fix things as soon as possible.

> Hmm, I'm a bit surprised that not all the watchdog drivers have
> this issue.  Is the problem that most of them don't actually
> adhere to the driver model ... that is, most don't have any kind
> of (platform or other) device backing the watchdog?

Most of them don't have the driver model yet and those who have
don't use the miscdev as a "parent". But this is on the roadmap 
as part of the conversion to the generic watchdog structure.
(Hmm, I need to talk to Rudolf Marek again and continue our
conversation about the generic watchdog functionsi -> will do
that tomorrow).

Greetings,
Wim.

