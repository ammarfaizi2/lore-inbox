Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135867AbRDTLSO>; Fri, 20 Apr 2001 07:18:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135866AbRDTLSE>; Fri, 20 Apr 2001 07:18:04 -0400
Received: from nat-pool.corp.redhat.com ([199.183.24.200]:20460 "EHLO
	devserv.devel.redhat.com") by vger.kernel.org with ESMTP
	id <S135867AbRDTLRt>; Fri, 20 Apr 2001 07:17:49 -0400
Date: Thu, 19 Apr 2001 19:19:04 +0100
From: "Stephen C. Tweedie" <sct@redhat.com>
To: Dan Maas <dmaas@dcine.com>
Cc: linux-kernel@vger.kernel.org, cj@cjcj.com, bart@jukie.net,
        Stephen Tweedie <sct@redhat.com>
Subject: Re: Asynchronous IO
Message-ID: <20010419191904.A1444@redhat.com>
In-Reply-To: <009801c0c3f6$69d45c70$0701a8c0@morph>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <009801c0c3f6$69d45c70$0701a8c0@morph>; from dmaas@dcine.com on Fri, Apr 13, 2001 at 04:45:07AM -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Fri, Apr 13, 2001 at 04:45:07AM -0400, Dan Maas wrote:
> IIRC the problem with implementing asynchronous *disk* I/O in Linux today is
> that the filesystem code assumes synchronous I/O operations that block the
> whole process/thread. So implementing "real" asynch I/O (without the
> overhead of creating a process context for each operation) would require
> re-writing the filesystems as non-blocking state machines. Last I heard this
> was a long-term goal, but nobody's done the work yet

SGI and Ben LaHaise both have kernel async IO functionality working,
and Ingo Molnar's Tux code has support for doing certain filesystem
lookup operations asynchronously too.  

--Stephen
