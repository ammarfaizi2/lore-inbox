Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266201AbUAGOFU (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 7 Jan 2004 09:05:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266205AbUAGOFT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 7 Jan 2004 09:05:19 -0500
Received: from jaguar.mkp.net ([192.139.46.146]:4994 "EHLO jaguar.mkp.net")
	by vger.kernel.org with ESMTP id S266201AbUAGOFQ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 7 Jan 2004 09:05:16 -0500
To: Christoph Hellwig <hch@infradead.org>
Cc: akpm@osdl.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] allow SGI IOC4 chipset support
References: <20040106010924.GA21747@sgi.com>
	<20040106102538.A14492@infradead.org>
	<yq04qv8ypkp.fsf@wildopensource.com>
	<20040107112648.A27801@infradead.org>
From: Jes Sorensen <jes@wildopensource.com>
Date: 07 Jan 2004 09:05:10 -0500
In-Reply-To: <20040107112648.A27801@infradead.org>
Message-ID: <yq0znczyhux.fsf@wildopensource.com>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.2
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> "Christoph" == Christoph Hellwig <hch@infradead.org> writes:

Christoph> On Wed, Jan 07, 2004 at 06:18:30AM -0500, Jes Sorensen
Christoph> wrote:
>> What about adding this?
>> 
>> Though shall not use weak symbols in though kernel ....

Christoph> That's stupid.  You should just not be allowed to compile
Christoph> the driver if it can work anywork.

I don't know if it's actually possible to use the card in a non-SN2,
not that I think anyone would want to. But if you prefer, just make
the equivalent change to the Kconfig file and remove the weak
reference.

Jes
