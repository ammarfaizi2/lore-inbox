Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261198AbVCCEN2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261198AbVCCEN2 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 2 Mar 2005 23:13:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261250AbVCCEJH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 2 Mar 2005 23:09:07 -0500
Received: from dsl027-180-174.sfo1.dsl.speakeasy.net ([216.27.180.174]:61674
	"EHLO cheetah.davemloft.net") by vger.kernel.org with ESMTP
	id S261198AbVCCEFT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 2 Mar 2005 23:05:19 -0500
Date: Wed, 2 Mar 2005 20:05:08 -0800
From: "David S. Miller" <davem@davemloft.net>
To: Jeff Garzik <jgarzik@pobox.com>
Cc: akpm@osdl.org, torvalds@osdl.org, linux-kernel@vger.kernel.org
Subject: Re: RFD: Kernel release numbering
Message-Id: <20050302200508.16acd5cf.davem@davemloft.net>
In-Reply-To: <42267737.4070702@pobox.com>
References: <Pine.LNX.4.58.0503021340520.25732@ppc970.osdl.org>
	<42264F6C.8030508@pobox.com>
	<20050302162312.06e22e70.akpm@osdl.org>
	<42265A6F.8030609@pobox.com>
	<20050302165830.0a74b85c.davem@davemloft.net>
	<42267737.4070702@pobox.com>
X-Mailer: Sylpheed version 1.0.1 (GTK+ 1.2.10; sparc-unknown-linux-gnu)
X-Face: "_;p5u5aPsO,_Vsx"^v-pEq09'CU4&Dc1$fQExov$62l60cgCc%FnIwD=.UF^a>?5'9Kn[;433QFVV9M..2eN.@4ZWPGbdi<=?[:T>y?SD(R*-3It"Vj:)"dP
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 02 Mar 2005 21:32:23 -0500
Jeff Garzik <jgarzik@pobox.com> wrote:

> I also note that part of the problem that motivates the even/odd thing 
> is a tacit acknowledgement that people only _really_ test the official 
> releases.
> 
> Which IMHO backs up my opinion that we simply need more frequent releases.

This more frequent release idea will basically mimmick what the
even/odd idea will do, except that even/odd will have specific
engineering goals.  Development vs. pure bug fixing.

There are changes that simply have to sit for weeks if not months
in order for all the problems to be weeded out.  I think something
like the 4-level pagetable stuff is the best example.  And yes it
has to occur in Linus's tree so what precious few people do test
his live tree try out the new code.
