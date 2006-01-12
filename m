Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932671AbWALAVY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932671AbWALAVY (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 11 Jan 2006 19:21:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932672AbWALAVY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 11 Jan 2006 19:21:24 -0500
Received: from mx.pathscale.com ([64.160.42.68]:36565 "EHLO mx.pathscale.com")
	by vger.kernel.org with ESMTP id S932671AbWALAVX (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 11 Jan 2006 19:21:23 -0500
Subject: Re: [PATCH 3 of 3] Add __raw_memcpy_toio32 to each arch
From: "Bryan O'Sullivan" <bos@pathscale.com>
To: Andrew Morton <akpm@osdl.org>
Cc: rdreier@cisco.com, linux-kernel@vger.kernel.org, hch@infradead.org,
       ak@suse.de
In-Reply-To: <20060111161349.565394d1.akpm@osdl.org>
References: <patchbomb.1137019194@eng-12.pathscale.com>
	 <ee6ce7e55dc7aec0d870.1137019197@eng-12.pathscale.com>
	 <20060111154614.47725c23.akpm@osdl.org>
	 <1137024358.17705.33.camel@localhost.localdomain>
	 <20060111161349.565394d1.akpm@osdl.org>
Content-Type: text/plain
Date: Wed, 11 Jan 2006 16:21:05 -0800
Message-Id: <1137025265.17705.35.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2006-01-11 at 16:13 -0800, Andrew Morton wrote:

> There are other common things which can be hoisted to linux/io.h, but if we
> do that then zillions of .c files need to be changed to include linux/io.h
> rather than asm/io.h.

Right.

> That's a good janitorial thing to do, but I doubt if
> you want to do it ;)

Not as part of these patches, anyway.  They've left me a dried-up husk.

	<b

