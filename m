Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263062AbUASVdh (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 19 Jan 2004 16:33:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263580AbUASVdh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 19 Jan 2004 16:33:37 -0500
Received: from mx1.redhat.com ([66.187.233.31]:27290 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S263062AbUASVdc (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 19 Jan 2004 16:33:32 -0500
Date: Mon, 19 Jan 2004 16:33:12 -0500 (EST)
From: James Morris <jmorris@redhat.com>
X-X-Sender: jmorris@thoron.boston.redhat.com
To: Clay Haapala <chaapala@cisco.com>
cc: linux-kernel@vger.kernel.org, <linux-scsi@vger.kernel.org>,
       "David S. Miller" <davem@redhat.com>
Subject: Re: [PATCH] Add CRC32C chksums to crypto routines
In-Reply-To: <yquj8yk31vxy.fsf@chaapala-lnx2.cisco.com>
Message-ID: <Xine.LNX.4.44.0401191632001.2019-100000@thoron.boston.redhat.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 19 Jan 2004, Clay Haapala wrote:

> In other email, Matt Mackall suggested a slightly different
> integration with the kernel that would allow more general usage of the
> CRC32C.  His suggestion was to put the implementation under /lib, next
> to the crc32 routines, and make the crypto routine a wrapper that calls
> it.  Selecting the CRYPTO_CRC32C module would SELECT the lib CRC32C
> module, in other words.
> 
> The benefit of this would be to allow easy usage by other routines
> (with no premption side-affects, a concern Matt has) while still being
> there for routines that process scatterlist.  And the table/code is
> still in one place.
> 
> Patch to follow in a day or two, after I can test it.  Implementation
> was simple.

Sounds good -- the inflate/deflate algorithms do this as well.


- James
-- 
James Morris
<jmorris@redhat.com>


