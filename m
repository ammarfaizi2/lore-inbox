Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131365AbRBAThK>; Thu, 1 Feb 2001 14:37:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131175AbRBAThA>; Thu, 1 Feb 2001 14:37:00 -0500
Received: from zeus.kernel.org ([209.10.41.242]:48326 "EHLO zeus.kernel.org")
	by vger.kernel.org with ESMTP id <S131365AbRBATgt>;
	Thu, 1 Feb 2001 14:36:49 -0500
Date: Thu, 1 Feb 2001 19:33:34 +0000
From: "Stephen C. Tweedie" <sct@redhat.com>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>, "Stephen C. Tweedie" <sct@redhat.com>,
        Steve Lord <lord@sgi.com>, linux-kernel@vger.kernel.org,
        kiobuf-io-devel@lists.sourceforge.net
Subject: Re: [Kiobuf-io-devel] RFC: Kernel mechanism: Compound event wait /notify + callback chains
Message-ID: <20010201193334.E11607@redhat.com>
In-Reply-To: <20010201180237.A28007@caldera.de> <E14ONdD-0004gz-00@the-village.bc.nu> <20010201184950.A448@caldera.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2i
In-Reply-To: <20010201184950.A448@caldera.de>; from hch@caldera.de on Thu, Feb 01, 2001 at 06:49:50PM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Thu, Feb 01, 2001 at 06:49:50PM +0100, Christoph Hellwig wrote:
> 
> > Adding tons of base/limit pairs to kiobufs makes it worse not better
> 
> For disk I/O it makes the handling a little easier for the cost of the
> additional offset/length fields.

Umm, actually, no, it makes it much worse for many of the cases.  

--Stephen
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
