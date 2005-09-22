Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751195AbVIVVhd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751195AbVIVVhd (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 22 Sep 2005 17:37:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751198AbVIVVhc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 22 Sep 2005 17:37:32 -0400
Received: from zctfs063.nortelnetworks.com ([47.164.128.120]:17145 "EHLO
	zctfs063.nortelnetworks.com") by vger.kernel.org with ESMTP
	id S1751195AbVIVVhc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 22 Sep 2005 17:37:32 -0400
Message-ID: <43332400.2070606@nortel.com>
Date: Thu, 22 Sep 2005 15:37:04 -0600
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
References: <4331C9B2.5070801@nortel.com> <20050921210019.GF4569@in.ibm.com> <4331CFAD.6020805@nortel.com> <52ll1qkrii.fsf@cisco.com> <20050922031136.GE7992@ftp.linux.org.uk> <43322AE6.1080408@nortel.com> <20050922041733.GF7992@ftp.linux.org.uk> <4332CAEA.1010509@nortel.com> <20050922182719.GA4729@in.ibm.com> <4332FFF5.5060207@nortel.com> <20050922191805.GB4729@in.ibm.com>
In-Reply-To: <20050922191805.GB4729@in.ibm.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 22 Sep 2005 21:37:15.0293 (UTC) FILETIME=[CCA3ACD0:01C5BFBD]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dipankar Sarma wrote:

> Can you look at that each cpu is running (backtrace) using
> sysrq ? That may tell us what is holding up RCU. I will look
> at it myself later.

I'm having some trouble with sysrq over serial console.  I can trigger 
it, and it dumps the words "SysRq : Show Regs" to the console, but the 
actual data only goes to dmesg.

That should work for this, but does anyone have any idea whats going on 
there?

Chris
