Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751331AbWBAHOf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751331AbWBAHOf (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Feb 2006 02:14:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751333AbWBAHOf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Feb 2006 02:14:35 -0500
Received: from mailout07.sul.t-online.com ([194.25.134.83]:25245 "EHLO
	mailout07.sul.t-online.com") by vger.kernel.org with ESMTP
	id S1751331AbWBAHOe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Feb 2006 02:14:34 -0500
Message-ID: <43E05FA1.6070407@t-online.de>
Date: Wed, 01 Feb 2006 08:13:37 +0100
From: Knut Petersen <Knut_Petersen@t-online.de>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; de-AT; rv:1.7.10) Gecko/20050726
X-Accept-Language: de, en
MIME-Version: 1.0
To: Trond Myklebust <trond.myklebust@fys.uio.no>
CC: linux-kernel@vger.kernel.org, neilb@cse.unsw.edu.au,
       nfs@lists.sourceforge.net
Subject: Re: [BUG] nfs version 2 broken
References: <43E05031.2000107@t-online.de>	 <1138774519.7861.4.camel@lade.trondhjem.org>  <43E0567F.20004@t-online.de> <1138775744.7875.0.camel@lade.trondhjem.org>
In-Reply-To: <1138775744.7875.0.camel@lade.trondhjem.org>
X-Enigmail-Version: 0.86.0.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-ID: Sx2dcyZdZeY-BeOGyBcubg3n-4IIvsUqRNdHnn27TJdv1bu313eX4n@t-dialin.net
X-TOI-MSGID: 35525230-fd8f-405b-83bd-3dcd03843d76
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


>>AOpen i915GMm-HFS with Pentium M, linux kernel 2.6.15-git7
>>running a system that startet as SuSE 9.2. Nfs-utils are still
>>the original 1.0.6, grep -i nfs linuxbuild/.config gives
>>    
>>
>
>...and what kind of filesystem are you exporting?
>
>  
>

I think it is _not_ related to reiserfs. Moving my
exported /tftpboot directory to a fresh ext2 partition
gave the same results - failing with nfs 2, succeeding with
nfs 3.

cu,
Knut

