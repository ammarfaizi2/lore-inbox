Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268200AbUHFS6g@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268200AbUHFS6g (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 6 Aug 2004 14:58:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268225AbUHFS6f
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 6 Aug 2004 14:58:35 -0400
Received: from smtp108.mail.sc5.yahoo.com ([66.163.170.6]:20593 "HELO
	smtp108.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S268200AbUHFS6e (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 6 Aug 2004 14:58:34 -0400
Message-ID: <4113D4CD.5080109@yahoo.com.au>
Date: Sat, 07 Aug 2004 04:58:21 +1000
From: Nick Piggin <nickpiggin@yahoo.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7) Gecko/20040707 Debian/1.7-5
X-Accept-Language: en
MIME-Version: 1.0
To: Phillip Lougher <phillip@lougher.demon.co.uk>
CC: linux-kernel@vger.kernel.org, Andrew Morton <akpm@osdl.org>,
       viro@parcelfarce.linux.theplanet.co.uk
Subject: Re: [PATCH] VFS readahead bug in 2.6.8-rc[1-3]
References: <41127371.1000603@lougher.demon.co.uk> <4112D6FD.4030707@yahoo.com.au> <4112EAAB.8040005@yahoo.com.au> <4113B8A2.4050609@lougher.demon.co.uk>
In-Reply-To: <4113B8A2.4050609@lougher.demon.co.uk>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Phillip Lougher wrote:
> Nick Piggin wrote:
> 
>> On second thought, maybe not. I think your filesystem is at fault.
> 
> 
> No I'm not wrong here. With a read-only filesystem i_size can
> never change, there are no possible race conditions.  If a too
> large index is passed it is a VFS bug.  Are you suggesting I should
> start to code assuming the VFS is broken?
> 

No, I suggest you start to code assuming this interface does
what it does. I didn't say there is no bug here, but nobody
else's filesystem breaks.
