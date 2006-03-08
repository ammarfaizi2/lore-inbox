Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932208AbWCHVnY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932208AbWCHVnY (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 8 Mar 2006 16:43:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932207AbWCHVnY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 8 Mar 2006 16:43:24 -0500
Received: from kanga.kvack.org ([66.96.29.28]:13734 "EHLO kanga.kvack.org")
	by vger.kernel.org with ESMTP id S932208AbWCHVnX (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 8 Mar 2006 16:43:23 -0500
Date: Wed, 8 Mar 2006 16:37:56 -0500
From: Benjamin LaHaise <bcrl@kvack.org>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: "Bryan O'Sullivan" <bos@pathscale.com>, akpm@osdl.org, ak@suse.de,
       paulus@samba.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Define flush_wc, a way to flush write combining store buffers
Message-ID: <20060308213756.GB5410@kvack.org>
References: <e27c8e0061e03594b3e1.1141853501@localhost.localdomain> <1141853919.11221.183.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1141853919.11221.183.camel@localhost.localdomain>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 09, 2006 at 08:38:39AM +1100, Benjamin Herrenschmidt wrote:
> I think people already don't undersatnd the existing gazillion of
> barriers we have with quite unclear semantics in some cases, it's not
> time to add a new one ...

We went over the details of this in a pretty long thread, and you can't 
use any of the existing memory barriers to solve this particular problem.  
I think the definition of this one is well done now.

		-ben
-- 
"Time is of no importance, Mr. President, only life is important."
Don't Email: <dont@kvack.org>.
