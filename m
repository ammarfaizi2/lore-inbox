Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751435AbWHIXyu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751435AbWHIXyu (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 9 Aug 2006 19:54:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751375AbWHIXyu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 9 Aug 2006 19:54:50 -0400
Received: from dsl027-180-168.sfo1.dsl.speakeasy.net ([216.27.180.168]:8122
	"EHLO sunset.davemloft.net") by vger.kernel.org with ESMTP
	id S1751345AbWHIXyt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 9 Aug 2006 19:54:49 -0400
Date: Wed, 09 Aug 2006 16:54:31 -0700 (PDT)
Message-Id: <20060809.165431.118952392.davem@davemloft.net>
To: a.p.zijlstra@chello.nl
Cc: johnpol@2ka.mipt.ru, linux-mm@kvack.org, linux-kernel@vger.kernel.org,
       netdev@vger.kernel.org, phillips@google.com
Subject: Re: [RFC][PATCH 0/9] Network receive deadlock prevention for NBD
From: David Miller <davem@davemloft.net>
In-Reply-To: <1155130353.12225.53.camel@twins>
References: <1155127040.12225.25.camel@twins>
	<20060809130752.GA17953@2ka.mipt.ru>
	<1155130353.12225.53.camel@twins>
X-Mailer: Mew version 4.2 on Emacs 21.4 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Peter Zijlstra <a.p.zijlstra@chello.nl>
Date: Wed, 09 Aug 2006 15:32:33 +0200

> The idea is to drop all !NFS packets (or even more specific only
> keep those NFS packets that belong to the critical mount), and
> everybody doing critical IO over layered networks like IPSec or
> other tunnel constructs asks for trouble - Just DON'T do that.

People are doing I/O over IP exactly for it's ubiquity and
flexibility.  It seems a major limitation of the design if you cancel
out major components of this flexibility.

I really can't take this work seriously when I see things like this
being said.
