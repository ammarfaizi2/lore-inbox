Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751155AbWCKMRu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751155AbWCKMRu (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 11 Mar 2006 07:17:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751251AbWCKMRu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 11 Mar 2006 07:17:50 -0500
Received: from s93.xrea.com ([218.216.67.44]:36752 "HELO s93.xrea.com")
	by vger.kernel.org with SMTP id S1751155AbWCKMRu (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 11 Mar 2006 07:17:50 -0500
Message-Id: <200603111217.AA00804@bbb-jz5c7z9hn9y.digitalinfra.co.jp>
From: Jun OKAJIMA <okajima@digitalinfra.co.jp>
Date: Sat, 11 Mar 2006 21:17:25 +0900
To: Nigel Cunningham <ncunningham@cyclades.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Faster resuming of suspend technology.
In-Reply-To: <200603111722.05341.ncunningham@cyclades.com>
References: <200603111722.05341.ncunningham@cyclades.com>
MIME-Version: 1.0
X-Mailer: AL-Mail32 Version 1.13
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


>
>My version doesn't have this problem by default, because it saves a full image 
>of memory unless the user explicitly sets a (soft) upper limit on the image 
>size. The image is stored as contiguously as available storage allows, so 
>rereading it quickly isn't so much of an issue (and far less of an issue than 
>discarding the memory before suspending and faulting it back in from all over 
>the place afterwards).
>

Yes, right. In your way, there is no thrashing. but it slows booting.
I mean, there is a trade-off between booting and after booted.
But, what people would want is always both, not either.
Especially, your way has problem if you boot( resume ) not from HDD
but for example, from NFS server or CD-R or even from Internet.



>
>That said, work has already been done along the lines that you're describing. 
>You might, for example, look at the OLS papers from last year. There was a 
>paper there describing work on almost exactly what you're describing.
>

Could I have URL or title of the paper?

                  --- Okajima, Jun. Tokyo, Japan.


