Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S277317AbRJ3SP4>; Tue, 30 Oct 2001 13:15:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S277330AbRJ3SPq>; Tue, 30 Oct 2001 13:15:46 -0500
Received: from darkwing.uoregon.edu ([128.223.142.13]:31458 "EHLO
	darkwing.uoregon.edu") by vger.kernel.org with ESMTP
	id <S277253AbRJ3SP2>; Tue, 30 Oct 2001 13:15:28 -0500
Date: Tue, 30 Oct 2001 10:15:38 -0800 (PST)
From: Joel Jaeggli <joelja@darkwing.uoregon.edu>
X-X-Sender: <joelja@twin.uoregon.edu>
To: "P.Agenbag" <internet@psimation.com>
cc: <linux-kernel@vger.kernel.org>
Subject: Re: 2.4.13 kernel and ext3???
In-Reply-To: <3BDEE870.1060104@psimation.com>
Message-ID: <Pine.LNX.4.33.0110301004300.2448-100000@twin.uoregon.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Tue, 30 Oct 2001, P.Agenbag wrote:

> Hi
> I just installed RedHat 7.2 with the 2.4.7 kernel. Low and behold, when
> I tried to install the latest kernels, I see that there are many options
> in the RedHat 2.4.7 kernel that are not even in the 2.4.13 kernel! How
> does this work?

patches, patches more patches...

> Also, I see many (EXPERIMENTAL) greyd-out areas in the
> kernel as well as other greyd out areas which are not experimental, yet
> won't allow me to select it ( reiserfs for example ) .
> How can I get reiserfs to compile into the kernel, and to satsify my
> curiosity, how do you enable the experimental options?

in the code maturity level options select:

Prompt for development and/or incomplete code/drivers

> Does it mean that if there is a fairly large difference between the
> RedHat 2.4.7 and the stock one from kernel.org, that they are not really
> the same?

much of what's different are drivers that either haven't yet been accepted
into the tree or won't be accepted for various reasons...

> ie, does anyone foresee any future problems with redhat adding
> all these extra features to their kernel and people who would like to
> upgrade to a newer version ( for one, I selected ext3 during install,
> yet, now trying to install 2.4.13, I must revert back to ext2...)

you can add ext3 by either grabbing the andrew morton et al patch from...

http://www.uow.edu.au/~andrewm/linux/ext3/

or by appling one of the ac series patches from alan.

I suspect when you see a new development tree be created (shortly) that a
significant amount of code will migrate into that.

joelja

> Thanks
>
>
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
>

-- 
--------------------------------------------------------------------------
Joel Jaeggli				       joelja@darkwing.uoregon.edu
Academic User Services			     consult@gladstone.uoregon.edu
     PGP Key Fingerprint: 1DE9 8FCA 51FB 4195 B42A 9C32 A30D 121E
--------------------------------------------------------------------------
It is clear that the arm of criticism cannot replace the criticism of
arms.  Karl Marx -- Introduction to the critique of Hegel's Philosophy of
the right, 1843.


