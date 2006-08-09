Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965087AbWHIGwx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965087AbWHIGwx (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 9 Aug 2006 02:52:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965085AbWHIGww
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 9 Aug 2006 02:52:52 -0400
Received: from mailer.gwdg.de ([134.76.10.26]:34200 "EHLO mailer.gwdg.de")
	by vger.kernel.org with ESMTP id S965086AbWHIGww (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 9 Aug 2006 02:52:52 -0400
Date: Wed, 9 Aug 2006 08:47:17 +0200 (MEST)
From: Jan Engelhardt <jengelh@linux01.gwdg.de>
To: Lee Revell <rlrevell@joe-job.com>
cc: Willy Tarreau <w@1wt.eu>, Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Andi Kleen <ak@suse.de>, Alexey Zaytsev <alexey.zaytsev@gmail.com>,
       linux-kernel@vger.kernel.org, matti.aarnio@zmailer.org
Subject: Re: Time to forbid non-subscribers from posting to the list?
In-Reply-To: <1155068717.26338.100.camel@mindpipe>
Message-ID: <Pine.LNX.4.61.0608090842040.11585@yvahk01.tjqt.qr>
References: <f19298770608080407n5788faa8x779ad84fe53726cb@mail.gmail.com> 
 <p73y7tzo4hl.fsf@verdi.suse.de>  <1155047956.5729.68.camel@localhost.localdomain>
  <20060808191631.GF8776@1wt.eu> <1155068717.26338.100.camel@mindpipe>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Spam-Report: Content analysis: 0.0 points, 6.0 required
	_SUMMARY_
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>> > Tag subject lines from non subscribes with [nonsub] and everyone can
>> > then decide for themselves.
>> 
>> This looks like a very clever yet simple idea (if easy to implement at all) !
>> While I have no anti-spam and am not annoyed at all by the low spam rate on
>> LKML, I think this would make my cleaning operations even more effective.

+1


>That would mean 8 fewer characters of useful information visible in the
>subject line.

For those who use a graphical client this should not be a problem, pixels 
are plenty. For 80x25 readers, well, I can only suggest to use an index 
listing optimized to your needs. For example, the default pine listing 
left too few space for the subject for me on LKML, so I changed it to be 
like

(index-format=MSGNO STATUS SUBJECT FROM SMARTTIME SIZENARROW)

314   D   | | |-Re: Time to forbid non-subscri Andi Kleen          Tue02pm  (3K)
315     . | |-Re: Time to forbid non-subscribe Alan Cox            Tue03pm  (3K)
316     . |   |-Re: Time to forbid non-subscri Willy Tarreau       Tue09pm  (3K)
317     . |     |-Re: Time to forbid non-subsc Lee Revell          Tue04pm  (3K)
318       |       |-Re: Time to forbid non-sub Kyle Moffett        Tue05pm  (3K)
319   N   |-Re: Time to forbid non-subscribers David Miller        Tue03pm  (2K)

Since a lot of mails are already prefixed with something [], like [PATCH], 
I do not really mind if there's [nonsub], or if you like to keep it short, 
you can make that [NSUB], and it even outperforms [PATCH] wrt. length.

Then it would only take the key sequence ;ts[NSUB]<Enter>adx to kill all 
the nonsub messages. However, I would also be fine with an extra header in 
the mail header saying "this comes from a non-subscriber", the key seq in 
pine would be slightly bigger though, 
";thMajordomo-Info<Enter>nonsub<Enter>adx".


Jan Engelhardt
-- 
