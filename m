Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262353AbUAONtL (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 15 Jan 2004 08:49:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265051AbUAONtL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 15 Jan 2004 08:49:11 -0500
Received: from phoenix.infradead.org ([213.86.99.234]:22794 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id S262353AbUAONtK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 15 Jan 2004 08:49:10 -0500
Date: Thu, 15 Jan 2004 13:49:06 +0000
From: Christoph Hellwig <hch@infradead.org>
To: Adrian Bunk <bunk@fs.tum.de>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       James Manning <jmm@sublogic.com>
Subject: Re: [PATCH] linux-2.6.0-test3 - remove a few remaining "make dep" references (fwd)
Message-ID: <20040115134906.A11703@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Adrian Bunk <bunk@fs.tum.de>, Andrew Morton <akpm@osdl.org>,
	linux-kernel@vger.kernel.org, James Manning <jmm@sublogic.com>
References: <20040115130555.GA23383@fs.tum.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20040115130555.GA23383@fs.tum.de>; from bunk@fs.tum.de on Thu, Jan 15, 2004 at 02:05:56PM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 15, 2004 at 02:05:56PM +0100, Adrian Bunk wrote:
>  #
> -# Note! Dependencies are done automagically by 'make dep', which also
> -# removes any old dependencies. DON'T put your own dependencies here
> +# Note! DON'T put your own dependencies here
>  # unless it's something special (ie not a .c file).

What about killing this whole boilerplate?  While it's strictly speaking
not incorrect I don't think it's a good idea to have it repeated all over
the place.

