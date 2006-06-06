Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750739AbWFFWkF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750739AbWFFWkF (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 6 Jun 2006 18:40:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751096AbWFFWkF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 6 Jun 2006 18:40:05 -0400
Received: from main.gmane.org ([80.91.229.2]:11675 "EHLO ciao.gmane.org")
	by vger.kernel.org with ESMTP id S1750739AbWFFWkD (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 6 Jun 2006 18:40:03 -0400
X-Injected-Via-Gmane: http://gmane.org/
To: linux-kernel@vger.kernel.org
From: =?iso-8859-1?Q?M=E5ns_Rullg=E5rd?= <mru@inprovide.com>
Subject: Re: Quick close of all the open files.
Date: Tue, 06 Jun 2006 23:39:22 +0100
Message-ID: <yw1x8xo9hpt1.fsf@agrajag.inprovide.com>
References: <3faf05680606061445r7da489d9tc265018bc7960779@mail.gmail.com> <200606062156.k56LuWFD001871@turing-police.cc.vt.edu> <3faf05680606061502q28501343yb3a91dbda3c423b6@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: agrajag.inprovide.com
User-Agent: Gnus/5.1007 (Gnus v5.10.7) XEmacs/21.4.15 (Security Through Obscurity, linux)
Cancel-Lock: sha1:crEIxCVpDuiinmnuDdUHfL5IaJg=
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"vamsi krishna" <vamsi.krishnak@gmail.com> writes:

>> For bonus points, how did you verify that all the open files were closed?
>>
> I checked as follows I did printf("lowest fd = %d",fileno(tmpfile()));
> it prints 3

That is proof that at least stdout is still open, or you would not see
the output.

-- 
Måns Rullgård
mru@inprovide.com

