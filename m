Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268899AbUHLXRm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268899AbUHLXRm (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 12 Aug 2004 19:17:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268888AbUHLXQu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 12 Aug 2004 19:16:50 -0400
Received: from mail.broadpark.no ([217.13.4.2]:13490 "EHLO mail.broadpark.no")
	by vger.kernel.org with ESMTP id S268880AbUHLXKx convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 12 Aug 2004 19:10:53 -0400
To: Bill Davidsen <davidsen@tmr.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: PATCH: cdrecord: avoiding scsi device numbering for ide devices
References: <1092124796.1438.3695.camel@imladris.demon.co.uk>
	<yw1x7js79vn3.fsf@kth.se> <411BF1E6.5060309@tmr.com>
From: =?iso-8859-1?q?M=E5ns_Rullg=E5rd?= <mru@kth.se>
Date: Fri, 13 Aug 2004 01:10:53 +0200
In-Reply-To: <411BF1E6.5060309@tmr.com> (Bill Davidsen's message of "Thu, 12
 Aug 2004 18:40:38 -0400")
Message-ID: <yw1xpt5wgdfm.fsf@kth.se>
User-Agent: Gnus/5.1006 (Gnus v5.10.6) XEmacs/21.4 (Security Through
 Obscurity, linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Bill Davidsen <davidsen@tmr.com> writes:

> Måns Rullgård wrote:
>> David Woodhouse <dwmw2@infradead.org> writes:
>
>>>That seems reasonable, but _only_ if burnfree is not enabled. If the
>>>hardware _supports_ burnfree but it's disabled, the warning should also
>>>recommend turning it on.
>> I'm also wondering why cdrecord disables it by default.  Can it ever
>> do any harm being enabled?
>>
>
> In theory, yes. It makes the track longer, so it could in theory make
> something large not fit. In practice, there really are some readers
> which skip on audio when they see the blanks. As Joerg which ones, but
> other people have agreed that it does happen.

As has been pointed out by others, the alternative is a wasted disk.
Even if the quality is degraded slightly where burnfree kicks in, the
disk may still be suitable for its intended use.  CDs are often used
for moving some data to another machine and discarded after a single
use.  In these cases, a lower resistance to scratches is not a
problem.  For long-term storage the situation could of course be
different.

-- 
Måns Rullgård
mru@kth.se
