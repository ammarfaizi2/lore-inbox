Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129767AbQKCIAq>; Fri, 3 Nov 2000 03:00:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130111AbQKCIAg>; Fri, 3 Nov 2000 03:00:36 -0500
Received: from Prins.externet.hu ([212.40.96.161]:16402 "EHLO
	prins.externet.hu") by vger.kernel.org with ESMTP
	id <S129875AbQKCIAS>; Fri, 3 Nov 2000 03:00:18 -0500
Date: Fri, 3 Nov 2000 09:00:06 +0100 (CET)
From: Narancs 1 <narancs1@externet.hu>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
cc: linux-kernel@vger.kernel.org
Subject: Re: so vesafb doesn't work in i815
In-Reply-To: <E13rOWr-0001ik-00@the-village.bc.nu>
Message-ID: <Pine.LNX.4.02.10011030852170.2786-100000@prins.externet.hu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2 Nov 2000, Alan Cox wrote:



> > xfree 4.0.1d supports it, but the screen flicker so hard, that is is
> > unusable. 
> 
> Ah there is a trick to that bit. If you have some i810 stuff then XFree does
> funnies if you have DRM enabled. 
I did disable loading drm/dri module from xf86config/kernel module
It acts the same.

> 
> The following combination I know works
> 
> 2.2.18pre18
I have 2.4.0-test10
> XFree 4.0 rpms from Red Hat (not 100% sure which 4.0 set they match sorry)
> DRM disabled in the XF86Config.
debian 4.0.1d 
> 
> On my i810 the DRM/flicker problem isnt present but I have seen other folks with
> it and disabling the direct 3d stuff cured it.
what other modules?
> 
> 2.2.18pre18 also supports the i810 audio reasonably well. For full UDMA ide you
> want 2.4test or 2.2.18pre18 + ide patch
how?
which driver?
I couldn't get i810 ihc driver go in 2.4.0t10
Alsa works, but it plays pcm like micky mouse (faster).
They said, it is fixed in the CVS i haven't tried/

thanx!
Alan Cox is my man.
Narancs v1

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
