Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266335AbUA2Uwg (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 29 Jan 2004 15:52:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266348AbUA2Uwg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 29 Jan 2004 15:52:36 -0500
Received: from mail46-s.fg.online.no ([148.122.161.46]:57000 "EHLO
	mail46-s.fg.online.no") by vger.kernel.org with ESMTP
	id S266335AbUA2Uwe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 29 Jan 2004 15:52:34 -0500
To: linux-kernel@vger.kernel.org
Subject: Re: Lindent fixed to match reality
References: <20040129193727.GJ21888@waste.org>
	<20040129201556.GK16675@khan.acc.umu.se> <yw1xr7xi1ojs.fsf@kth.se>
	<20040129204250.GL16675@khan.acc.umu.se>
From: mru@kth.se (=?iso-8859-1?q?M=E5ns_Rullg=E5rd?=)
Date: Thu, 29 Jan 2004 21:52:12 +0100
In-Reply-To: <20040129204250.GL16675@khan.acc.umu.se> (David Weinehall's
 message of "Thu, 29 Jan 2004 21:42:50 +0100")
Message-ID: <yw1xn0861nr7.fsf@kth.se>
User-Agent: Gnus/5.1002 (Gnus v5.10.2) XEmacs/21.4 (Rational FORTRAN, linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

David Weinehall <tao@acc.umu.se> writes:

> On Thu, Jan 29, 2004 at 09:35:03PM +0100, Måns Rullgård wrote:
>> David Weinehall <tao@acc.umu.se> writes:
>> 
>> >> b) (no -bs) "sizeof(foo)" rather than "sizeof (foo)"
>> >
>> > I can't really see the logic in this, though I know a lot of people do
>> > it.  I try to stay consistent, thus I do:
>> >
>> > if ()
>> > for ()
>> > case ()
>> > while ()
>> > sizeof ()
>> > typeof ()
>> >
>> > since they're all parts of the language, rather than
>> > functions/macros or invocations of such.
>> 
>> What I fail to see here is why that should make a difference regarding
>> whitespace before the parens.
>
> All I'm trying to say, is that we should be consistent; most code
> has:
>
> if (), for (), case (), while ()
>
> (and possibly sizeof foo, typeof foo)
>
> but
>
> sizeof(foo), typeof(foo)
>
> which is what I dislike (consistancy is good.)

Well, those have function-like semantics in that they have a value,
unlike an if statement.  That could possibly explain the difference.
I know perfectly well that sizeof is not a function, so don't bother
explaining that.

-- 
Måns Rullgård
mru@kth.se
