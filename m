Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268928AbUIXSn1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268928AbUIXSn1 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 24 Sep 2004 14:43:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269080AbUIXSn1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 24 Sep 2004 14:43:27 -0400
Received: from mx1.redhat.com ([66.187.233.31]:11427 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S268928AbUIXSnW (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 24 Sep 2004 14:43:22 -0400
Date: Fri, 24 Sep 2004 14:43:07 -0400 (EDT)
From: James Morris <jmorris@redhat.com>
X-X-Sender: jmorris@thoron.boston.redhat.com
To: "Theodore Ts'o" <tytso@mit.edu>
cc: Jean-Luc Cooke <jlcooke@certainkey.com>, <linux-kernel@vger.kernel.org>,
       <mpm@selenic.com>
Subject: Re: [PROPOSAL/PATCH] Fortuna PRNG in /dev/random
In-Reply-To: <20040924174301.GB20320@thunk.org>
Message-ID: <Xine.LNX.4.44.0409241440410.8732-100000@thoron.boston.redhat.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 24 Sep 2004, Theodore Ts'o wrote:

> have *any* encryption algorithms in the kernel at all.  As to whether
> or not cryptoapi needs to be mandatory in the kernel, the question is
> aside from /dev/random, do most people need to have crypto in the
> kernel?  If they're not using ipsec, or crypto loop devices, etc.,
> they might not want to have the crypto api in their kernel
> unconditionally.

As far as I know embedded folk do not want the crypto API to be mandatory,
although I think Matt Mackall wanted to try and make something work
(perhaps a subset just for /dev/random use).


- James
-- 
James Morris
<jmorris@redhat.com>



