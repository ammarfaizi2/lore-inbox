Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S311756AbSDNIUG>; Sun, 14 Apr 2002 04:20:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S311829AbSDNIUG>; Sun, 14 Apr 2002 04:20:06 -0400
Received: from tapu.f00f.org ([66.60.186.129]:16092 "EHLO tapu.f00f.org")
	by vger.kernel.org with ESMTP id <S311756AbSDNIUF>;
	Sun, 14 Apr 2002 04:20:05 -0400
Date: Sun, 14 Apr 2002 01:19:46 -0700
From: Chris Wedgwood <cw@f00f.org>
To: Keith Owens <kaos@ocs.com.au>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] zerocopy NFS updated
Message-ID: <20020414081946.GA862@tapu.f00f.org>
In-Reply-To: <20020413185249.GA31470@tapu.f00f.org> <32583.1018742876@ocs3.intra.ocs.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
X-No-Archive: Yes
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Apr 14, 2002 at 10:07:56AM +1000, Keith Owens wrote:

    Write in append mode must be atomic in the kernel.  Whether a user
    space write in append mode is atomic or not depends on how many
    write() syscalls it takes to pass the data into the kernel.  Each
    write() append will be atomic but multiple writes can be
    interleaved.

Up to what size?  I assume I cannot assume O_APPEND atomicity for
(say) 100M writes?


  --cw
