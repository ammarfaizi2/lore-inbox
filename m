Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267428AbSKQBaf>; Sat, 16 Nov 2002 20:30:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267429AbSKQBaf>; Sat, 16 Nov 2002 20:30:35 -0500
Received: from mailout08.sul.t-online.com ([194.25.134.20]:18565 "EHLO
	mailout08.sul.t-online.com") by vger.kernel.org with ESMTP
	id <S267428AbSKQBae>; Sat, 16 Nov 2002 20:30:34 -0500
Cc: linux-kernel@vger.kernel.org, trivial@rustcorp.com.au
References: <87d6p63ui2.fsf@goat.bogus.local>
	<20021117000806.GB443@tapu.f00f.org>
From: Olaf Dietsche <olaf.dietsche#list.linux-kernel@t-online.de>
To: Chris Wedgwood <cw@f00f.org>
Subject: Re: [PATCH] 2.5.47: strdup()
Date: Sun, 17 Nov 2002 02:37:27 +0100
Message-ID: <873cq1nfhk.fsf@goat.bogus.local>
User-Agent: Gnus/5.090005 (Oort Gnus v0.05) XEmacs/21.4 (Honest Recruiter,
 i386-debian-linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Chris Wedgwood <cw@f00f.org> writes:

> On Sat, Nov 16, 2002 at 07:21:09AM +0100, Olaf Dietsche wrote:
>
>> This *untested* patch adds strdup(). There are about five or six
>> different strdup() implementations in various parts of the kernel.
>
> How many users of these functions are there?  I really don't like
> certain functions which allocate memory in nebulous ways and almost
> would prefer all users of this are fixed to specifically allocate and
> str[n]cpy copy themselves making it clear who is allocating memory and
> also who should free it.

So you like duplicate code? Well, to each his own.

Regards, Olaf.
