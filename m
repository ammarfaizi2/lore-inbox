Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261383AbVE0CBv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261383AbVE0CBv (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 26 May 2005 22:01:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261414AbVE0CBv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 26 May 2005 22:01:51 -0400
Received: from rwcrmhc14.comcast.net ([216.148.227.89]:8388 "EHLO
	rwcrmhc14.comcast.net") by vger.kernel.org with ESMTP
	id S261383AbVE0CBl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 26 May 2005 22:01:41 -0400
From: Parag Warudkar <kernel-stuff@comcast.net>
To: Roland McGrath <roland@redhat.com>
Subject: Re: waitid() fails with EINVAL for SA_RESTART signals
Date: Thu, 26 May 2005 22:01:41 -0400
User-Agent: KMail/1.8
Cc: Linus Torvalds <torvalds@osdl.org>,
       "David S. Miller" <davem@davemloft.net>, akpm@osdl.org,
       mtk-lkml@gmx.net, linux-kernel@vger.kernel.org, michael.kerrisk@gmx.net
References: <200505270011.j4R0BuwN011311@magilla.sf.frob.com> <200505262037.57204.kernel-stuff@comcast.net> <200505262105.09258.kernel-stuff@comcast.net>
In-Reply-To: <200505262105.09258.kernel-stuff@comcast.net>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200505262201.41570.kernel-stuff@comcast.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ok.. Nothing wrong with the kernel - I used the syscall(...) macro with 247 as 
the syscall number (__NR_waitid) the program works as expected. My version of 
glibc might not actually support WCONTINUED.

Thanks

Parag
