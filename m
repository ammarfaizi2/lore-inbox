Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288248AbSCGAJX>; Wed, 6 Mar 2002 19:09:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289026AbSCGAJK>; Wed, 6 Mar 2002 19:09:10 -0500
Received: from mark.mielke.cc ([216.209.85.42]:14346 "EHLO mark.mielke.cc")
	by vger.kernel.org with ESMTP id <S288936AbSCGAJB>;
	Wed, 6 Mar 2002 19:09:01 -0500
Date: Wed, 6 Mar 2002 19:04:56 -0500
From: Mark Mielke <mark@mark.mielke.cc>
To: Chris Ball <chris@void.printf.net>
Cc: linux-kernel <linux-kernel@vger.kernel.org>
Subject: vsyscalls
Message-ID: <20020306190456.E21655@mark.mielke.cc>
In-Reply-To: <Pine.LNX.4.33.0203061238380.17114-100000@twinlark.arctic.org> <87bse14c4h.fsf@lexis.house.pkl.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <87bse14c4h.fsf@lexis.house.pkl.net>; from chris@void.printf.net on Wed, Mar 06, 2002 at 09:31:10PM +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 06, 2002 at 09:31:10PM +0000, Chris Ball wrote:
>  dean> ingo started the proper work for this, for example, see:
>  dean> <http://people.redhat.com/mingo/vsyscall-patches/vsyscall-2.3.32-F4>
>  dean> (there's a documentation file near the bottom of the patch)
>  dean> but it doesn't appear to support gettimeofday via rdtsc yet.
> Interesting patch; when last I looked, vsyscalls were only being
> implemented on the new 64-bit architectures.

> Does this patch break binary compatibility?  I seem to recall that being
> Andrea's reason for not running vsyscalls on standard x86 back in August
> last year.

WinNT looks like it supports vsyscalls (or at least SYSENTER).

mark

-- 
mark@mielke.cc/markm@ncf.ca/markm@nortelnetworks.com __________________________
.  .  _  ._  . .   .__    .  . ._. .__ .   . . .__  | Neighbourhood Coder
|\/| |_| |_| |/    |_     |\/|  |  |_  |   |/  |_   | 
|  | | | | \ | \   |__ .  |  | .|. |__ |__ | \ |__  | Ottawa, Ontario, Canada

  One ring to rule them all, one ring to find them, one ring to bring them all
                       and in the darkness bind them...

                           http://mark.mielke.cc/

