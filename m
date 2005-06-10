Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261206AbVFJUTY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261206AbVFJUTY (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 10 Jun 2005 16:19:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261207AbVFJUTY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 10 Jun 2005 16:19:24 -0400
Received: from hermine.aitel.hist.no ([158.38.50.15]:15621 "HELO
	hermine.aitel.hist.no") by vger.kernel.org with SMTP
	id S261206AbVFJUTV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 10 Jun 2005 16:19:21 -0400
Date: Fri, 10 Jun 2005 22:25:15 +0200
To: Takashi Ikebe <ikebe.takashi@lab.ntt.co.jp>
Cc: Andrew Morton <akpm@osdl.org>, axboe@suse.de, andrea@suse.de,
       linux-kernel@vger.kernel.org
Subject: Re: Real-time problem due to IO congestion.
Message-ID: <20050610202515.GA21733@hh.idb.hist.no>
References: <42A91D36.8090506@lab.ntt.co.jp> <20050609234231.42a10763.akpm@osdl.org> <42A93D85.4060005@lab.ntt.co.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <42A93D85.4060005@lab.ntt.co.jp>
User-Agent: Mutt/1.5.9i
From: Helge Hafting <helgehaf@aitel.hist.no>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 10, 2005 at 04:13:09PM +0900, Takashi Ikebe wrote:
> 
> I see.
> The program which I tested is just sample, and I wanted to know the 
> phenomena is spec or bug.
> I also understand that this problem is spec, and need to apply some 
> buffering to such applications.
> 
There is an alternative.  Get a separate disk just for the RT-job.
You can then run your very heavy IO on other disks, the RT disk won't
be delayed by that.

Helge Hafting
