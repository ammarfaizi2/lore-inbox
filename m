Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261914AbTLHUPY (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 8 Dec 2003 15:15:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261928AbTLHUPY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 8 Dec 2003 15:15:24 -0500
Received: from head.linpro.no ([80.232.36.1]:21217 "EHLO head.linpro.no")
	by vger.kernel.org with ESMTP id S261914AbTLHUPV (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 8 Dec 2003 15:15:21 -0500
To: William Lee Irwin III <wli@holomorphy.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.4: mylex and > 2GB RAM
References: <1070897058.25490.56.camel@netstat.linpro.no>
	<20031208153641.GJ8039@holomorphy.com>
	<1070898870.25490.76.camel@netstat.linpro.no>
	<20031208162214.GW19856@holomorphy.com>
From: Per Andreas Buer <perbu@linpro.no>
Organization: Linpro AS
Date: Mon, 08 Dec 2003 21:15:15 +0100
In-Reply-To: <20031208162214.GW19856@holomorphy.com> (William Lee Irwin,
 III's message of "Mon, 8 Dec 2003 08:22:14 -0800")
Message-ID: <PERBUMSGID-ul6d6azt6b0.fsf@nfsd.linpro.no>
User-Agent: Gnus/5.1002 (Gnus v5.10.2) Emacs/21.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Spam-Score: -4.9 (----)
X-Scanner: exiscan for exim4 (http://duncanthrax.net/exiscan/) *1ATRml-0007Zx-Iv*zo9TD80oaEA*
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

William Lee Irwin III <wli@holomorphy.com> writes:

> If your memory ended at 2GB and the driver had 31-bit DMA, it may have
> decided to use unconstrained allocations. Then, when you added more RAM,
> it was forced to ask for <= 896MB, which made it copy to buffers that are
> actually below 896MB most of the time.

But this would reduce the throuput only a few percent, right? My system
slows down from writing ~ 100MB/s to maybe 50KB/s. 

-- 
Per Andreas Buer
