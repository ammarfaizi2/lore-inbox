Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261376AbTCORyl>; Sat, 15 Mar 2003 12:54:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261484AbTCORyl>; Sat, 15 Mar 2003 12:54:41 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:65508 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S261376AbTCORyk>;
	Sat, 15 Mar 2003 12:54:40 -0500
Date: Sat, 15 Mar 2003 18:05:30 +0000
From: Matthew Wilcox <willy@debian.org>
To: Greg Ungerer <gerg@snapgear.com>
Cc: Matthew Wilcox <willy@debian.org>, Linus Torvalds <torvalds@transmeta.com>,
       linux-kernel@vger.kernel.org
Subject: Re: Please revert second addition of stddef.h to list.h
Message-ID: <20030315180530.GN29631@parcelfarce.linux.theplanet.co.uk>
References: <20030311211700.GI16414@parcelfarce.linux.theplanet.co.uk> <3E734518.6000808@snapgear.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3E734518.6000808@snapgear.com>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Mar 16, 2003 at 01:22:00AM +1000, Greg Ungerer wrote:
> Yes, although the original patch itself was correct.
> Obviously 2 patch sets that are trying to do the same
> thing have been applied post 2.5.64.
> 
> Patch below would fix this...

Yes, but you're removing the wrong one.  Keeping includes in alphabetical
order removes the possibility of this kind of fuck-up.

-- 
"It's not Hollywood.  War is real, war is primarily not about defeat or
victory, it is about death.  I've seen thousands and thousands of dead bodies.
Do you think I want to have an academic debate on this subject?" -- Robert Fisk
