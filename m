Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751104AbWFGH5E@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751104AbWFGH5E (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 7 Jun 2006 03:57:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751115AbWFGH5E
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 7 Jun 2006 03:57:04 -0400
Received: from main.gmane.org ([80.91.229.2]:48314 "EHLO ciao.gmane.org")
	by vger.kernel.org with ESMTP id S1751104AbWFGH5B (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 7 Jun 2006 03:57:01 -0400
X-Injected-Via-Gmane: http://gmane.org/
To: linux-kernel@vger.kernel.org
From: =?iso-8859-1?Q?M=E5ns_Rullg=E5rd?= <mru@inprovide.com>
Subject: Re: Quick close of all the open files.
Date: Wed, 07 Jun 2006 08:56:34 +0100
Message-ID: <yw1xzmgpflfx.fsf@agrajag.inprovide.com>
References: <3faf05680606061445r7da489d9tc265018bc7960779@mail.gmail.com> <200606062156.k56LuWFD001871@turing-police.cc.vt.edu> <3faf05680606061502q28501343yb3a91dbda3c423b6@mail.gmail.com> <200606070033.k570X6Bu007481@turing-police.cc.vt.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: agrajag.inprovide.com
User-Agent: Gnus/5.1007 (Gnus v5.10.7) XEmacs/21.4.15 (Security Through Obscurity, linux)
Cancel-Lock: sha1:J9yxyk+KfXW0UVkKLyb2bUZI0/E=
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Valdis.Kletnieks@vt.edu writes:

> On Tue, 06 Jun 2006 23:03:38 BST, =?iso-8859-1?Q?M=E5ns_Rullg=E5rd?= said:
>> > (Hint - what does that fp->_chain = stderr *really* do? ;)
>> 
>> As it touches the innards of the FILE type, it invokes undefined
>> behavior.  Nothing that follows can be considered a bug.
>
> Invoking undefined behavior is often considered a bug itself.  And it's
> certainly happening in userspace.. so there's a userspace bug. ;)

The bug is in the program that invoked the undefined behavior, not in
the library (libc) in which this behavior was invoked.

-- 
Måns Rullgård
mru@inprovide.com

