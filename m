Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750875AbWFGIAH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750875AbWFGIAH (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 7 Jun 2006 04:00:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751116AbWFGIAH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 7 Jun 2006 04:00:07 -0400
Received: from main.gmane.org ([80.91.229.2]:22433 "EHLO ciao.gmane.org")
	by vger.kernel.org with ESMTP id S1750875AbWFGIAG (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 7 Jun 2006 04:00:06 -0400
X-Injected-Via-Gmane: http://gmane.org/
To: linux-kernel@vger.kernel.org
From: =?iso-8859-1?Q?M=E5ns_Rullg=E5rd?= <mru@inprovide.com>
Subject: Re: Quick close of all the open files.
Date: Wed, 07 Jun 2006 08:57:24 +0100
Message-ID: <yw1xverdflej.fsf@agrajag.inprovide.com>
References: <3faf05680606061445r7da489d9tc265018bc7960779@mail.gmail.com> <200606062156.k56LuWFD001871@turing-police.cc.vt.edu> <3faf05680606061502q28501343yb3a91dbda3c423b6@mail.gmail.com> <200606070033.k570X6Bu007481@turing-police.cc.vt.edu> <3faf05680606061822g25c242ddq58efdb762ca33252@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: agrajag.inprovide.com
User-Agent: Gnus/5.1007 (Gnus v5.10.7) XEmacs/21.4.15 (Security Through Obscurity, linux)
Cancel-Lock: sha1:nPEevioKWJlG4dIcovACzEae0Mo=
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"vamsi krishna" <vamsi.krishnak@gmail.com> writes:

>> > >
>> > I checked as follows I did printf("lowest fd = %d",fileno(tmpfile()));
>> > it prints 3
>>
>> Which proves that file descriptor 3 was closed, so tmpfile() was able to
>> open it.  This certainly implies that fd 0, 1, 2 (connected to stdin,
>> stdout, and stderr streams of stdio) are still open, contrary to your
>> statement that *all* of them are closed.
>
> I know 0,1,2 are open (I opened it) no need to tell it specifically,
> HOW DO YOU THINK I CAN PRINT SOME THING WITHOUT OPENING THIS
> FILES(stdout,stderr)?

That still says nothing about file descriptors 4 and up.

-- 
Måns Rullgård
mru@inprovide.com

