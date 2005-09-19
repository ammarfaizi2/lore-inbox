Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932452AbVISU6y@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932452AbVISU6y (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 19 Sep 2005 16:58:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932462AbVISU6x
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 19 Sep 2005 16:58:53 -0400
Received: from ylpvm29-ext.prodigy.net ([207.115.57.60]:14552 "EHLO
	ylpvm29.prodigy.net") by vger.kernel.org with ESMTP id S932452AbVISU6x
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 19 Sep 2005 16:58:53 -0400
X-ORBL: [67.124.117.85]
Date: Mon, 19 Sep 2005 13:58:36 -0700
From: Chris Wedgwood <cw@f00f.org>
To: Pantelis Antoniou <pantelis@embeddedalley.com>
Cc: Christoph Hellwig <hch@infradead.org>, rmk+serial@arm.linux.org.uk,
       linux-kernel@vger.kernel.org, Pete Popov <ppopov@embeddedalley.com>,
       Matt Porter <mporter@embeddedalley.com>
Subject: Re: [PATCH] Au1x00 8250 uart support.
Message-ID: <20050919205836.GA16212@taniwha.stupidest.org>
References: <200509192340.10450.pantelis@embeddedalley.com> <20050919204454.GA30041@infradead.org> <200509192353.35427.pantelis@embeddedalley.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200509192353.35427.pantelis@embeddedalley.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 19, 2005 at 11:53:34PM +0300, Pantelis Antoniou wrote:

> Sure, I can do that.
>
> But the check for the map existence will take a couple of
> instructions then, for all architectures. If you're fine with that,
> it'd be no problem.

Or you an define an accessor #define foo_map(x,y) which would contain
*one* ifdef there and default to a NOP for all but au uart inflicted
platforms.
