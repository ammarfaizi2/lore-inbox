Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266148AbUALTir (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 12 Jan 2004 14:38:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266177AbUALTir
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 12 Jan 2004 14:38:47 -0500
Received: from phoenix.infradead.org ([213.86.99.234]:48143 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id S266148AbUALTiq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 12 Jan 2004 14:38:46 -0500
Date: Mon, 12 Jan 2004 19:38:44 +0000
From: Christoph Hellwig <hch@infradead.org>
To: Jes Sorensen <jes@wildopensource.com>
Cc: akpm@osdl.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] allow SGI IOC4 chipset support
Message-ID: <20040112193844.B6991@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Jes Sorensen <jes@wildopensource.com>, akpm@osdl.org,
	linux-kernel@vger.kernel.org
References: <20040106010924.GA21747@sgi.com> <20040106102538.A14492@infradead.org> <yq0fzelchtw.fsf@wildopensource.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <yq0fzelchtw.fsf@wildopensource.com>; from jes@wildopensource.com on Mon, Jan 12, 2004 at 10:22:35AM -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 12, 2004 at 10:22:35AM -0500, Jes Sorensen wrote:
> +	snia_pciio_endian_set(dev, PCIDMA_ENDIAN_LITTLE, PCIDMA_ENDIAN_BIG);

Shouldn't we check for a failure here?

