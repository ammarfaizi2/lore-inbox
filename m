Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261682AbRE1SmB>; Mon, 28 May 2001 14:42:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263118AbRE1Slv>; Mon, 28 May 2001 14:41:51 -0400
Received: from marine.sonic.net ([208.201.224.37]:25662 "HELO marine.sonic.net")
	by vger.kernel.org with SMTP id <S261682AbRE1Slj>;
	Mon, 28 May 2001 14:41:39 -0400
X-envelope-info: <dalgoda@ix.netcom.com>
Date: Mon, 28 May 2001 11:34:46 -0700
From: Mike Castle <dalgoda@ix.netcom.com>
To: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: File read.
Message-ID: <20010528113446.G32600@thune.mrc-home.com>
Reply-To: Mike Castle <dalgoda@ix.netcom.com>
Mail-Followup-To: Mike Castle <dalgoda@ix.netcom.com>,
	Linux Kernel <linux-kernel@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <XFMail.20010528112631.davidel@xmailserver.org>
User-Agent: Mutt/1.3.18i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 28, 2001 at 11:26:31AM -0700, Davide Libenzi wrote:
> 
> On 28-Jun-2001 Anil Kumar wrote:
> > hi,
> > How do i read file within the kernel modules. I hope we can't use the FS
> > open... calls within kernel.
> 
> You can access fs methods directly.

But generally you don't want to.

Use a user mode application to feed you the data instead.

mrc
-- 
       Mike Castle       Life is like a clock:  You can work constantly
  dalgoda@ix.netcom.com  and be right all the time, or not work at all
www.netcom.com/~dalgoda/ and be right at least twice a day.  -- mrc
    We are all of us living in the shadow of Manhattan.  -- Watchmen
