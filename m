Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315155AbSECSjl>; Fri, 3 May 2002 14:39:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315181AbSECSjE>; Fri, 3 May 2002 14:39:04 -0400
Received: from ns.suse.de ([213.95.15.193]:46852 "HELO Cantor.suse.de")
	by vger.kernel.org with SMTP id <S315133AbSECShz>;
	Fri, 3 May 2002 14:37:55 -0400
Date: Fri, 3 May 2002 20:37:52 +0200
From: Dave Jones <davej@suse.de>
To: Shawn <core@enodev.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [LINK FAILURE] 2.5.12-dj1 (mark_buffer_uptodate)
Message-ID: <20020503203752.C30500@suse.de>
Mail-Followup-To: Dave Jones <davej@suse.de>,
	Shawn <core@enodev.com>, linux-kernel@vger.kernel.org
In-Reply-To: <20020503181719.GA20588@local.enodev.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 03, 2002 at 01:17:19PM -0500, Shawn wrote:
 > Searched the archives, and didn't find anything.
 > 
 > Could someone point me in the right direction to get this compiled?
 > 
 > drivers/block/block.o(.text+0xc514): undefined reference to `mark_buffer_uptodate'
 
I'm creating the 2.5.13-dj1 diff this minute, so that should be up real
soon now, which fixes this.  If you can't wait that long 8-), the fix is
to change that line to read set_buffer_uptodate(tmp);

-- 
| Dave Jones.        http://www.codemonkey.org.uk
| SuSE Labs
