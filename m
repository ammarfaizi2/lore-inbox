Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261281AbVDYXaQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261281AbVDYXaQ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 25 Apr 2005 19:30:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261280AbVDYXaP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 25 Apr 2005 19:30:15 -0400
Received: from fmr18.intel.com ([134.134.136.17]:33430 "EHLO
	orsfmr003.jf.intel.com") by vger.kernel.org with ESMTP
	id S261229AbVDYX3x (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 25 Apr 2005 19:29:53 -0400
From: "Bob Woodruff" <robert.j.woodruff@intel.com>
To: "'Timur Tabi'" <timur.tabi@ammasso.com>
Cc: "'Andrew Morton'" <akpm@osdl.org>,
       "Davis, Arlin R" <arlin.r.davis@intel.com>, <hch@infradead.org>,
       <linux-kernel@vger.kernel.org>, <openib-general@openib.org>
Subject: RE: [openib-general] Re: [PATCH][RFC][0/4] InfiniBand userspace verbsimplementation
Date: Mon, 25 Apr 2005 16:29:34 -0700
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Office Outlook, Build 11.0.5510
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1441
Thread-Index: AcVJ7FsRX6Xa9QnbQK2LOp5cauySgQAAUMzQ
In-Reply-To: <426D797D.3000108@ammasso.com>
Message-ID: <ORSMSX4081XvpFVjCRG00000015@orsmsx408.amr.corp.intel.com>
X-OriginalArrivalTime: 25 Apr 2005 23:29:34.0588 (UTC) FILETIME=[A39BFBC0:01C549EE]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Timur Tabi wrote,
 
>Any limit would have to be very high - definitely more than just half.
What if the 
>application needs to pin 2GB?  The customer is not going to buy 4+ GB of
RAM just 
>because 
>Linux doesn't like pinning more than half.  In an x86-32 system, that would
required >PAE 
>support and slow everything down.

>Off the top of my head, I'd say Linux would need to allow all but 512MB to
be pinned.  >So 
>you have 3GB of RAM, Linux should allow you to pin 2.5GB.

That is why we made it tunable, so that people could decide how to allow.

There is probably a better way to do it than some hard limit, but 
that would take a little more understanding of the VM system than we had,
and that is why some of the core kernel folks maybe able to help us come up
with a better solution.

woody

