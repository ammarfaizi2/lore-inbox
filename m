Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261238AbVAaPrv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261238AbVAaPrv (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 31 Jan 2005 10:47:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261239AbVAaPrv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 31 Jan 2005 10:47:51 -0500
Received: from mx1.redhat.com ([66.187.233.31]:7886 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S261238AbVAaPrt (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 31 Jan 2005 10:47:49 -0500
Date: Mon, 31 Jan 2005 10:47:42 -0500 (EST)
From: James Morris <jmorris@redhat.com>
X-X-Sender: jmorris@thoron.boston.redhat.com
To: Matt Mackall <mpm@selenic.com>
cc: Fruhwirth Clemens <clemens@endorphin.org>, Andrew Morton <akpm@osdl.org>,
       <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 04/04] Add LRW
In-Reply-To: <20050130172539.GG2891@waste.org>
Message-ID: <Xine.LNX.4.44.0501311042320.25285-100000@thoron.boston.redhat.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 30 Jan 2005, Matt Mackall wrote:

> > > LRW and the GF(2**128) code is not configurable?
> > 
> > No, it's a cipher mode. None of the modes is configurable.
> 
> Is LRW an appropriate mode for anything but block storage?

Looks like it is only specified for this case.

"The scope of this document is limited to direct application of the 
 LRW-AES transform to encrypt or decrypt data at rest, when this data 
 consists of an integral number of wide blocks."

Where "wide blocks" means "512 consecutive bytes".

In any case, LRW should be made configurable and marked experimental.


- James
-- 
James Morris
<jmorris@redhat.com>


