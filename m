Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263159AbUFWW0q@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263159AbUFWW0q (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 23 Jun 2004 18:26:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262370AbUFWWVH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 23 Jun 2004 18:21:07 -0400
Received: from mail2.asahi-net.or.jp ([202.224.39.198]:11898 "EHLO
	mail.asahi-net.or.jp") by vger.kernel.org with ESMTP
	id S261763AbUFWWSv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 23 Jun 2004 18:18:51 -0400
Message-ID: <40DA01C1.2030102@ThinRope.net>
Date: Thu, 24 Jun 2004 07:18:41 +0900
From: Kalin KOZHUHAROV <kalin@ThinRope.net>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6) Gecko/20040121
X-Accept-Language: bg, en, ja, ru, de
MIME-Version: 1.0
To: David Eger <eger@havoc.gtf.org>
Cc: LKML <linux-kernel@vger.kernel.org>
Subject: Re: Alphabet of kernel source
References: <20040623140628.3f1abfe9@lembas.zaitcev.lan> <20040623214653.GA29728@havoc.gtf.org>
In-Reply-To: <20040623214653.GA29728@havoc.gtf.org>
X-Enigmail-Version: 0.83.0.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

David Eger wrote:
> I started a thread a while ago (2.6.3/2.6.4) where I submitted some
> patches to UTF-8ifying the kernel sources.  Basically, most of the
> kernel is ASCII (98.4% of the files).  The rest are mostly ISO-Latin-1,
> with the rare bit of Japanese (in a couple of charsets) and some just
> random bytes in some of the Documentation/...

The "problem" is contributor names, although having everything in plain ASCII is resonable, I guess.

> http://www.yak.net/random/linux-2.6.4-utf8-cleanup-auto.diff
A lot of names and some art supposed to be ASCII.

> http://www.yak.net/random/linux-2.6.4-utf8-cleanup-cstrings2utf8.diff
Some degree symbols and microseconds... and names.
I remember having problems with lm-sensors trying to print degrees, how did they fight the problem?

> http://www.yak.net/random/linux-2.6.4-utf8-cleanup-jp.diff
Ok, this Japanese is only in the comments.
I can translate that in no time and fix this diff.
WTF is arch/v850/ ?
I guess you had some kind of script, can you try it on vanilla 2.6.7, plesae, and post results.

> http://www.yak.net/random/linux-2.6.4-utf8-cleanup-wrong.diff
There are a few microseconds written properly, but may commonly by typed as us, or just don't use abbr.

> It's sorta difficult to do non-ASCII patches over email because
> the kernel developers like reading their mail in mutt, and don't 
> like attachments (the only sane ways to send non 7-bit clean data:
> 8-bit MIME: tagged and bagged or uuencoded)
> 
> Further, you confuse the hell out of vi if you have any trash (8bit data
> in another charset) in a file that's supposed to be UTF-8.  i.e. don't
> think you're going to be able to look at a charset changing patch in
> anything.
Totally agree, although I use Mozilla Mail (and sometimes mutt).

Kalin.

-- 
||///_ o  *****************************
||//'_/>     WWW: http://ThinRope.net/
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
