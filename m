Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S291097AbSBGEO3>; Wed, 6 Feb 2002 23:14:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S291098AbSBGEOT>; Wed, 6 Feb 2002 23:14:19 -0500
Received: from barbados.bluemug.com ([63.195.182.101]:29957 "EHLO
	barbados.bluemug.com") by vger.kernel.org with ESMTP
	id <S291097AbSBGEOE>; Wed, 6 Feb 2002 23:14:04 -0500
Date: Wed, 6 Feb 2002 20:13:56 -0800
To: Daniel Phillips <phillips@bonn-fries.net>
Cc: "H. Peter Anvin" <hpa@zytor.com>,
        Alex Bligh - linux-kernel <linux-kernel@alex.org.uk>,
        linux-kernel@vger.kernel.org
Subject: Re: How to check the kernel compile options ?
Message-ID: <20020207041356.GA21694@bluemug.com>
Mail-Followup-To: Daniel Phillips <phillips@bonn-fries.net>,
	"H. Peter Anvin" <hpa@zytor.com>,
	Alex Bligh - linux-kernel <linux-kernel@alex.org.uk>,
	linux-kernel@vger.kernel.org
In-Reply-To: <a3mjhc$qba$1@cesium.transmeta.com> <2006875340.1012946564@[195.224.237.69]> <3C605910.6060907@zytor.com> <E16YOBB-0002Mx-00@starship.berlin>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <E16YOBB-0002Mx-00@starship.berlin>
X-PGP-ID: 5C09BB33
X-PGP-Fingerprint: C518 67A5 F5C5 C784 A196  B480 5C97 3BBD 5C09 BB33
From: Mike Touloumtzis <miket@bluemug.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 06, 2002 at 10:15:49AM +0100, Daniel Phillips wrote:
> On February 5, 2002 11:13 pm, H. Peter Anvin wrote:
> > Alex Bligh - linux-kernel wrote:
> > 
> > > I would be surprised if there is anyone on this list
> > > who has not lost at some point either the .config, the
> > > kysms, or something similar associated with at least
> > > one build they've made.
> > 
> > Sure.  And people have lost their root filesystems due to "rm -rf /".
> > That doesn't mean we build the entire (real) root filesystem into the
> > kernel.
> 
> Well, it seems to be down to you and Arjan aguing that this usability
> improvement isn't needed, vs quite a few *users* who are complaining about
> the current state of things, as well they should because it's less good than
> it could be.

Numeric participation on lkml discussions is not an indication of much.
If lkml accurately reflected the state of Linux and its userbase, Linux
would be the most crash-prone, bug-ridden, chaotic environment ever :-).

There's probably a lot of people (like me) who use distribution tools like
Debian's kernel-package to build and manage kernel packages.  If you're
used to using the right packaging tools, it looks kind of silly to stuff
text files into the kernel in case they're deleted, instead of doing:

$ dpkg -x kernel-image-2.4.17_1.00.Custom_i386.deb ~/tmp/
$ cat ~/tmp/boot/config-2.4.17

The kernel is just a program, and this is a tools problem.  You don't
see people arguing that cat's documentation should be moved into /bin/cat
in case administrators misplace "cat.1.gz".

miket
