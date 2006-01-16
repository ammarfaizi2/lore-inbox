Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751224AbWAPWXF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751224AbWAPWXF (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 16 Jan 2006 17:23:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751225AbWAPWXE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 16 Jan 2006 17:23:04 -0500
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:41885 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP
	id S1751224AbWAPWXC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 16 Jan 2006 17:23:02 -0500
Subject: Re: wireless: recap of current issues (configuration)
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: "John W. Linville" <linville@tuxdriver.com>
Cc: Samuel Ortiz <samuel.ortiz@nokia.com>,
       ext Stuffed Crust <pizza@shaftnet.org>, Jeff Garzik <jgarzik@pobox.com>,
       Johannes Berg <johannes@sipsolutions.net>, netdev@vger.kernel.org,
       linux-kernel@vger.kernel.org
In-Reply-To: <20060116190629.GB5529@tuxdriver.com>
References: <20060113212605.GD16166@tuxdriver.com>
	 <20060113213011.GE16166@tuxdriver.com>
	 <20060113221935.GJ16166@tuxdriver.com> <1137191522.2520.63.camel@localhost>
	 <20060114011726.GA19950@shaftnet.org> <43C97605.9030907@pobox.com>
	 <20060115152034.GA1722@shaftnet.org>
	 <Pine.LNX.4.58.0601152038540.19953@irie>
	 <20060116170951.GA8596@shaftnet.org>
	 <Pine.LNX.4.58.0601162020260.17348@irie>
	 <20060116190629.GB5529@tuxdriver.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Mon, 16 Jan 2006 22:24:41 +0000
Message-Id: <1137450281.15553.87.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Llu, 2006-01-16 at 14:06 -0500, John W. Linville wrote:
> If regulators come down on someone, it seems like common sense
> that they would be more lenient on mobile stations complying with a
> misconfigured AP than they would be with a mobile station ignoring a
> properly configured AP?  I know expecting common sense from government
> regulators is optimistic, but still... :-)

I can't guess on the subject of US regulators but for the UK experience
in other communities (eg amateur radio), and public statements indicate
that their high priorities are interference with emergency services and
the like. 

Concerns of direct relevance are
- transmitting on unlicensed frequencies (and 802.11 channel allocations
are dependant on nation - even within the EU)
- power violation
- anything else causing interference to other legitimate users at a
radio level

I would expect equipment to honour the subset of configurations that
meet BOTH the regulatory domain the system believes it exists within
(which may change dynamically!) AND the AP advertisement.

If I have told my equipment to obey UK law I expect it to do so. If I
hop on the train to France and forget to revise my configuration I'd
prefer it also believed the APs

Alan

