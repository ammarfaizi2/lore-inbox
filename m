Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263845AbTCUTFU>; Fri, 21 Mar 2003 14:05:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263826AbTCUTFP>; Fri, 21 Mar 2003 14:05:15 -0500
Received: from pc2-cwma1-4-cust86.swan.cable.ntl.com ([213.105.254.86]:26262
	"EHLO irongate.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S263845AbTCUTCE>; Fri, 21 Mar 2003 14:02:04 -0500
Subject: Re: PATCH: module for legacy PC9800 ide
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Christoph Hellwig <hch@infradead.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       tomita@cinet.co.jp
In-Reply-To: <20030321185905.A7664@infradead.org>
References: <200303211928.h2LJSjWS025795@hraefn.swansea.linux.org.uk>
	 <20030321185905.A7664@infradead.org>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Organization: 
Message-Id: <1048278284.5718.87.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 (1.2.2-5) 
Date: 21 Mar 2003 20:24:44 +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2003-03-21 at 18:59, Christoph Hellwig wrote:
> On Fri, Mar 21, 2003 at 07:28:45PM +0000, Alan Cox wrote:
> > +	/* These ports are probably used by IDE I/F.  */
> > +	request_region(0x430, 1, "ide");
> > +	request_region(0x435, 1, "ide");
> 
> No error chechking?

If it fails you have a rather bigger problem on your hands.

I agree however - Osamu, can you fix this
