Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261696AbUCKUOC (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 11 Mar 2004 15:14:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261707AbUCKUOC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 11 Mar 2004 15:14:02 -0500
Received: from mx1.redhat.com ([66.187.233.31]:47077 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S261696AbUCKUN4 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 11 Mar 2004 15:13:56 -0500
Date: Thu, 11 Mar 2004 15:14:36 -0500 (EST)
From: James Morris <jmorris@redhat.com>
X-X-Sender: jmorris@thoron.boston.redhat.com
To: Clay Haapala <chaapala@cisco.com>
cc: Jouni Malinen <jkmaline@cc.hut.fi>, "David S. Miller" <davem@redhat.com>,
       <linux-kernel@vger.kernel.org>
Subject: Re: Crypto API and keyed non-HMAC digest algorithms / Michael MIC
In-Reply-To: <yqujr7vztk99.fsf@chaapala-lnx2.cisco.com>
Message-ID: <Xine.LNX.4.44.0403111513260.3693-100000@thoron.boston.redhat.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 11 Mar 2004, Clay Haapala wrote:

> OK, so I should recode CRC32C to be a variation of digest that employs
> a setkey() handler, right?  Should be no problem.

Give it a try and see.

> Can I get to a reasonable development environment by starting with
> 2.6.3, and adding the patch you just sent?  Or, do I need the Michael
> MIC patch, as well?

Yes, please apply the first two patches first.


- James
-- 
James Morris
<jmorris@redhat.com>


