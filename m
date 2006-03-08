Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030237AbWCHWcU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030237AbWCHWcU (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 8 Mar 2006 17:32:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030238AbWCHWcT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 8 Mar 2006 17:32:19 -0500
Received: from smtp.osdl.org ([65.172.181.4]:22427 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1030237AbWCHWcS (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 8 Mar 2006 17:32:18 -0500
Date: Wed, 8 Mar 2006 14:31:33 -0800 (PST)
From: Linus Torvalds <torvalds@osdl.org>
To: "David S. Miller" <davem@davemloft.net>
cc: paulus@samba.org, duncan.sands@math.u-psud.fr, dhowells@redhat.com,
       akpm@osdl.org, linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org,
       mingo@redhat.com, linuxppc64-dev@ozlabs.org, alan@lxorguk.ukuu.org.uk
Subject: Re: [PATCH] Document Linux's memory barriers
In-Reply-To: <20060308.142401.72886733.davem@davemloft.net>
Message-ID: <Pine.LNX.4.64.0603081431160.32577@g5.osdl.org>
References: <9551.1141762147@warthog.cambridge.redhat.com>
 <200603080925.19425.duncan.sands@math.u-psud.fr> <17423.21837.304330.623519@cargo.ozlabs.ibm.com>
 <20060308.142401.72886733.davem@davemloft.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Wed, 8 Mar 2006, David S. Miller wrote:
> 
> Just like for setjmp() I think you have to mark such things
> as volatile.

.. and sigatomic_t.

		Linus
