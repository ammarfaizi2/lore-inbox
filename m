Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135481AbRDRX5q>; Wed, 18 Apr 2001 19:57:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135483AbRDRX5f>; Wed, 18 Apr 2001 19:57:35 -0400
Received: from snowbird.megapath.net ([216.200.176.7]:44302 "EHLO
	megapathdsl.net") by vger.kernel.org with ESMTP id <S135481AbRDRX5d>;
	Wed, 18 Apr 2001 19:57:33 -0400
Message-ID: <3ADE2A06.7EE56438@megapathdsl.net>
Date: Wed, 18 Apr 2001 16:57:58 -0700
From: Miles Lane <miles@megapathdsl.net>
X-Mailer: Mozilla 4.75 [en] (X11; U; Linux 2.4.3-ac9 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: "David S. Miller" <davem@redhat.com>
CC: James Simmons <jsimmons@linux-fbdev.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Fbdev development list 
	<linux-fbdev-devel@lists.sourceforge.net>
Subject: Re: ANNOUNCE New Open Source X server
In-Reply-To: <Pine.LNX.4.10.10104181317440.1478-100000@www.transvirtual.com> <15070.4428.345455.994818@pizda.ninka.net>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"David S. Miller" wrote:
> 
> James Simmons writes:
>  >     The Linux GFX project grew out the need for a higher performance X
>  > server that has a much faster developement cycle. In the last few years
>  > the graphics card and multimedia environments have grow at such a rate
>  > the current X solutions can no longer keep pace nor do they focus on
>  > producing high performance X servers specifically for linux. Also the
>  > community has demanded for specific functionality which has never come to
>  > light.
> 
> And this specific functionality is?
> 
> I think this is not a worthwhile project at all.  The X tree, it's
> assosciated protocols and APIs, are complicated enough as it is, and
> the xfree86 project has some of the most talented and capable people
> in this area.  It would be a step backwards to do things outside of
> xfree86 development.
> 
> If the issue is that "things don't happen fast enough in the xfree86
> tree", why not lend them a hand and submitting patches to them instead
> of complaining?

Yes, David, I concur.  

James, please just pitch in and help XFree86 evolve faster.
There are drivers that need to be "Render" extension enabled.  
There's more work to do on fleshing out the Render extension.  
I am sure that Kieth Packard would be grateful for any 
worthwhile contributions.

If you are thinking that you'll provide better accellerated 
graphics rendering performance, I'd love to know how you plan 
to accomplish this.  AFAIK, the main impediment to XFree86 
giving really good accelleration support for a broad array 
of hardware is the lack of technical documentation from the 
manufacturers.  Unless you plan on trying to get hardware 
manufactures to have you develop their closed-source drivers 
for them, I don't see how you'll be able to do any better 
than the XFree86 organization is already doing.

XFree86 evolves in a measured way as a result of many 
competing needs.  Backward compatibility is needed for the 
huge installed base of legacy apps.  For the various 
development toolkits (KDE, Gnome, etc.) there is a rapid 
move toward using the Render and "Resize and Rotate" 
extensions.  These extensions will make all sorts of cool 
rendering functionality available to the applications that 
use these toolkits (alpha blending, anti-aliased fonts and 
so on).  

I'd love to hear you enumerate all the shortcomings that you
believe need to be addressed.  Also, please CC: devel@xfree86.org.
At least give the competition an opportunity to win over the 
support of the developers you'd like to pull away from 
XFree86 work!

	Miles
