Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S277435AbRKDULn>; Sun, 4 Nov 2001 15:11:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S278269AbRKDULf>; Sun, 4 Nov 2001 15:11:35 -0500
Received: from unthought.net ([212.97.129.24]:64728 "HELO mail.unthought.net")
	by vger.kernel.org with SMTP id <S277435AbRKDULU>;
	Sun, 4 Nov 2001 15:11:20 -0500
Date: Sun, 4 Nov 2001 21:11:18 +0100
From: =?iso-8859-1?Q?Jakob_=D8stergaard?= <jakob@unthought.net>
To: Alexander Viro <viro@math.psu.edu>
Cc: Dave Jones <davej@suse.de>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: PROPOSAL: dot-proc interface [was: /proc stuff]
Message-ID: <20011104211118.U14001@unthought.net>
Mail-Followup-To: =?iso-8859-1?Q?Jakob_=D8stergaard?= <jakob@unthought.net>,
	Alexander Viro <viro@math.psu.edu>, Dave Jones <davej@suse.de>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <20011104205248.Q14001@unthought.net> <Pine.GSO.4.21.0111041502390.21449-100000@weyl.math.psu.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: Mutt/1.2i
In-Reply-To: <Pine.GSO.4.21.0111041502390.21449-100000@weyl.math.psu.edu>; from viro@math.psu.edu on Sun, Nov 04, 2001 at 03:06:27PM -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Nov 04, 2001 at 03:06:27PM -0500, Alexander Viro wrote:
> 
> 
> On Sun, 4 Nov 2001, [iso-8859-1] Jakob %stergaard wrote:
> 
> > So just ignore square brackets that have "=" " " and ">" between them ?
> > 
> > What happens when someone decides  "[---->   ]" looks cooler ?
> 
> First of all, whoever had chosen that output did a fairly idiotic thing.
> But as for your question - you _do_ know what regular expressions are,
> don't you?  And you do know how to do this particular regex without
> any use of library functions, right?

A regex won't tell me if  345987 is a signed or unsigned 32-bit or 64-bit
integer,  or if it's a double.

Sure, implement arbitrary precision arithmetic in every single app out there
using /proc....

-- 
................................................................
:   jakob@unthought.net   : And I see the elder races,         :
:.........................: putrid forms of man                :
:   Jakob Østergaard      : See him rise and claim the earth,  :
:        OZ9ABN           : his downfall is at hand.           :
:.........................:............{Konkhra}...............:
