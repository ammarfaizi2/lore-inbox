Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S311960AbSDKQni>; Thu, 11 Apr 2002 12:43:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S312255AbSDKQnh>; Thu, 11 Apr 2002 12:43:37 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:12817 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S311960AbSDKQnh>;
	Thu, 11 Apr 2002 12:43:37 -0400
Date: Thu, 11 Apr 2002 17:43:31 +0100
From: "Dr. David Alan Gilbert" <gilbertd@treblig.org>
To: linux-kernel@vger.kernel.org
Subject: Re: linux as a minicomputer ?
Message-ID: <20020411164331.GR612@gallifrey>
In-Reply-To: <20020411154601.GY17962@antefacto.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
X-Chocolate: 70 percent or better cocoa solids preferably
X-Operating-System: Linux/2.4.18 (i686)
X-Uptime: 17:41:10 up 5 days, 21:17,  5 users,  load average: 1.74, 1.94, 1.98
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* John P. Looney (john@antefacto.com) wrote:
>  Sorry if this isn't the place for this question, but it's something that
> came up in general office talk today.
> 
>  Many many moons ago, the GGI project promised us the ability to buy a
> four-processor box, four PCI video cards, four USB mice & keyboards, and
> let four people use that machine at once, with benefits all around.

<snip>

>  Are there any plans to bring this sort of functionality to Linux 2.6 ? As
> I remember, some of the problems were that the GGI code was never going to
> get into Linux proper, and enumeration of multiple keyboards and mice, but
> I would have thought that was there a need, these problems would have been
> fixed by now.

I'm not sure, but I don't think any code is needed if you run X.  Bung
four USB mice, four USB keyboards in and four video cards.  Write a
separate X config for each one specifying which PCI card should be used
and which mouse/keyboard device should be used.  Now start an X server
for each one.

(Fun should form in the efforts to figure out which mouse is associated
with which keyboard and with which video output).

Dave
 ---------------- Have a happy GNU millennium! ----------------------   
/ Dr. David Alan Gilbert    | Running GNU/Linux on Alpha,68K| Happy  \ 
\ gro.gilbert @ treblig.org | MIPS,x86,ARM, SPARC and HP-PA | In Hex /
 \ _________________________|_____ http://www.treblig.org   |_______/
