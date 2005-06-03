Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261484AbVFCS1e@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261484AbVFCS1e (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 3 Jun 2005 14:27:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261486AbVFCS1e
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 3 Jun 2005 14:27:34 -0400
Received: from orb.pobox.com ([207.8.226.5]:9101 "EHLO orb.pobox.com")
	by vger.kernel.org with ESMTP id S261484AbVFCS1c (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 3 Jun 2005 14:27:32 -0400
Date: Fri, 3 Jun 2005 13:27:25 -0500
From: Nathan Lynch <ntl@pobox.com>
To: Roland Dreier <roland@topspin.com>
Cc: "Martin J. Bligh" <mbligh@mbligh.org>,
       ppc64 dev list <linuxppc64-dev@ozlabs.org>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: 2.6.12-rc5-git8 regression on PPC64
Message-ID: <20050603182725.GB11355@otto>
References: <374360000.1117810369@[10.10.2.4]> <52is0vwd49.fsf@topspin.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <52is0vwd49.fsf@topspin.com>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Roland Dreier wrote:
> I'm seeing something possibly related as well -- with an up-to-date
> git tree (HEAD == d8d088d25822b0199fdfb392085e1cf8a5914a97), I get a
> hang early in the boot on an OpenPower 710 (2 x POWER5).

Backing this one out fixes it here on a Power5 570.

http://marc.theaimsgroup.com/?l=bk-commits-head&m=111772917211270&q=raw

Ben, any ideas?


Nathan
