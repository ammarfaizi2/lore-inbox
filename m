Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263135AbTKYUJc (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 25 Nov 2003 15:09:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263064AbTKYUJc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 25 Nov 2003 15:09:32 -0500
Received: from main.gmane.org ([80.91.224.249]:51592 "EHLO main.gmane.org")
	by vger.kernel.org with ESMTP id S263135AbTKYUJa (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 25 Nov 2003 15:09:30 -0500
X-Injected-Via-Gmane: http://gmane.org/
To: linux-kernel@vger.kernel.org
From: mru@kth.se (=?iso-8859-1?q?M=E5ns_Rullg=E5rd?=)
Subject: Re: 2.6.0-preX causes memory corruption
Date: Tue, 25 Nov 2003 21:09:28 +0100
Message-ID: <yw1x7k1ojjlz.fsf@kth.se>
References: <1069789556.2115.16.camel@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
X-Complaints-To: usenet@sea.gmane.org
User-Agent: Gnus/5.1002 (Gnus v5.10.2) XEmacs/21.4 (Rational FORTRAN, linux)
Cancel-Lock: sha1:2pGyQluCL8z2ZzZGRalv+Kzoif4=
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ali Akcaagac <aliakc@web.de> writes:

> After installing 2.6.0-pre9 the System seemed to work normally, all the

You mean 2.6.0-test9, don't you?

> stuff I did before worked normally but when doing large fileoperation
> including crunching stuff using bzip2 (e.g. checking out modules from
> CVS and tar'ing them up) the archives get corrupt. I was first assuming
> that this was a onetime mistake and thus I deleted the corrupt file and
> re-run my normal operations. But after a while I noticed that this
> problem occoured more and more and I was starting to worry. Archives are
> showing to be corrupted but after an reset these archives can be
> unpacked normally again.

Do you have preemptive kernel enabled (CONFIG_PREEMPT=y)?  There's
been some discussion about it possibly causing strange things in some
configurations.  If it helps to disable it, please post your .config,
so we can compare with others.

-- 
Måns Rullgård
mru@kth.se

