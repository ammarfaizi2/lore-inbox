Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268000AbUJJBIu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268000AbUJJBIu (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 9 Oct 2004 21:08:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267998AbUJJBIu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 9 Oct 2004 21:08:50 -0400
Received: from main.gmane.org ([80.91.229.2]:43498 "EHLO main.gmane.org")
	by vger.kernel.org with ESMTP id S268005AbUJJBIb (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 9 Oct 2004 21:08:31 -0400
X-Injected-Via-Gmane: http://gmane.org/
To: linux-kernel@vger.kernel.org
From: =?iso-8859-1?q?M=E5ns_Rullg=E5rd?= <mru@mru.ath.cx>
Subject: Re: [ANNOUNCE] Linux 2.6 Real Time Kernel
Date: Sun, 10 Oct 2004 03:08:15 +0200
Message-ID: <yw1x7jpz8jnk.fsf@mru.ath.cx>
References: <41677E4D.1030403@mvista.com> <yw1xk6u0hw2m.fsf@mru.ath.cx>
 <1097356829.1363.7.camel@krustophenia.net> <yw1xis9ja82z.fsf@mru.ath.cx>
 <20041010004316.GK3165@luna.mooo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: 197.80-202-92.nextgentel.com
User-Agent: Gnus/5.1006 (Gnus v5.10.6) XEmacs/21.4 (Security Through
 Obscurity, linux)
Cancel-Lock: sha1:VBzj9g0gAznEOIwfjqQTWCmUM2Y=
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Micha Feigin <michf@post.tau.ac.il> writes:

> On Sat, Oct 09, 2004 at 11:35:16PM +0200, M?ns Rullg?rd wrote:
>> Lee Revell <rlrevell@joe-job.com> writes:
>> 
>> > On Sat, 2004-10-09 at 09:15, M?ns Rullg?rd wrote:
>> >> I got this thing to build by adding a few EXPORT_SYMBOL, patch below.
>> >> Now it seems to be running quite well.  I am, however, getting
>> >> occasional "bad: scheduling while atomic!" messages, all alike:
>> >> 
>> >
>> > I am getting the same message.   Also, leaving all the default debug
>> > options on, I got this debug output, but it did not coincide with the
>> > "bad" messages.
>> >
>> > Mtx: dd84e644 [773] pri (0) inherit from [3] pri(92)
>> > Mtx dd84e644 task [773] pri (92) restored pri(0). Next owner [3] pri (92)
>> > Mtx: dd84e644 [773] pri (0) inherit from [3] pri(92)
>> > Mtx dd84e644 task [773] pri (92) restored pri(0). Next owner [3] pri (92)
>> > Mtx: dd84e644 [773] pri (0) inherit from [3] pri(92)
>> > Mtx dd84e644 task [773] pri (92) restored pri(0). Next owner [3] pri (92)
>> 
>> Well, those don't give me any clues.
>> 
>> I had the system running that kernel for a bit over an hour and got
>> five of the "bad" messages, approximately evenly spaced in a
>> two-minute interval about 20 minutes after boot.
>> 
>> I did notice one improvement compared to vanilla 2.6.8.1.  The sound
>> didn't skip when I switched from X to a text console.  However, my
>> keyboard no longer worked in X, but that seems to be due to some
>> recent changes to the input subsystem.
>
> There was some change in 2.6.9-pre-something that cause the mouse and
> keyboard to exchange event interfaces between them, if it interests you.

The keyboard doesn't have a device entry in my X config file, and I
suppose the mouse would still be at /dev/input/mice, no?

-- 
Måns Rullgård
mru@mru.ath.cx

