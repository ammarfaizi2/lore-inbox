Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261912AbVD0Ehw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261912AbVD0Ehw (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 27 Apr 2005 00:37:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261913AbVD0Ehv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 27 Apr 2005 00:37:51 -0400
Received: from dsl027-180-174.sfo1.dsl.speakeasy.net ([216.27.180.174]:62364
	"EHLO cheetah.davemloft.net") by vger.kernel.org with ESMTP
	id S261912AbVD0Ehr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 27 Apr 2005 00:37:47 -0400
Date: Tue, 26 Apr 2005 21:28:59 -0700
From: "David S. Miller" <davem@davemloft.net>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: grundler@parisc-linux.org, linux-pci@atrey.karlin.mff.cuni.cz,
       linux-kernel@vger.kernel.org, greg@kroah.com, bjorn.helgaas@hp.com
Subject: Re: pci-sysfs resource mmap broken
Message-Id: <20050426212859.40c14c36.davem@davemloft.net>
In-Reply-To: <1114576221.7182.140.camel@gaston>
References: <1114493609.7183.55.camel@gaston>
	<20050426163042.GE2612@colo.lackof.org>
	<1114555655.7183.81.camel@gaston>
	<20050427035535.GI2612@colo.lackof.org>
	<1114576221.7182.140.camel@gaston>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; sparc-unknown-linux-gnu)
X-Face: "_;p5u5aPsO,_Vsx"^v-pEq09'CU4&Dc1$fQExov$62l60cgCc%FnIwD=.UF^a>?5'9Kn[;433QFVV9M..2eN.@4ZWPGbdi<=?[:T>y?SD(R*-3It"Vj:)"dP
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 27 Apr 2005 14:30:21 +1000
Benjamin Herrenschmidt <benh@kernel.crashing.org> wrote:

> True, but then, I tend to prefer you idea of a CPU view ... so my new
> "proposal" is something like pci_resource_to_user() implementation.
> Anyway, wait a bit so I can polish this patch and tell me what you
> think :)

I know that in particular I don't need to tell you this Ben,
but just in case please make sure it handles the 64-bit
kernel 32-bit userspace properly :-)

I'm very happy someone is working on this issue.
So don't get discouraged :)
