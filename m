Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263490AbTDSWuo (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 19 Apr 2003 18:50:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263494AbTDSWuo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 19 Apr 2003 18:50:44 -0400
Received: from pc2-cwma1-4-cust86.swan.cable.ntl.com ([213.105.254.86]:60880
	"EHLO lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP
	id S263490AbTDSWum (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 19 Apr 2003 18:50:42 -0400
Subject: Re: Are linux-fs's drive-fault-tolerant by concept?
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Stephan von Krawczynski <skraw@ithnet.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <20030419190046.6566ed18.skraw@ithnet.com>
References: <20030419180421.0f59e75b.skraw@ithnet.com>
	 <1050766175.3694.4.camel@dhcp22.swansea.linux.org.uk>
	 <20030419190046.6566ed18.skraw@ithnet.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Organization: 
Message-Id: <1050789876.3961.22.camel@dhcp22.swansea.linux.org.uk>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 (1.2.2-5) 
Date: 19 Apr 2003 23:04:36 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sad, 2003-04-19 at 18:00, Stephan von Krawczynski wrote:
> Ok, you mean active error-recovery on reading. My basic point is the writing
> case. A simple handling of write-errors from the drivers level and a retry to
> write on a different location could help a lot I guess.

It would make no difference. The IDE drive firmware already knows about
such things.

> Just to give some numbers: from 25 disk I bought during last half year 16 have
> gone dead within the first month. This is ridiculous. Of course they are all
> returned and guarantee-replaced, but it gets on ones nerves to continously
> replace disks, the rate could be lowered if one could use them at least 4
> months (or upto a deadline number of bad blocks mapped by the fs - still
> guarantee but fewer replacement cycles).

I'd be changing vendors and also looking at my power/heat/vibration for
that level of problems. I'm sure google consider hard disks as a
consumable but not the rest of us 8)

> 
