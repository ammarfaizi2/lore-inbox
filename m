Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313288AbSDDSCB>; Thu, 4 Apr 2002 13:02:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313290AbSDDSBv>; Thu, 4 Apr 2002 13:01:51 -0500
Received: from ns.suse.de ([213.95.15.193]:26884 "HELO Cantor.suse.de")
	by vger.kernel.org with SMTP id <S313289AbSDDSBu>;
	Thu, 4 Apr 2002 13:01:50 -0500
Date: Thu, 4 Apr 2002 20:01:49 +0200
From: Dave Jones <davej@suse.de>
To: Greg KH <greg@kroah.com>
Cc: Sebastian Droege <sebastian.droege@gmx.de>, linux-kernel@vger.kernel.org
Subject: Re: Linux 2.5.7-dj3 - BUG & PATCH
Message-ID: <20020404200149.F11833@suse.de>
Mail-Followup-To: Dave Jones <davej@suse.de>,
	Greg KH <greg@kroah.com>, Sebastian Droege <sebastian.droege@gmx.de>,
	linux-kernel@vger.kernel.org
In-Reply-To: <20020404054923.A28437@suse.de> <20020404172238.62bf1d41.sebastian.droege@gmx.de> <20020404175438.GG15918@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 04, 2002 at 09:54:38AM -0800, Greg KH wrote:

 > Wrong patch, do not apply.  Well, half of the patch is wrong.  The
 > Config.in part is correct.  I'm guessing that the changes made in
 > 2.4.8-pre1 to include/hiddev.h didn't make it into -dj3
 > 
 > Try seeing if adding that patch to the -dj tree fixes things for you.
 > If you still have problems, let me know and I'll try to figure it out.

Bear in mind that my tree still has Vojtech's input layer changes which
moves quite a bit of stuff around, so it may have something to do with
that. Or it could just be that I pooched the merge.

-- 
| Dave Jones.        http://www.codemonkey.org.uk
| SuSE Labs
