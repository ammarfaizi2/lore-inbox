Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161184AbWAHLFs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161184AbWAHLFs (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 8 Jan 2006 06:05:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161185AbWAHLFs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 8 Jan 2006 06:05:48 -0500
Received: from relay02.mail-hub.dodo.com.au ([202.136.32.45]:57812 "EHLO
	relay02.mail-hub.dodo.com.au") by vger.kernel.org with ESMTP
	id S1161184AbWAHLFr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 8 Jan 2006 06:05:47 -0500
From: Grant Coady <gcoady@gmail.com>
To: Willy Tarreau <willy@w.ods.org>
Cc: Markus Rechberger <mrechberger@gmail.com>, linux-kernel@vger.kernel.org
Subject: Re: Why is 2.4.32 four times faster than 2.6.14.6??
Date: Sun, 08 Jan 2006 22:05:43 +1100
Organization: http://bugsplatter.mine.nu/
Reply-To: gcoady@gmail.com
Message-ID: <eto1s19q78qg34o5uq37o46t30f3adfn0q@4ax.com>
References: <l6b1s152vo49j7dmthvbhoqej1modrs2k7@4ax.com> <d9def9db0601072258v39ac4334kccc843838b436bba@mail.gmail.com> <gre1s1lkr687o2npgom26gqq3etgjdjgpo@4ax.com> <20060108095741.GH7142@w.ods.org>
In-Reply-To: <20060108095741.GH7142@w.ods.org>
X-Mailer: Forte Agent 2.0/32.652
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 8 Jan 2006 10:57:41 +0100, Willy Tarreau <willy@w.ods.org> wrote:

> Could you please retest :
>  - without the pipe (remove '| cut ...') to avoid inter-process
>    communications

I thought it made a difference, then delay back again, I'll try 
again tomorrow when I'm more awake.

>You should be able to find one simple pattern which makes the problem
>appear/disappear on 2.6. At least, 'cat x.log >/dev/null' should not
>take time or that time should be spent in I/O.

Yes, done that and the time went down by ~five seconds.

More tomorrow my time ;)

-- 
Thanks,
Grant.
http://bugsplatter.mine.nu/
