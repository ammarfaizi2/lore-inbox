Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265930AbUHFNUh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265930AbUHFNUh (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 6 Aug 2004 09:20:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268134AbUHFNUg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 6 Aug 2004 09:20:36 -0400
Received: from colin2.muc.de ([193.149.48.15]:36624 "HELO colin2.muc.de")
	by vger.kernel.org with SMTP id S265930AbUHFNU1 convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 6 Aug 2004 09:20:27 -0400
Date: 6 Aug 2004 15:20:25 +0200
Date: Fri, 6 Aug 2004 15:20:25 +0200
From: Andi Kleen <ak@muc.de>
To: "David S. Miller" <davem@redhat.com>
Cc: yoshfuji@linux-ipv6.org, jgarzik@pobox.com, axboe@suse.de,
       linux-kernel@vger.kernel.org
Subject: Re: block layer sg, bsg
Message-ID: <20040806132025.GA28248@muc.de>
References: <20040804232116.GA30152@muc.de> <20040804.165113.06226042.yoshfuji@linux-ipv6.org> <20040805114917.GC31944@muc.de> <20040805.204637.107575718.yoshfuji@linux-ipv6.org> <20040805211949.11fa33b7.davem@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: 8BIT
In-Reply-To: <20040805211949.11fa33b7.davem@redhat.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 05, 2004 at 09:19:49PM -0700, David S. Miller wrote:
> On Thu, 05 Aug 2004 20:46:37 -0700 (PDT)
> YOSHIFUJI Hideaki / 吉藤英明 <yoshfuji@linux-ipv6.org> wrote:
> 
> > I'd suggest changing XFRM_MSG_xxx things to 64bit-aware structures,
> > whose layouts do not change between 64bit mode and 32bit mode.
> > Of course, they will come with backward compatibility stuff.
> > If you don't mind this, I'd like to take care of this.
> 
> I think other tasks have much higher priority, especially
> when a workaround exists for this problem, namely building
> the native 64-bit version of the tool.

As long as it runs on sparc64 it's not critical I guess :|

People who can easily build 64bit programs normally don't 
need any 32bit userland.

-Andi
