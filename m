Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S282910AbRK2UI4>; Thu, 29 Nov 2001 15:08:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S283200AbRK2UIs>; Thu, 29 Nov 2001 15:08:48 -0500
Received: from marine.sonic.net ([208.201.224.37]:7711 "HELO marine.sonic.net")
	by vger.kernel.org with SMTP id <S282910AbRK2UId>;
	Thu, 29 Nov 2001 15:08:33 -0500
X-envelope-info: <dalgoda@ix.netcom.com>
Date: Thu, 29 Nov 2001 12:08:26 -0800
From: Mike Castle <dalgoda@ix.netcom.com>
To: kernel list <linux-kernel@vger.kernel.org>
Subject: Re: 2.4.14 still not making fs dirty when it should
Message-ID: <20011129120826.F7992@thune.mrc-home.com>
Reply-To: Mike Castle <dalgoda@ix.netcom.com>
Mail-Followup-To: Mike Castle <dalgoda@ix.netcom.com>,
	kernel list <linux-kernel@vger.kernel.org>
In-Reply-To: <20011128231504.A26510@elf.ucw.cz> <3C069291.82E205F1@zip.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3C069291.82E205F1@zip.com.au>
User-Agent: Mutt/1.3.23i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 29, 2001 at 11:54:57AM -0800, Andrew Morton wrote:
> Pavel Machek wrote:
> > 
> > Hi!
> > 
> > I still can mount / read/write, press reset, and not get fsck on next
> > reboot. That strongly suggests kernel bug to me.
> 
> aargh.  I thought that was fixed.  How's this look?


I'm curious:

Why would you WANT this?

I always thought that if you didn't make any fs changes, then it should NOT
fsck.

mrc
-- 
     Mike Castle      dalgoda@ix.netcom.com      www.netcom.com/~dalgoda/
    We are all of us living in the shadow of Manhattan.  -- Watchmen
fatal ("You are in a maze of twisty compiler features, all different"); -- gcc
