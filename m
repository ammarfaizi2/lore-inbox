Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262085AbUB2Rc7 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 29 Feb 2004 12:32:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262084AbUB2Rc7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 29 Feb 2004 12:32:59 -0500
Received: from main.gmane.org ([80.91.224.249]:12980 "EHLO main.gmane.org")
	by vger.kernel.org with ESMTP id S262085AbUB2RcZ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 29 Feb 2004 12:32:25 -0500
X-Injected-Via-Gmane: http://gmane.org/
To: linux-kernel@vger.kernel.org
From: mru@kth.se (=?iso-8859-1?q?M=E5ns_Rullg=E5rd?=)
Subject: Re: Dropping CONFIG_PM_DISK?
Date: Sun, 29 Feb 2004 18:32:21 +0100
Message-ID: <yw1x4qt93i6y.fsf@kth.se>
References: <1ulUA-33w-3@gated-at.bofh.it> <20040229161721.GA16688@hell.org.pl>
 <20040229162317.GC283@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: ti211310a080-4136.bb.online.no
User-Agent: Gnus/5.1006 (Gnus v5.10.6) XEmacs/21.4 (Security Through
 Obscurity, linux)
Cancel-Lock: sha1:MS5LE5xwK87fk1D3hnbdbotrpnA=
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Pavel Machek <pavel@ucw.cz> writes:

> Hi!
>
>> > Would there be any major screaming if I tried to drop CONFIG_PM_DISK?
>> > It seems noone is maintaining it, equivalent functionality is provided
>> > by swsusp, and it is confusing users...
>> 
>> It may be ugly, it may be unmaintained, but I get the impression that it
>> works for some people for whom swsusp doesn't. So unless swsusp works for
>> everyone or Nigel's swsusp2 is merged, I'd suggest leaving that in.
>
> Do you have example when pmdisk works and swsusp does not? I'm not
> aware of any in recent history...

For me, none of them (pmdisk, swsusp and swsusp2) work.  I did manage
to get pmdisk to resume once, and swsusp2 makes it half-way through
the resume.  The old swsusp doesn't even get that far.

-- 
Måns Rullgård
mru@kth.se

