Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265755AbUBFSzD (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 6 Feb 2004 13:55:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265775AbUBFSzD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 6 Feb 2004 13:55:03 -0500
Received: from main.gmane.org ([80.91.224.249]:18401 "EHLO main.gmane.org")
	by vger.kernel.org with ESMTP id S265755AbUBFSy5 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 6 Feb 2004 13:54:57 -0500
X-Injected-Via-Gmane: http://gmane.org/
To: linux-kernel@vger.kernel.org
From: mru@kth.se (=?iso-8859-1?q?M=E5ns_Rullg=E5rd?=)
Subject: Re: [Infiniband-general] Getting an Infiniband access layer in
 theLinux kernel
Date: Fri, 06 Feb 2004 19:54:55 +0100
Message-ID: <yw1xoescqbr4.fsf@kth.se>
References: <C1B7430B33A4B14F80D29B5126C5E9470326258C@orsmsx401.jf.intel.com> <Pine.LNX.4.53.0402061150100.3862@chaos>
 <52smhounpn.fsf@topspin.com> <Pine.LNX.4.53.0402061258110.4045@chaos>
 <200402061822.i16IMdHJ013686@turing-police.cc.vt.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: 213-187-164-3.dd.nextgentel.com
User-Agent: Gnus/5.1006 (Gnus v5.10.6) XEmacs/21.4 (Rational FORTRAN, linux)
Cancel-Lock: sha1:f00zAxH3ANzLBC8RaTbQ2/PzzMA=
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Valdis.Kletnieks@vt.edu writes:

> On Fri, 06 Feb 2004 13:00:38 EST, "Richard B. Johnson" said:
>
>> Yes you can. You just don't use an ';' if you are going
>> to use 'else'.
>
> You did realize we've changed things from macros to inline functions
> (and vice versa) on occasion?
>
> Yes, you *can* hack around the "problem".  Is there any actual
> evidence that any real performance issues arise from the null
> do/while?  Does said issue outweigh the increased fragility of
> the code?

I suspect that the compiler authors are well aware of this common
idiom and take care to do whatever is appropriate.

-- 
Måns Rullgård
mru@kth.se

