Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262866AbVBCAjS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262866AbVBCAjS (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 2 Feb 2005 19:39:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262715AbVBCAgQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 2 Feb 2005 19:36:16 -0500
Received: from adsl-63-197-226-105.dsl.snfc21.pacbell.net ([63.197.226.105]:11665
	"EHLO cheetah.davemloft.net") by vger.kernel.org with ESMTP
	id S262777AbVBCAft (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 2 Feb 2005 19:35:49 -0500
Date: Wed, 2 Feb 2005 16:29:12 -0800
From: "David S. Miller" <davem@davemloft.net>
To: Fruhwirth Clemens <clemens@endorphin.org>
Cc: jmorris@redhat.com, akpm@osdl.org, linux-kernel@vger.kernel.org,
       michal@logix.cz, dm-crypt@saout.de
Subject: Re: [PATCH 01/04] Adding cipher mode context information to
 crypto_tfm
Message-Id: <20050202162912.2faa9f3a.davem@davemloft.net>
In-Reply-To: <1107390095.19339.26.camel@ghanima>
References: <Xine.LNX.4.44.0502021728140.5000-100000@thoron.boston.redhat.com>
	<1107386909.19339.9.camel@ghanima>
	<20050202153449.1e92c29a.davem@davemloft.net>
	<1107390095.19339.26.camel@ghanima>
X-Mailer: Sylpheed version 1.0.0 (GTK+ 1.2.10; sparc-unknown-linux-gnu)
X-Face: "_;p5u5aPsO,_Vsx"^v-pEq09'CU4&Dc1$fQExov$62l60cgCc%FnIwD=.UF^a>?5'9Kn[;433QFVV9M..2eN.@4ZWPGbdi<=?[:T>y?SD(R*-3It"Vj:)"dP
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 03 Feb 2005 01:21:35 +0100
Fruhwirth Clemens <clemens@endorphin.org> wrote:

> I'm afraid, I'm not going to change it. I already lost too much time
> pushing LRW into the kernel.

The work has to be done by somebody.  Linus would certainly reject any
attempt I would make to push code with that kind of variable naming
in it.  So instead of blindly going:

1) dave try push to linus
2) linus says fix horrible variable studlyCaps names
3) dave asks patch submitter to fix
4) submitter submits new patch
5) dave retries pushing to linus

I'm reducing it to one step, by asking that it be done now, thus
saving a lot of wasted time on everyone's part.

Submitting your first major patch or set of changes can be incredibly
frustrating.  It took more than a year before people like Linus would
regularly and smoothly integrate my work, most of it would come right
back to me for fixups.

Don't worry though, if the work is truly variable, someone will pick
up the ball and do the necessary coding style fixups et al. to get it
integrated.
