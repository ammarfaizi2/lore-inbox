Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261890AbUAMIJn (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 13 Jan 2004 03:09:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261950AbUAMIJm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 13 Jan 2004 03:09:42 -0500
Received: from jaguar.mkp.net ([192.139.46.146]:13008 "EHLO jaguar.mkp.net")
	by vger.kernel.org with ESMTP id S261890AbUAMIJl (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 13 Jan 2004 03:09:41 -0500
To: Christoph Hellwig <hch@infradead.org>
Cc: akpm@osdl.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] allow SGI IOC4 chipset support
References: <20040106010924.GA21747@sgi.com>
	<20040106102538.A14492@infradead.org>
	<yq0fzelchtw.fsf@wildopensource.com>
	<20040112193844.B6991@infradead.org>
From: Jes Sorensen <jes@wildopensource.com>
Date: 13 Jan 2004 03:09:19 -0500
In-Reply-To: <20040112193844.B6991@infradead.org>
Message-ID: <yq0vfnge0cw.fsf@wildopensource.com>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.2
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> "Christoph" == Christoph Hellwig <hch@infradead.org> writes:

Christoph> On Mon, Jan 12, 2004 at 10:22:35AM -0500, Jes Sorensen
Christoph> wrote:
>> + snia_pciio_endian_set(dev, PCIDMA_ENDIAN_LITTLE,
>> PCIDMA_ENDIAN_BIG);

Christoph> Shouldn't we check for a failure here?

We could, but I don't believe it can actually fail.

Jes
