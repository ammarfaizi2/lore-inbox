Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262981AbUCKEF5 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 10 Mar 2004 23:05:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262983AbUCKEF5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 10 Mar 2004 23:05:57 -0500
Received: from mx1.redhat.com ([66.187.233.31]:31191 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S262981AbUCKEFy (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 10 Mar 2004 23:05:54 -0500
Date: Wed, 10 Mar 2004 23:06:37 -0500 (EST)
From: James Morris <jmorris@redhat.com>
X-X-Sender: jmorris@thoron.boston.redhat.com
To: Jouni Malinen <jkmaline@cc.hut.fi>
cc: Clay Haapala <chaapala@cisco.com>, "David S. Miller" <davem@redhat.com>,
       <linux-kernel@vger.kernel.org>
Subject: Re: Crypto API and keyed non-HMAC digest algorithms / Michael MIC
In-Reply-To: <20040311030035.GA3782@jm.kir.nu>
Message-ID: <Xine.LNX.4.44.0403102302450.935-100000@thoron.boston.redhat.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 10 Mar 2004, Jouni Malinen wrote:

> On Wed, Mar 10, 2004 at 10:45:28AM -0500, James Morris wrote:
> 
> I was unable to reproduce the oops by loading tcrypt. All tests passed
> and the kernel was fine. I did this testing with Linux 2.6.4-rc3 and
> all crypto algs compiled as modules. I will try this again with the
> latest linus-2.5 BK tree just in case. Anyway, if you happen to have any
> more details from the oops like backtrace or any ideas of what might be
> causing the difference in our results, they would be very helpful.
> 

I can't reproduce it now either (AFAICR, it oopsed in test_hash().  

I suspect it may have been caused by loading tcrypt module which was out
of sync with the digest setkey change.


- James
-- 
James Morris
<jmorris@redhat.com>


