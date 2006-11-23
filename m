Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1757477AbWKWVfl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757477AbWKWVfl (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 23 Nov 2006 16:35:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757478AbWKWVfl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 23 Nov 2006 16:35:41 -0500
Received: from main.gmane.org ([80.91.229.2]:9633 "EHLO ciao.gmane.org")
	by vger.kernel.org with ESMTP id S1757477AbWKWVfk (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 23 Nov 2006 16:35:40 -0500
X-Injected-Via-Gmane: http://gmane.org/
To: linux-kernel@vger.kernel.org
From: Gunter Ohrner <G.Ohrner@post.rwth-aachen.de>
Subject: Re: Entropy Pool Contents
Date: Thu, 23 Nov 2006 22:34:43 +0100
Message-ID: <ek546d$icj$1@sea.gmane.org>
References: <ek2nva$vgk$1@sea.gmane.org> <20061123205436.GA16440@csclub.uwaterloo.ca>
Reply-To: G.Ohrner@post.rwth-aachen.de
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7Bit
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: e179249004.adsl.alicedsl.de
User-Agent: KNode/0.10.4
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Lennart Sorensen wrote:
> Only some devices/drivers generate entropy data.  Some network drivers,

Yes, I know, but block device operations should, and directly feeding data
into /dev/*random, as I did, definitely should.

This machine usually has only very limited entropy available, but the pool
currently seeems to bee stuck at "0" - there's no way to get it to even
display a slightly different number. That's what confused me pretty much...

Normally doing disk IO helps a bit, but it currently does not at all.

> pcnet32 and the 8250 driver to generate entropy since otherwise I tended
> to run out very quickly.

I guess I also should do that - as this machine has several network cards on
different networks, that will be definiteely more seecure than running with
a completely empty entropy pool stuck at zero bits for several days in a
row...

Greetings,

  Gunter

