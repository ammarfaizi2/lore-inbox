Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263014AbTJUNYX (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 21 Oct 2003 09:24:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263068AbTJUNYX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 21 Oct 2003 09:24:23 -0400
Received: from main.gmane.org ([80.91.224.249]:6333 "EHLO main.gmane.org")
	by vger.kernel.org with ESMTP id S263014AbTJUNYD (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 21 Oct 2003 09:24:03 -0400
X-Injected-Via-Gmane: http://gmane.org/
To: linux-kernel@vger.kernel.org
From: mru@kth.se (=?iso-8859-1?q?M=E5ns_Rullg=E5rd?=)
Subject: Re: [2.6.0-test8] Difference between Software Suspend and
 Suspend-to-disk?
Date: Tue, 21 Oct 2003 15:24:00 +0200
Message-ID: <yw1xptgqd8r3.fsf@kth.se>
References: <200310211315.58585.lkml@kcore.org> <20031021113444.GC9887@louise.pinerecords.com>
 <yw1xy8veddj7.fsf@kth.se>
 <1066741540.2068.1.camel@teapot.felipe-alfaro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
X-Complaints-To: usenet@sea.gmane.org
User-Agent: Gnus/5.1002 (Gnus v5.10.2) XEmacs/21.4 (Rational FORTRAN, linux)
Cancel-Lock: sha1:EuKgpcpbMdeoWxChnxNhtcV6iVE=
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Felipe Alfaro Solana <felipe_alfaro@linuxmail.org> writes:

>> >> Software Suspend (EXPERIMENTAL)
>> >> Suspend-to-Disk Support
>> >
>> > They're competing implementations of the same mechanism.
>> 
>> And neither one works reliably, I might add.  They both appear to save
>> the current state to disk, but no matter what I try, I can't make it
>> resume properly.
>
> Yep! I must say I cannot resume my system from disk. The kernel always
> complains about failing when trying to resume from disk. Also, after
> suspending to disk, the swap partition is completely valid, and I don't
> need to "mkswap" it. On previous releases of the kernel, when STD
> worked, trying to skip resume from disk left the swap partition unusable
> (as expected after dumping memory to the swap file).

Same here.  I recall seeing a patch that did something to sync the
disks before powering off.  Maybe it's related.  I'll dig out the
patch and see what it's all about.

-- 
Måns Rullgård
mru@kth.se

