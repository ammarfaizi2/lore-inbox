Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261986AbVBJAac@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261986AbVBJAac (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 9 Feb 2005 19:30:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261987AbVBJAab
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 9 Feb 2005 19:30:31 -0500
Received: from mx1.redhat.com ([66.187.233.31]:47042 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S261986AbVBJAa0 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 9 Feb 2005 19:30:26 -0500
Date: Wed, 9 Feb 2005 19:30:14 -0500 (EST)
From: James Morris <jmorris@redhat.com>
X-X-Sender: jmorris@thoron.boston.redhat.com
To: Fruhwirth Clemens <clemens@endorphin.org>
cc: Andrew Morton <akpm@osdl.org>, <linux-kernel@vger.kernel.org>,
       <michal@logix.cz>, "David S. Miller" <davem@davemloft.net>,
       "Adam J. Richter" <adam@yggdrasil.com>
Subject: Re: [PATCH 01/04] Adding cipher mode context information to crypto_tfm
In-Reply-To: <1107940449.14810.12.camel@ghanima>
Message-ID: <Xine.LNX.4.44.0502091859540.6222-100000@thoron.boston.redhat.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 9 Feb 2005, Fruhwirth Clemens wrote:

> I can't code for the case of two. Because, first, that's the idea of
> generic in the name "generic scatterwalk", second, I need at least 3
> scatterlists in parallel for LRW.

Can you explain why you need a third scatterlist for the LRW tweak?

My understanding is that the tweak value is calculated from the disk
position of the plaintext block and and the secondary key.

It would be useful to see the original patch (which seems to be
unavailable now), with dm-crypt integration, to see how the entire
mechanism works beyond the test vectors.


- James
-- 
James Morris
<jmorris@redhat.com>




