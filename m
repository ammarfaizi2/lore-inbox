Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264647AbSJORpL>; Tue, 15 Oct 2002 13:45:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264673AbSJORpK>; Tue, 15 Oct 2002 13:45:10 -0400
Received: from to-velocet.redhat.com ([216.138.202.10]:4346 "EHLO
	touchme.toronto.redhat.com") by vger.kernel.org with ESMTP
	id <S264647AbSJORox>; Tue, 15 Oct 2002 13:44:53 -0400
Date: Tue, 15 Oct 2002 13:50:48 -0400
From: Benjamin LaHaise <bcrl@redhat.com>
To: Shailabh Nagar <nagar@watson.ibm.com>
Cc: linux-kernel <linux-kernel@vger.kernel.org>,
       linux-aio <linux-aio@kvack.org>, Andrew Morton <akpm@digeo.com>,
       David Miller <davem@redhat.com>,
       Linus Torvalds <torvalds@transmeta.com>,
       Stephen Tweedie <sct@redhat.com>
Subject: Re: [PATCH] async poll for 2.5
Message-ID: <20021015135048.F14596@redhat.com>
References: <3DAB46FD.9010405@watson.ibm.com> <20021015110501.B11395@redhat.com> <3DAC52AD.3080904@watson.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <3DAC52AD.3080904@watson.ibm.com>; from nagar@watson.ibm.com on Tue, Oct 15, 2002 at 01:38:53PM -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 15, 2002 at 01:38:53PM -0400, Shailabh Nagar wrote:
> So I guess the question would now be: whats keeping /dev/epoll from 
> being included in the kernel given the time left before the feature freeze ?

We don't need yet another event reporting mechanism as /dev/epoll presents.  
I was thinking it should just be its own syscall but report its events in 
the same way as aio.

		-ben
-- 
"Do you seek knowledge in time travel?"
