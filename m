Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751152AbVL2Xmr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751152AbVL2Xmr (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 29 Dec 2005 18:42:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751154AbVL2Xmr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 29 Dec 2005 18:42:47 -0500
Received: from smtp.osdl.org ([65.172.181.4]:14813 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751152AbVL2Xmr (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 29 Dec 2005 18:42:47 -0500
Date: Thu, 29 Dec 2005 15:42:32 -0800 (PST)
From: Linus Torvalds <torvalds@osdl.org>
To: "Jeff V. Merkey" <jmerkey@wolfmountaingroup.com>
cc: Dave Jones <davej@redhat.com>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org
Subject: Re: userspace breakage
In-Reply-To: <43B453CA.9090005@wolfmountaingroup.com>
Message-ID: <Pine.LNX.4.64.0512291541420.3298@g5.osdl.org>
References: <Pine.LNX.4.64.0512281111080.14098@g5.osdl.org>
 <1135798495.2935.29.camel@laptopd505.fenrus.org> <Pine.LNX.4.64.0512281300220.14098@g5.osdl.org>
 <20051228212313.GA4388@elte.hu> <20051228214845.GA7859@elte.hu>
 <20051228201150.b6cfca14.akpm@osdl.org> <20051229073259.GA20177@elte.hu>
 <Pine.LNX.4.64.0512290923420.14098@g5.osdl.org> <20051229202852.GE12056@redhat.com>
 <Pine.LNX.4.64.0512291240490.3298@g5.osdl.org> <20051229224103.GF12056@redhat.com>
 <43B453CA.9090005@wolfmountaingroup.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Thu, 29 Dec 2005, Jeff V. Merkey wrote:
> 
> The breakage issue is ridiculous, assinine, and unnecessary. I have been
> porting dsfs to the various releases over the past month, and the
> breakage of user space, usb, nfs, memory management, is beyond absurd.

We're not talking about internal kernel stuff. Internal kernel stuff 
_does_ get changed, and we dont' care about breakage of out-of-kernel 
stuff. That's fundamental.

		Linus
