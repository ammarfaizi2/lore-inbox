Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265227AbSJWVPX>; Wed, 23 Oct 2002 17:15:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265228AbSJWVPW>; Wed, 23 Oct 2002 17:15:22 -0400
Received: from zeus.kernel.org ([204.152.189.113]:3471 "EHLO zeus.kernel.org")
	by vger.kernel.org with ESMTP id <S265227AbSJWVPU>;
	Wed, 23 Oct 2002 17:15:20 -0400
Date: Wed, 23 Oct 2002 17:18:18 -0400
From: Benjamin LaHaise <bcrl@redhat.com>
To: Davide Libenzi <davidel@xmailserver.org>
Cc: linux-kernel <linux-kernel@vger.kernel.org>,
       linux-aio <linux-aio@kvack.org>
Subject: Re: epoll (was Re: [PATCH] async poll for 2.5)
Message-ID: <20021023171818.B9700@redhat.com>
References: <20021023133900.B27433@redhat.com> <Pine.LNX.4.44.0210231144500.1581-100000@blue1.dev.mcafeelabs.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <Pine.LNX.4.44.0210231144500.1581-100000@blue1.dev.mcafeelabs.com>; from davidel@xmailserver.org on Wed, Oct 23, 2002 at 11:47:33AM -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 23, 2002 at 11:47:33AM -0700, Davide Libenzi wrote:
> Ben, does it work at all currently read/write requests on sockets ? I
> would like to test AIO on networking using my test http server, and I was
> thinking about using poll() for async accept and AIO for read/write. The
> poll() should be pretty fast because there's only one fd in the set and
> the remaining code will use AIO for read/write. Might this work currently ?

The socket async read/write code is not yet in the kernel.

		-ben
-- 
"Do you seek knowledge in time travel?"
