Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S275980AbRJUMH5>; Sun, 21 Oct 2001 08:07:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S275973AbRJUMHr>; Sun, 21 Oct 2001 08:07:47 -0400
Received: from twilight.cs.hut.fi ([130.233.40.5]:48657 "EHLO
	twilight.cs.hut.fi") by vger.kernel.org with ESMTP
	id <S275968AbRJUMHh>; Sun, 21 Oct 2001 08:07:37 -0400
Date: Sun, 21 Oct 2001 15:08:02 +0300
From: Ville Herva <vherva@niksula.hut.fi>
To: Joerg Schilling <schilling@fokus.gmd.de>
Cc: cdwrite@other.debian.org, linux-kernel@vger.kernel.org
Subject: Re: 2.4.10ac10, cdrecord 1.9-6, Mitsumi CR-4804TE: lock up burning too large image
Message-ID: <20011021150801.H1504@niksula.cs.hut.fi>
In-Reply-To: <200110211156.f9LBu6308916@burner.fokus.gmd.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <200110211156.f9LBu6308916@burner.fokus.gmd.de>; from schilling@fokus.gmd.de on Sun, Oct 21, 2001 at 01:56:06PM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Oct 21, 2001 at 01:56:06PM +0200, you [Joerg Schilling] claimed:
> 
> >Hmm. It used to work with 2.2-kernel. With too large image, it just gave an
> >error.
> 
> I may only judge from information you provide, not from information you hide.

I did say that in the original report:

"It used to give a nice error when disk size was exceeded with 2.2.18pre19
and a tad older cdrecord..."

but I could have been clearer.
 
> 1.10 is outdated too, please read
> 
> http://www.fokus.gmd.de/research/cc/glone/employees/joerg.schilling/private/problems.html

Ok. I'll compile the newest from source.

But do you think the too-large-image lock up might be cured with a newer
cdrecord, or should is the kernel the prime suspect?

I will try anyway and report back to you.
 
> >with 2.2 ("failed to mmap /dev/null" or something) so I went back to 1.9. I
> 
> I cannot prevent you from broken Linux installations!
> 
> The linux kernel people still have propblems with interfaces and make
> thanges that break binary compatibility when going to more recent Linux
> versions. Why do you believe that a cdrecord that has been compiled on 2.4
> will run on 2.2?

Well, most software software seems to work with both 2.2 and 2.4. I didn't
think carefully enough to realize that some interfaces must have changed.
 
> Linux needed close to 10 years to finally support mmap() (ther OS like
> SunOS did this since 1987). Cdrecord's outoconf chooses the best
> interfaces of the OS. SVS shared mem is outdated and badly implemented on
> Linux (too many restrictions). mmap is the modern method to get shared
> memory but Linux didn't support is before November 2000.

I see. Thanks for the clarification.


-- v --

v@iki.fi
