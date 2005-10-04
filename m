Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964948AbVJDUDF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964948AbVJDUDF (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 4 Oct 2005 16:03:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964949AbVJDUDE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 4 Oct 2005 16:03:04 -0400
Received: from zctfs063.nortelnetworks.com ([47.164.128.120]:5299 "EHLO
	zctfs063.nortelnetworks.com") by vger.kernel.org with ESMTP
	id S964948AbVJDUDC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 4 Oct 2005 16:03:02 -0400
Message-ID: <4342DFDF.9010206@nortel.com>
Date: Tue, 04 Oct 2005 14:02:39 -0600
From: "Christopher Friesen" <cfriesen@nortel.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6) Gecko/20040115
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: dipankar@in.ibm.com
CC: Al Viro <viro@ftp.linux.org.uk>, Roland Dreier <rolandd@cisco.com>,
       Sonny Rao <sonny@burdell.org>, linux-kernel@vger.kernel.org,
       "Theodore Ts'o" <tytso@mit.edu>, bharata@in.ibm.com,
       trond.myklebust@fys.uio.no
Subject: Re: dentry_cache using up all my zone normal memory -- also seen
 on 2.6.14-rc2
References: <4331B89B.3080107@nortel.com> <20050921200758.GA25362@kevlar.burdell.org> <4331C9B2.5070801@nortel.com> <20050921210019.GF4569@in.ibm.com> <4331CFAD.6020805@nortel.com> <52ll1qkrii.fsf@cisco.com> <20050922031136.GE7992@ftp.linux.org.uk> <43322AE6.1080408@nortel.com> <20050922041733.GF7992@ftp.linux.org.uk> <4332CAEA.1010509@nortel.com> <20051004194349.GA6039@in.ibm.com>
In-Reply-To: <20051004194349.GA6039@in.ibm.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 04 Oct 2005 20:02:45.0197 (UTC) FILETIME=[95F4AFD0:01C5C91E]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dipankar Sarma wrote:

> Since then, I have done some testing myself, but I can't reproduce
> this problem in two of my systems - x86 and x86_64. I ran rename14
> in a loop too, but after exhausting a lot of free memory, dcache
> does get shrunk and I don't see dentries stuck in RCU queues at all.
> I tried UP kernel too.

I've only managed to reproduce it on a UP system with HIGHMEM.

> So, there must be something else in your system that I
> am missing in my setup. Could you please mail me your .config ?

Sent privately.

Chris
