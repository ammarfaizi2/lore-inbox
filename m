Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S278103AbRKDUJx>; Sun, 4 Nov 2001 15:09:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S277435AbRKDUJn>; Sun, 4 Nov 2001 15:09:43 -0500
Received: from unthought.net ([212.97.129.24]:63448 "HELO mail.unthought.net")
	by vger.kernel.org with SMTP id <S278269AbRKDUJi>;
	Sun, 4 Nov 2001 15:09:38 -0500
Date: Sun, 4 Nov 2001 21:09:36 +0100
From: =?iso-8859-1?Q?Jakob_=D8stergaard?= <jakob@unthought.net>
To: Alexander Viro <viro@math.psu.edu>
Cc: John Levon <moz@compsoc.man.ac.uk>, linux-kernel@vger.kernel.org,
        Daniel Phillips <phillips@bonn-fries.net>, Tim Jansen <tim@tjansen.de>
Subject: Re: PROPOSAL: dot-proc interface [was: /proc stuff]
Message-ID: <20011104210936.T14001@unthought.net>
Mail-Followup-To: =?iso-8859-1?Q?Jakob_=D8stergaard?= <jakob@unthought.net>,
	Alexander Viro <viro@math.psu.edu>,
	John Levon <moz@compsoc.man.ac.uk>, linux-kernel@vger.kernel.org,
	Daniel Phillips <phillips@bonn-fries.net>,
	Tim Jansen <tim@tjansen.de>
In-Reply-To: <20011104205030.P14001@unthought.net> <Pine.GSO.4.21.0111041453230.21449-100000@weyl.math.psu.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: Mutt/1.2i
In-Reply-To: <Pine.GSO.4.21.0111041453230.21449-100000@weyl.math.psu.edu>; from viro@math.psu.edu on Sun, Nov 04, 2001 at 03:01:12PM -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Nov 04, 2001 at 03:01:12PM -0500, Alexander Viro wrote:
> 
> 
> On Sun, 4 Nov 2001, [iso-8859-1] Jakob %stergaard wrote:
> 
> > Strong type information (in one form or the other) is absolutely fundamental
> > for achieving correctness in this kind of software.
> 
> Like, say it, all shell programming?  Or the whole idea of "file as stream of
> characters"?  Or pipes, for that matter...
> 

Shell programming is great for small programs. You don't need type information
in the language when you can fit it all in your head.

Now, go write 100K lines of shell, something that does something that is not
just shoveling lines from one app into a grep and into another app.  Let's say,
a database.  Go implement the next Oracle replacement in bash, and tell me you
don't care about types in your language.

Why do we have "file formats", well that is because files are just streams
of characters, and we need more structure than just that.

This is exactly what I'm proposing - having "just" files in proc is fine,
but not knowing the type of the information they present is catastrophic.

-- 
................................................................
:   jakob@unthought.net   : And I see the elder races,         :
:.........................: putrid forms of man                :
:   Jakob Østergaard      : See him rise and claim the earth,  :
:        OZ9ABN           : his downfall is at hand.           :
:.........................:............{Konkhra}...............:
