Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281047AbRKCWCx>; Sat, 3 Nov 2001 17:02:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281048AbRKCWCn>; Sat, 3 Nov 2001 17:02:43 -0500
Received: from [208.129.208.52] ([208.129.208.52]:51719 "EHLO xmailserver.org")
	by vger.kernel.org with ESMTP id <S281047AbRKCWC1>;
	Sat, 3 Nov 2001 17:02:27 -0500
Date: Sat, 3 Nov 2001 14:10:20 -0800 (PST)
From: Davide Libenzi <davidel@xmailserver.org>
X-X-Sender: davide@blue1.dev.mcafeelabs.com
To: Hubertus Franke <frankeh@watson.ibm.com>
cc: Mike Kravetz <kravetz@us.ibm.com>, lkml <linux-kernel@vger.kernel.org>,
        <lse-tech@lists.sourceforge.net>
Subject: Re: [Lse-tech] Re: [PATCH][RFC] Proposal For A More Scalable Scheduler
 ...
In-Reply-To: <20011102072036.D17792@watson.ibm.com>
Message-ID: <Pine.LNX.4.40.0111031408360.1550-100000@blue1.dev.mcafeelabs.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2 Nov 2001, Hubertus Franke wrote:

> One more. Throughout our MQ evaluation, it was also true that
> the overall performance particularly for large thread counts was
> very sensitive to the goodness function, that why a na_goodness_local
> was introduced.

Yes it is, but the real question is - It is better a save a few clock
cycles in goodness() or achieve a better process scheduling decisions ?



- Davide


