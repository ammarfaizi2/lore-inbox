Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316887AbSHAT1g>; Thu, 1 Aug 2002 15:27:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316860AbSHAT1g>; Thu, 1 Aug 2002 15:27:36 -0400
Received: from tapu.f00f.org ([66.60.186.129]:23478 "EHLO tapu.f00f.org")
	by vger.kernel.org with ESMTP id <S316887AbSHAT1f>;
	Thu, 1 Aug 2002 15:27:35 -0400
Date: Thu, 1 Aug 2002 12:31:03 -0700
From: Chris Wedgwood <cw@f00f.org>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Chris Friesen <cfriesen@nortelnetworks.com>,
       Benjamin LaHaise <bcrl@redhat.com>, Pavel Machek <pavel@elf.ucw.cz>,
       Andrea Arcangeli <andrea@suse.de>, linux-kernel@vger.kernel.org,
       linux-aio@kvack.org
Subject: Re: [rfc] aio-core for 2.5.29 (Re: async-io API registration for 2.5.29)
Message-ID: <20020801193103.GA24483@tapu.f00f.org>
References: <20020801191823.GA24428@tapu.f00f.org> <Pine.LNX.4.33.0208011221380.3000-100000@penguin.transmeta.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.33.0208011221380.3000-100000@penguin.transmeta.com>
User-Agent: Mutt/1.4i
X-No-Archive: Yes
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 01, 2002 at 12:25:06PM -0700, Linus Torvalds wrote:

    I seriously doubt that people really care _that_ much about a
    precise time source for aio timeouts, and we should spend more
    time on making it efficient and easy to use than on worrying about
    the precision. People who do care can fall back to gettimeofday()
    and try to correct for it that way.

In that case define the time to be approximate and nothing more.

The reason for the original suggestion was it seem feasible in the
future the syscall could be used for other purposes (multimedia
synchornisation) *and* be of value if made more precise without adding
yet another syscall at a later stage to do just this.



  --cw
