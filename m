Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S278958AbRKDVU2>; Sun, 4 Nov 2001 16:20:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S279105AbRKDVUV>; Sun, 4 Nov 2001 16:20:21 -0500
Received: from unthought.net ([212.97.129.24]:4057 "HELO mail.unthought.net")
	by vger.kernel.org with SMTP id <S278958AbRKDVUK>;
	Sun, 4 Nov 2001 16:20:10 -0500
Date: Sun, 4 Nov 2001 22:20:09 +0100
From: =?iso-8859-1?Q?Jakob_=D8stergaard?= <jakob@unthought.net>
To: "Albert D. Cahalan" <acahalan@cs.uml.edu>
Cc: Alex Bligh - linux-kernel <linux-kernel@alex.org.uk>,
        Alexander Viro <viro@math.psu.edu>, John Levon <moz@compsoc.man.ac.uk>,
        linux-kernel@vger.kernel.org,
        Daniel Phillips <phillips@bonn-fries.net>, Tim Jansen <tim@tjansen.de>
Subject: Re: PROPOSAL: dot-proc interface [was: /proc stuff]
Message-ID: <20011104222009.Y14001@unthought.net>
Mail-Followup-To: =?iso-8859-1?Q?Jakob_=D8stergaard?= <jakob@unthought.net>,
	"Albert D. Cahalan" <acahalan@cs.uml.edu>,
	Alex Bligh - linux-kernel <linux-kernel@alex.org.uk>,
	Alexander Viro <viro@math.psu.edu>,
	John Levon <moz@compsoc.man.ac.uk>, linux-kernel@vger.kernel.org,
	Daniel Phillips <phillips@bonn-fries.net>,
	Tim Jansen <tim@tjansen.de>
In-Reply-To: <20011104204502.O14001@unthought.net> <200111042112.fA4LCNR241720@saturn.cs.uml.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: Mutt/1.2i
In-Reply-To: <200111042112.fA4LCNR241720@saturn.cs.uml.edu>; from acahalan@cs.uml.edu on Sun, Nov 04, 2001 at 04:12:23PM -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Nov 04, 2001 at 04:12:23PM -0500, Albert D. Cahalan wrote:
> =?iso-8859-1?Q?Jak writes:
> 
> > Please tell me,  is "1610612736" a 32-bit integer, a 64-bit integer, is
> > it signed or unsigned   ?
> > 
> > I could even live with parsing ASCII, as long as there'd just be type
> > information to go with the values.
> 
> You are looking for something called the registry. It's something
> that was introduced with Windows 95. It's basically a filesystem
> with typed files: char, int, string, string array, etc.

Nope   :)

It does not have "char, int, string, string array, etc." it has "String, binary
and DWORD".

Having read out 64 bit values, floating point data etc. from the registry, I'm
old enough to know that it is *NOT* what I'm looking for   :)

...
> Funny you should mention that one. I wrote the code used by procps
> to read this file. I love that file! The parentheses issue is just
> a beauty wart. People rarely feel the urge to screw with raw numbers.
> In all the other files, idiots like to: add headers, change the
> spelling of field names, change the order, add spaces and random
> punctuation, etc. Nothing is as stable and easy to use as the
> /proc/self/stat file.

Imagine every field in a file by itself, with well-defined type
information and unit informaiton.

...
> Linus clearly doesn't give a fuck about /proc performance.
> That's his right, and you are welcome to patch your kernel to
> have something better: http://lwn.net/2000/0420/a/atomicps.html

Performance is one thing.  Not being able to know whether numbers are i32, u32,
u64, or measured in Kilobytes or carrots is another ting.

-- 
................................................................
:   jakob@unthought.net   : And I see the elder races,         :
:.........................: putrid forms of man                :
:   Jakob Østergaard      : See him rise and claim the earth,  :
:        OZ9ABN           : his downfall is at hand.           :
:.........................:............{Konkhra}...............:
