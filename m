Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267944AbTAHWbd>; Wed, 8 Jan 2003 17:31:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267945AbTAHWbd>; Wed, 8 Jan 2003 17:31:33 -0500
Received: from serenity.mcc.ac.uk ([130.88.200.93]:38930 "EHLO
	serenity.mcc.ac.uk") by vger.kernel.org with ESMTP
	id <S267944AbTAHWb0>; Wed, 8 Jan 2003 17:31:26 -0500
Date: Wed, 8 Jan 2003 22:40:06 +0000
From: John Levon <levon@movementarian.org>
To: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] /proc/sys/kernel/pointer_size
Message-ID: <20030108224006.GA47765@compsoc.man.ac.uk>
References: <20030108205220.GB35912@compsoc.man.ac.uk> <Pine.LNX.4.44.0301081300200.1497-100000@home.transmeta.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44.0301081300200.1497-100000@home.transmeta.com>
User-Agent: Mutt/1.3.25i
X-Url: http://www.movementarian.org/
X-Record: Mr. Scruff - Trouser Jazz
X-Scanner: exiscan for exim4 (http://duncanthrax.net/exiscan/) *18WOrm-0001dy-00*xgXqIe.0UUs*
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 08, 2003 at 01:03:14PM -0800, Linus Torvalds wrote:

> You should certainly see it in "uname -a" output, for example.

Hrmph. Actually we can take it from the ELF headers of the vmlinux file
that gets passed in I suppose. Along with a uname hack for when there's
no vmlinux available...

> The same is true of kernel modules - 32-bit kernel modules do not work at 
> all when the kernel is 64-bit.

Modules aren't in userspace.

> Compile oprofile for the proper architecture if you do it yourself, and
> complain to the vendor if the vendor is stupid enough to supply a 32-bit 
> oprofile with a 64-bit kernel.

I don't see what's stupid about a 32-bit binary on a system where all of
user-space is 32-bit. But it doesn't matter.

regards
john

-- 
"CUT IT OUT FACEHEAD"
	- jeffk
