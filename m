Return-Path: <linux-kernel-owner+w=401wt.eu-S1754550AbWLYXHL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754550AbWLYXHL (ORCPT <rfc822;w@1wt.eu>);
	Mon, 25 Dec 2006 18:07:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754573AbWLYXHL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 25 Dec 2006 18:07:11 -0500
Received: from pat.uio.no ([129.240.10.15]:51246 "EHLO pat.uio.no"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754550AbWLYXHJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 25 Dec 2006 18:07:09 -0500
Subject: Re: Linux 2.6.20-rc2
From: Trond Myklebust <trond.myklebust@fys.uio.no>
To: Florin Iucha <florin@iucha.net>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <20061225225616.GA22307@iucha.net>
References: <20061225224047.GB6087@iucha.net>
	 <20061225225616.GA22307@iucha.net>
Content-Type: text/plain
Date: Tue, 26 Dec 2006 00:06:58 +0100
Message-Id: <1167088018.16449.16.camel@lade.trondhjem.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.8.1 
Content-Transfer-Encoding: 7bit
X-UiO-Spam-info: not spam, SpamAssassin (score=-5.0, required=12.0, autolearn=no, UIO_MAIL_IS_INTERNAL=-5)
X-UiO-Scanned: D0BC1528DC5AFBE0E6A529295753F7DC85D634F2
X-UiO-SPAM-Test: 83.109.147.16 spam_score -49 maxlevel 200 minaction 2 bait 0 blacklist 0 greylist 0 ratelimit 0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2006-12-25 at 16:56 -0600, Florin Iucha wrote:
> > The dmesg from the client machine is attached.
> 
> Now, really.
> 
> BTW, I am using NFSv4 exported async from the server and mounted
> without any extra options on the client.
> 
> florin

Doesn't look like it has much to do with NFS. The Oopses appear mainly
to be occurring when assorted ext3 code calls submit_bio(). Was that the
entire Oops text?

Cheers
  Trond

