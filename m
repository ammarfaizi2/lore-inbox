Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266390AbSKOQQG>; Fri, 15 Nov 2002 11:16:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266408AbSKOQQG>; Fri, 15 Nov 2002 11:16:06 -0500
Received: from brussels-smtp.planetinternet.be ([195.95.34.12]:8717 "EHLO
	firebird.planetinternet.be") by vger.kernel.org with ESMTP
	id <S266390AbSKOQQF>; Fri, 15 Nov 2002 11:16:05 -0500
Date: Fri, 15 Nov 2002 17:27:04 +0100
To: Ian Chilton <ian@ichilton.co.uk>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Anyone use HPT366 + UDMA in Linux?
Message-ID: <20021115162704.GA1059@gouv>
References: <20021115123541.GA1889@buzz.ichilton.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20021115123541.GA1889@buzz.ichilton.co.uk>
User-Agent: Mutt/1.4i
From: Leopold Gouverneur <lgouv@pi.be>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 15, 2002 at 12:35:41PM +0000, Ian Chilton wrote:
> Hello,
> 
> I am interested in anyone that has this sucessfully working - if you
> have maybe you can drop me a mail telling me how you did it :)

I am using an IBM-DTLA-307030 with HPT366 for almost 2 years with
many kernels in 2.4 and 2.5 series without problems after limiting
transfer rate to udma3 (44MB/s) in the HPT bios. You can also do it with
hdparm if your boot disk is not on that controler. Trying udma4 resulted
in _massive_ corruption (never tried recently). Of course, I enabled
HPT366 support in kernel configuration. Hdparm gives 35 MM/sec.
This is on an Abit BP6. Hope it helps.

