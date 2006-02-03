Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751270AbWBCRly@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751270AbWBCRly (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 3 Feb 2006 12:41:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751242AbWBCRly
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 3 Feb 2006 12:41:54 -0500
Received: from [193.113.235.183] ([193.113.235.183]:63788 "EHLO
	out.lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP
	id S1751270AbWBCRlx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 3 Feb 2006 12:41:53 -0500
Subject: Re: [RFC] VM: I have a dream...
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Al Boldi <a1426z@gawab.com>
Cc: Kyle Moffett <mrmacman_g4@mac.com>, Bryan Henderson <hbryan@us.ibm.com>,
       linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <200602022159.04508.a1426z@gawab.com>
References: <OFA0FDB57C.2E4B1B4D-ON88257103.00688AE2-88257103.0069EF1C@us.ibm.com>
	 <200601311856.17569.a1426z@gawab.com>
	 <1138893090.9861.25.camel@localhost.localdomain>
	 <200602022159.04508.a1426z@gawab.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Fri, 03 Feb 2006 14:46:05 +0000
Message-Id: <1138977966.2765.1.camel@localhost>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Iau, 2006-02-02 at 21:59 +0300, Al Boldi wrote:
> So w/ 1GB RAM, no swap, and 1TB disk mmap'd, could this mmap'd space be added 
> to the total memory available to the OS, as is done w/ swap?

Yes in theory. It would be harder to manage.

> And if that's possible, why not replace swap w/ mmap'd disk-space?

Swap is just somewhere to stick data that isnt file backed, you could
build a swapless mmap based OS but it wouldn't be quite the same as
Unix/Linux are.

