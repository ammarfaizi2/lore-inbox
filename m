Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131720AbRCONrp>; Thu, 15 Mar 2001 08:47:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131718AbRCONrf>; Thu, 15 Mar 2001 08:47:35 -0500
Received: from mx1out.umbc.edu ([130.85.253.51]:57291 "EHLO mx1out.umbc.edu")
	by vger.kernel.org with ESMTP id <S131717AbRCONr0>;
	Thu, 15 Mar 2001 08:47:26 -0500
Date: Thu, 15 Mar 2001 08:46:42 -0500
From: John Jasen <jjasen1@umbc.edu>
X-X-Sender: <jjasen1@irix2.gl.umbc.edu>
To: "Richard B. Johnson" <root@chaos.analogic.com>
cc: Lars Kellogg-Stedman <lars@larsshack.org>,
        Christoph Hellwig <hch@caldera.de>, <linux-kernel@vger.kernel.org>,
        AmNet Computers <amnet@amnet-comp.com>
Subject: Re: magic device renumbering was -- Re: Linux 2.4.2ac20
In-Reply-To: <Pine.LNX.3.95.1010314143853.1825A-100000@chaos.analogic.com>
Message-ID: <Pine.SGI.4.31L.02.0103150841230.44205-100000@irix2.gl.umbc.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 14 Mar 2001, Richard B. Johnson wrote:

> This used to even be the way disks were located by the kernel
> drivers. Now, these are found in some "random" order.
>
> If whatever is causing the "random" order was fixed, put back like
> it used to be, etc., we wouldn't have these problems.

Another alternative to path2inst or a database, I suppose, would be to use
bus/pci slot information (like in /proc/pci?) to order multiple devices, so
at least there's some consistency.

You might have a serious headache, however, when adding a device, under
that scheme.

--
-- John E. Jasen (jjasen1@umbc.edu)
-- In theory, theory and practise are the same. In practise, they aren't.

