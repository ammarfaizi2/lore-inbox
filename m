Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261373AbVCCBCS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261373AbVCCBCS (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 2 Mar 2005 20:02:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261401AbVCCBCK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 2 Mar 2005 20:02:10 -0500
Received: from dsl027-180-174.sfo1.dsl.speakeasy.net ([216.27.180.174]:27560
	"EHLO cheetah.davemloft.net") by vger.kernel.org with ESMTP
	id S261373AbVCCA6s (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 2 Mar 2005 19:58:48 -0500
Date: Wed, 2 Mar 2005 16:58:30 -0800
From: "David S. Miller" <davem@davemloft.net>
To: Jeff Garzik <jgarzik@pobox.com>
Cc: akpm@osdl.org, torvalds@osdl.org, linux-kernel@vger.kernel.org
Subject: Re: RFD: Kernel release numbering
Message-Id: <20050302165830.0a74b85c.davem@davemloft.net>
In-Reply-To: <42265A6F.8030609@pobox.com>
References: <Pine.LNX.4.58.0503021340520.25732@ppc970.osdl.org>
	<42264F6C.8030508@pobox.com>
	<20050302162312.06e22e70.akpm@osdl.org>
	<42265A6F.8030609@pobox.com>
X-Mailer: Sylpheed version 1.0.1 (GTK+ 1.2.10; sparc-unknown-linux-gnu)
X-Face: "_;p5u5aPsO,_Vsx"^v-pEq09'CU4&Dc1$fQExov$62l60cgCc%FnIwD=.UF^a>?5'9Kn[;433QFVV9M..2eN.@4ZWPGbdi<=?[:T>y?SD(R*-3It"Vj:)"dP
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 02 Mar 2005 19:29:35 -0500
Jeff Garzik <jgarzik@pobox.com> wrote:

> If the time between big merges increases, as with this proposal, then 
> the distance between local dev trees and linux-2.6 increases.
> 
> With that distance, breakages like the 64-bit resource struct stuff 
> become more painful.
> 
> I like my own "ongoing dev tree, ongoing stable tree" proposal a lot 
> better.  But then, I'm biased :)

The problem is people don't test until 2.6.whatever-final goes out.
Nothing will change that.

And the day Linus releases we always get a pile of "missing MODULE_EXPORT()"
type bug reports that are one liner fixes.  Those fixes will not be seen by
users until the next 2.6.x rev comes out and right now that takes months
which is rediculious for such simple fixes.

We're talking about a one week "calming" period to collect the brown paper
bag fixes for a 2.6.${even} release, that's all.

All this "I have to hold onto my backlog longer, WAHHH!" arguments are bogus
IMHO.  We're using a week of quiescence to fix the tree for users so they
are happy whilst we work on the 2.6.${odd} interesting stuff :-)
