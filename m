Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751394AbWAaTX7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751394AbWAaTX7 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 31 Jan 2006 14:23:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751401AbWAaTX7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 31 Jan 2006 14:23:59 -0500
Received: from mail.shareable.org ([81.29.64.88]:25291 "EHLO
	mail.shareable.org") by vger.kernel.org with ESMTP id S1751319AbWAaTX6
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 31 Jan 2006 14:23:58 -0500
Date: Tue, 31 Jan 2006 19:23:35 +0000
From: Jamie Lokier <jamie@shareable.org>
To: Al Boldi <a1426z@gawab.com>
Cc: Kyle Moffett <mrmacman_g4@mac.com>, Bryan Henderson <hbryan@us.ibm.com>,
       linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [RFC] VM: I have a dream...
Message-ID: <20060131192335.GA28323@mail.shareable.org>
References: <OFA0FDB57C.2E4B1B4D-ON88257103.00688AE2-88257103.0069EF1C@us.ibm.com> <200601301621.24051.a1426z@gawab.com> <8F530CA8-1AC8-4AE5-8F1E-DC6518BD7D42@mac.com> <200601311856.17569.a1426z@gawab.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200601311856.17569.a1426z@gawab.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Al Boldi wrote:
> There is a lot to gain, for one there is no more swapping w/ all its related 
> side-effects.  You're dealing with memory only.

I'm sorry, I think I don't understand.  My weakness.  Can you please explain?

Presumably you will want access to more data than you have RAM,
because RAM is still limited to a few GB these days, whereas a typical
personal data store is a few 100s of GB.

64-bit architecture doesn't change this mismatch.  So how do you
propose to avoid swapping to/from a disk, with all the time delays and
I/O scheduling algorithms that needs?

-- Jamie
