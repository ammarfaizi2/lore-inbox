Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265046AbTIDOcR (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 4 Sep 2003 10:32:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265060AbTIDOba
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 4 Sep 2003 10:31:30 -0400
Received: from pub234.cambridge.redhat.com ([213.86.99.234]:3597 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id S265043AbTIDOaZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 4 Sep 2003 10:30:25 -0400
Date: Thu, 4 Sep 2003 15:30:23 +0100
From: Christoph Hellwig <hch@infradead.org>
To: linux-kernel@vger.kernel.org, linux-scsi@vger.kernel.org,
       Arnaldo Carvalho de Melo <acme@conectiva.com.br>,
       Adrian Bunk <bunk@fs.tum.de>, Andrew Morton <akpm@osdl.org>,
       campbell@torque.net
Subject: Re: 2.6.0-test4-mm5: SCSI imm driver doesn't compile
Message-ID: <20030904153023.A32549@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	linux-kernel@vger.kernel.org, linux-scsi@vger.kernel.org,
	Arnaldo Carvalho de Melo <acme@conectiva.com.br>,
	Adrian Bunk <bunk@fs.tum.de>, Andrew Morton <akpm@osdl.org>,
	campbell@torque.net
References: <20030902231812.03fae13f.akpm@osdl.org> <20030903170256.GA18025@fs.tum.de> <20030904133056.GA2411@conectiva.com.br> <20030904135256.GS14376@lug-owl.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20030904135256.GS14376@lug-owl.de>; from jbglaw@lug-owl.de on Thu, Sep 04, 2003 at 03:52:56PM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 04, 2003 at 03:52:56PM +0200, Jan-Benedict Glaw wrote:
> C99 style is
> 
> 	.element = initializer,
> 
> not
> 	[element] = initializer,
> 
> which is a GNU/GCCism.

We're talking about arrays here..

.element obviously never works for arrays and [constant] never
works for structs..

