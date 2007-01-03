Return-Path: <linux-kernel-owner+w=401wt.eu-S1751520AbXACAXo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751520AbXACAXo (ORCPT <rfc822;w@1wt.eu>);
	Tue, 2 Jan 2007 19:23:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751592AbXACAXo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 2 Jan 2007 19:23:44 -0500
Received: from gate.crashing.org ([63.228.1.57]:53933 "EHLO gate.crashing.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751520AbXACAXn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 2 Jan 2007 19:23:43 -0500
In-Reply-To: <200701030057.08957.m.kozlowski@tuxland.pl>
References: <200701021238.36297.m.kozlowski@tuxland.pl> <1220f3e52f791ff8871ca9328b027a5a@kernel.crashing.org> <200701030057.08957.m.kozlowski@tuxland.pl>
Mime-Version: 1.0 (Apple Message framework v623)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <fe1ade034ed253be4ed738a9a91d5718@kernel.crashing.org>
Content-Transfer-Encoding: 7bit
Cc: paulus@samba.org, linuxppc-dev@ozlabs.org, linux-kernel@vger.kernel.org
From: Segher Boessenkool <segher@kernel.crashing.org>
Subject: Re: [PATCH] ppc: vio of_node_put cleanup
Date: Wed, 3 Jan 2007 01:24:04 +0100
To: Mariusz Kozlowski <m.kozlowski@tuxland.pl>
X-Mailer: Apple Mail (2.623)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>> The comment used to be inside the "if" block, is this
>> change correct?
>
> You'd prefer an empty line in there?

Obviously, you should change the comment to include the
conditional, if that is what is needed.

>> [And, do we want all these changes anyway?  I don't care
>> either way, both sides have their pros and their cons --
>> just asking :-) ]
>
> You know my opinion already :-)

Heh.  Ok, I'll rephrase: is there _consensus_ that this is a
good thing :-)  [But never mind, I looked it up, and it is
*documented* as being supported, so fine with me].


Segher

