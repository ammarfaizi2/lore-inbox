Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030589AbVLWRp3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030589AbVLWRp3 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 23 Dec 2005 12:45:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030581AbVLWRp3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 23 Dec 2005 12:45:29 -0500
Received: from mail.metronet.co.uk ([213.162.97.75]:9709 "EHLO
	mail.metronet.co.uk") by vger.kernel.org with ESMTP
	id S1030589AbVLWRp3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 23 Dec 2005 12:45:29 -0500
From: Alistair John Strachan <s0348365@sms.ed.ac.uk>
To: gcoady@gmail.com
Subject: Re: 4k stacks
Date: Fri, 23 Dec 2005 17:45:41 +0000
User-Agent: KMail/1.9
Cc: "linux-os (Dick Johnson)" <linux-os@analogic.com>,
       "Linux kernel" <linux-kernel@vger.kernel.org>
References: <Pine.LNX.4.61.0512221640490.8179@chaos.analogic.com> <pfjmq1dtcrq5hos687h0gm9nrg79v3ceat@4ax.com>
In-Reply-To: <pfjmq1dtcrq5hos687h0gm9nrg79v3ceat@4ax.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200512231745.41400.s0348365@sms.ed.ac.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday 23 December 2005 01:11, Grant Coady wrote:
> On Thu, 22 Dec 2005 16:53:25 -0500, "linux-os \(Dick Johnson\)" 
<linux-os@analogic.com> wrote:
> >Yesterday I sent a patch to add stack-poison so the stack usage
> >could be observed.
> >
> >Today I wrote a small program and tested the stack usage. Both
> >the program and the patch is attached. The result is:
> >
> >Offset : 2ec8f000	Available Stack bytes = 3104
> >Offset : 2ecb1000	Available Stack bytes = 3104
> >Offset : 2ee5f000	Available Stack bytes = 20
>
> Hmm:
> # ./stack
> Offset : 003fb000       Available Stack bytes = 3348
> Offset : 0195d000       Available Stack bytes = 3620

Please do these tests once you repair the bug preventing the 4K stacks kernel 
from booting. The results are meaningless on an 8K stacks kernel.

-- 
Cheers,
Alistair.

'No sense being pessimistic, it probably wouldn't work anyway.'
Third year Computer Science undergraduate.
1F2 55 South Clerk Street, Edinburgh, UK.
