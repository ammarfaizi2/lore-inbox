Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132426AbRCZLeL>; Mon, 26 Mar 2001 06:34:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132425AbRCZLeB>; Mon, 26 Mar 2001 06:34:01 -0500
Received: from asterix.hrz.tu-chemnitz.de ([134.109.132.84]:12535 "EHLO
	asterix.hrz.tu-chemnitz.de") by vger.kernel.org with ESMTP
	id <S132424AbRCZLdr>; Mon, 26 Mar 2001 06:33:47 -0500
Date: Mon, 26 Mar 2001 13:33:05 +0200
From: Ingo Oeser <ingo.oeser@informatik.tu-chemnitz.de>
To: Matthew Chappee <matthew@mattshouse.com>
Cc: dalecki@evision-ventures.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] OOM handling
Message-ID: <20010326133305.A8133@nightmaster.csn.tu-chemnitz.de>
In-Reply-To: <3ABDF8A6.7580BD7D@evision-ventures.com> <45961.192.168.1.5.985572801.squirrel@matthew.mattshouse.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2i
In-Reply-To: <45961.192.168.1.5.985572801.squirrel@matthew.mattshouse.com>; from matthew@mattshouse.com on Sun, Mar 25, 2001 at 09:13:20PM -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Mar 25, 2001 at 09:13:20PM -0500, Matthew Chappee wrote:
> The point being, my database shouldn't be selected for
> termination.  Nobody ever got fired for kill -9'ing netscape,
> but Oracle is a different story.  I urge you, consider the
> patch.

No, you got fired for not setting ulimits. Your boss is right
then!

ulimit -d 65536
ulimit -v 81920

and my netscape is very happy most of the time.

And my system is not disturbed.

64MB RAM + 256MB swap.

In a school I had the same setup on a 256MB server (256MB swap)
serving apps (StarOffice and Netscape) to  ~16 X clients.

I never had OOM there.

I think this is the amount of memory an oracle server at least
have to have, right?

What are your ulimits? What are your amounts of RAM+SWAP?

Regards

Ingo Oeser
-- 
10.+11.03.2001 - 3. Chemnitzer LinuxTag <http://www.tu-chemnitz.de/linux/tag>
         <<<<<<<<<<<<     been there and had much fun   >>>>>>>>>>>>
