Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266186AbUA1VVT (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 28 Jan 2004 16:21:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266187AbUA1VVT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 28 Jan 2004 16:21:19 -0500
Received: from phoenix.infradead.org ([213.86.99.234]:2319 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id S266186AbUA1VVS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 28 Jan 2004 16:21:18 -0500
Date: Wed, 28 Jan 2004 21:21:15 +0000
From: Christoph Hellwig <hch@infradead.org>
To: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
Cc: torvalds@osdl.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] PC300 update
Message-ID: <20040128212115.A2027@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Marcelo Tosatti <marcelo.tosatti@cyclades.com>, torvalds@osdl.org,
	linux-kernel@vger.kernel.org
References: <Pine.LNX.4.58L.0401281741120.2088@logos.cnet>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <Pine.LNX.4.58L.0401281741120.2088@logos.cnet>; from marcelo.tosatti@cyclades.com on Wed, Jan 28, 2004 at 05:42:11PM -0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> - Mark pci_device_id list with __devinitdata

This is bogus and can crash the kernel if you're unlucky.

> - Add #ifdef DEBUG around debug printk()

What about dprintk or friends instead?

