Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264481AbUBKODe (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 11 Feb 2004 09:03:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265170AbUBKODe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 11 Feb 2004 09:03:34 -0500
Received: from main.gmane.org ([80.91.224.249]:8127 "EHLO main.gmane.org")
	by vger.kernel.org with ESMTP id S264481AbUBKODc (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 11 Feb 2004 09:03:32 -0500
X-Injected-Via-Gmane: http://gmane.org/
To: linux-kernel@vger.kernel.org
From: mru@kth.se (=?iso-8859-1?q?M=E5ns_Rullg=E5rd?=)
Subject: Re: printk and long long
Date: Wed, 11 Feb 2004 15:03:29 +0100
Message-ID: <yw1xy8r9iuha.fsf@kth.se>
References: <Sea2-F7mFkwDjKqc3eQ0001c385@hotmail.com> <1076506513.402a2f9120fb8@webmail.dds.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: 213-187-164-3.dd.nextgentel.com
User-Agent: Gnus/5.1006 (Gnus v5.10.6) XEmacs/21.4 (Rational FORTRAN, linux)
Cancel-Lock: sha1:jjZl7vwcB0scJ2OfyxceeHeT0C4=
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

wdebruij@dds.nl writes:

> how about simply using a shift to output two regular longs, i.e.
>
> printk("%ld%ld",loff_t >> (sizeof(long) * 8), loff_t << sizeof(long) * 8 >>
> sizeof(long) * 8);

And how do you plan to make sense of the printed value?

-- 
Måns Rullgård
mru@kth.se

