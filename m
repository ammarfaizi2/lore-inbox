Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S275070AbTHLHGg (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 12 Aug 2003 03:06:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S275074AbTHLHGg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 12 Aug 2003 03:06:36 -0400
Received: from pub234.cambridge.redhat.com ([213.86.99.234]:7175 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id S275070AbTHLHGf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 12 Aug 2003 03:06:35 -0400
Date: Tue, 12 Aug 2003 08:06:34 +0100
From: Christoph Hellwig <hch@infradead.org>
To: Adrian Bunk <bunk@fs.tum.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [2.6 patch] add an -Os config option
Message-ID: <20030812080634.A19427@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Adrian Bunk <bunk@fs.tum.de>, linux-kernel@vger.kernel.org
References: <20030811211145.GA569@fs.tum.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20030811211145.GA569@fs.tum.de>; from bunk@fs.tum.de on Mon, Aug 11, 2003 at 11:11:45PM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 11, 2003 at 11:11:45PM +0200, Adrian Bunk wrote:
> The patch below adds an option OPTIMIZE_FOR_SIZE (depending on EMBEDDED) 
> that changes the optimization from -O2 to -Os.

Please dropt the if EMBEDDED - this makes perfecty sense for lots of
todays hardware..

In fact we should probably rather do some some benchmarking whether it
would be a good idea to make -Os the default.
