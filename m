Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131699AbRBAVAA>; Thu, 1 Feb 2001 16:00:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131008AbRBAU7w>; Thu, 1 Feb 2001 15:59:52 -0500
Received: from ns.caldera.de ([212.34.180.1]:9480 "EHLO ns.caldera.de")
	by vger.kernel.org with ESMTP id <S131222AbRBAU7l>;
	Thu, 1 Feb 2001 15:59:41 -0500
Date: Thu, 1 Feb 2001 21:59:24 +0100
From: Christoph Hellwig <hch@caldera.de>
To: Steve Lord <lord@sgi.com>
Cc: "Stephen C . Tweedie" <sct@redhat.com>, linux-kernel@vger.kernel.org,
        kiobuf-io-devel@lists.sourceforge.net,
        Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [Kiobuf-io-devel] RFC: Kernel mechanism: Compound event wait /notify + callback chains
Message-ID: <20010201215924.A17509@caldera.de>
Mail-Followup-To: Steve Lord <lord@sgi.com>,
	"Stephen C . Tweedie" <sct@redhat.com>,
	linux-kernel@vger.kernel.org, kiobuf-io-devel@lists.sourceforge.net,
	Alan Cox <alan@lxorguk.ukuu.org.uk>
In-Reply-To: <hch@caldera.de> <200102012056.f11Kulp21108@jen.americas.sgi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 1.0i
In-Reply-To: <200102012056.f11Kulp21108@jen.americas.sgi.com>; from lord@sgi.com on Thu, Feb 01, 2001 at 02:56:47PM -0600
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 01, 2001 at 02:56:47PM -0600, Steve Lord wrote:
> And if you are writing to a striped volume via a filesystem which can do
> it's own I/O clustering, e.g. I throw 500 pages at LVM in one go and LVM
> is striped on 64K boundaries.

But usually I want to have pages 0-63, 128-191, etc together, because they are
contingous on disk, or?

	Christoph

-- 
Of course it doesn't work. We've performed a software upgrade.
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
