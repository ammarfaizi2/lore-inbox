Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265604AbUBGOBd (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 7 Feb 2004 09:01:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265657AbUBGOBd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 7 Feb 2004 09:01:33 -0500
Received: from phoenix.infradead.org ([213.86.99.234]:5907 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id S265604AbUBGOBb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 7 Feb 2004 09:01:31 -0500
Date: Sat, 7 Feb 2004 14:01:24 +0000
From: Christoph Hellwig <hch@infradead.org>
To: John Ogness <jogness@antivir.de>
Cc: Dave Jones <davej@redhat.com>, Michael Clark <michael@metaparadigm.com>,
       linux-kernel@vger.kernel.org
Subject: Re: File change notification
Message-ID: <20040207140124.A29298@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	John Ogness <jogness@antivir.de>, Dave Jones <davej@redhat.com>,
	Michael Clark <michael@metaparadigm.com>,
	linux-kernel@vger.kernel.org
References: <4024A1D8.9060700@antivir.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <4024A1D8.9060700@antivir.de>; from jogness@antivir.de on Sat, Feb 07, 2004 at 09:29:12AM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Feb 07, 2004 at 09:29:12AM +0100, John Ogness wrote:
> I am the current maintainer of Dazuko. Could you please explain your 
> "wackiest 2004" comment? Do you know of a better way to intercept system 
> calls for 2.2/2.4 kernels *without* patching the kernel source?

better implies it's good - it isn't.  In fact it's plain wrong for any
kernel.  Do a stackable filesystem if you want to intercept filesystem
calls.

