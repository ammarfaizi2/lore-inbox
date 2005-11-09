Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030453AbVKIWpv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030453AbVKIWpv (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 9 Nov 2005 17:45:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030459AbVKIWpv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 9 Nov 2005 17:45:51 -0500
Received: from smtp.osdl.org ([65.172.181.4]:31199 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1030453AbVKIWpu (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 9 Nov 2005 17:45:50 -0500
Date: Wed, 9 Nov 2005 14:45:18 -0800
From: Andrew Morton <akpm@osdl.org>
To: Jody McIntyre <scjody@modernduck.com>
Cc: torvalds@osdl.org, linux-kernel@vger.kernel.org,
       James.Bottomley@steeleye.com, len.brown@intel.com, jgarzik@pobox.com,
       tony.luck@intel.com, bcollins@debian.org, dwmw2@infradead.org,
       rolandd@cisco.com, davej@codemonkey.org.uk, axboe@suse.de,
       shaggy@austin.ibm.com, sfrench@us.ibm.com
Subject: Re: merge status
Message-Id: <20051109144518.3144e7d8.akpm@osdl.org>
In-Reply-To: <20051109222356.GF14318@conscoop.ottawa.on.ca>
References: <20051109133558.513facef.akpm@osdl.org>
	<20051109221201.GE14318@conscoop.ottawa.on.ca>
	<Pine.LNX.4.64.0511091417540.4627@g5.osdl.org>
	<20051109222356.GF14318@conscoop.ottawa.on.ca>
X-Mailer: Sylpheed version 1.0.0 (GTK+ 1.2.10; i386-vine-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jody McIntyre <scjody@modernduck.com> wrote:
>
> Can I still send a 2k spinlock fix in ~2 weeks?

Bugfixes are of course always welcome - that's the entire reason for having
the stabilisation period.

>  That's the only thing I
> really want to get in to 2.6.15.

I think it's fair to make exemptions for subsystems which have been
neglected, or are flakey, or which are newly-merged, or which have a new
batch of maintainers who are struggling to get things back into shape and
back into sync with offstream trees.  Because a) those subsystems are
usually already pretty buggy and b) the team needs extra help to get stuff
back into shape asap.

I'd view 1394 as only partly-emerged from that state ;)

As long as you understand the overall philosophy of what we're trying to
do, you should be able to make your own decisions about what's suitable,
and when.
