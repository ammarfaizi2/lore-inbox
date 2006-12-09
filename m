Return-Path: <linux-kernel-owner+w=401wt.eu-S1758446AbWLIVwU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758446AbWLIVwU (ORCPT <rfc822;w@1wt.eu>);
	Sat, 9 Dec 2006 16:52:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758461AbWLIVwU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 9 Dec 2006 16:52:20 -0500
Received: from gate.crashing.org ([63.228.1.57]:60764 "EHLO gate.crashing.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756344AbWLIVwT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 9 Dec 2006 16:52:19 -0500
Subject: Re: [PATCH 0/3] New firewire stack
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Stefan Richter <stefanr@s5r6.in-berlin.de>
Cc: linux1394-devel@lists.sourceforge.net, Pavel Machek <pavel@ucw.cz>,
       Erik Mouw <erik@harddisk-recovery.com>,
       Kristian H?gsberg <krh@redhat.com>,
       Marcel Holtmann <marcel@holtmann.org>, linux-kernel@vger.kernel.org
In-Reply-To: <45798022.2090104@s5r6.in-berlin.de>
References: <20061205052229.7213.38194.stgit@dinky.boston.redhat.com>
	 <1165308400.2756.2.camel@localhost> <45758CB3.80701@redhat.com>
	 <20061205160530.GB6043@harddisk-recovery.com>
	 <20060712145650.GA4403@ucw.cz>  <45798022.2090104@s5r6.in-berlin.de>
Content-Type: text/plain
Date: Sun, 10 Dec 2006 08:51:44 +1100
Message-Id: <1165701104.1103.159.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.8.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> One thing is for sure, the fw_ prefix is not too well suited to stay
> if/when Kristian's code is pushed to mainline. During a switch period,
> we could e.g. replace the old stack's prefixes by hpsb1_ (as the 1st
> generation of FireWire kernel APIs) or whatever and replace Kristian's
> prefixes by hpsb_. I would actually like fw_ most (if it wasn't so
> overloaded and already used in other contexts) and the author's decision
> should be honored too.

One of the problems with hpsb_ is that it's a total pain to type and
doesn't mean anything at first sight :-)

Ben.


