Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131235AbRAEMzQ>; Fri, 5 Jan 2001 07:55:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131181AbRAEMzH>; Fri, 5 Jan 2001 07:55:07 -0500
Received: from hermes.mixx.net ([212.84.196.2]:45063 "HELO hermes.mixx.net")
	by vger.kernel.org with SMTP id <S131180AbRAEMy4>;
	Fri, 5 Jan 2001 07:54:56 -0500
Message-ID: <3A55C370.12296150@innominate.de>
Date: Fri, 05 Jan 2001 13:52:00 +0100
From: Daniel Phillips <phillips@innominate.de>
Organization: innominate
X-Mailer: Mozilla 4.72 [de] (X11; U; Linux 2.4.0-test10 i586)
X-Accept-Language: en
MIME-Version: 1.0
To: Mark Hahn <hahn@coffee.psychology.mcmaster.ca>,
        linux-kernel@vger.kernel.org
Subject: Re: Change of policy for future 2.2 driver submissions
In-Reply-To: <002201c076c7$76cab720$8d19b018@c779218a> <Pine.LNX.4.10.10101042308040.7111-100000@coffee.psychology.mcmaster.ca>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Mark Hahn wrote:
> > I personaly do not trust the 2.4.x kernel entirely yet, and would prefer to
> ...
> > afraid that this may partialy criple 2.2 driver development.
> 
> egads!  how can there be "development" on a *stable* kernel line?
> 
> maybe this is the time to reconsider terminology/policy:
> does "stable" mean "bugfixes only"?
> or does it mean "development kernel for conservatives"?

It means development kernel for those who don't have enough time to
debug the main kernel as well as their own project.  The stable branch
tends to be *far* better documented than the bleeding edge branch.  Try
to find documentation on the all-important page cache, for example.  It
makes a whole lot of sense to develop in the stable branch, especially
for new kernel developers, providing, of course, that the stable branch
has the basic capabilities you need for your project.

Alan isn't telling anybody which branch to develop in - he's telling
people what they have to do if they want their code in his tree.  This
means that when you develop in the stable branch you've got an extra
step to do at the end of your project: port to the unstable branch. 
This only has to be done once and your code *will* get cleaned up a lot
in the process.  (It's amazing how the prospect of merging 500 lines of
rejected patch tends to concentrate the mind.)  I'd even suggest another
step after that: port your unstable version back to the stable branch,
and both versions will be cleaned up.

--
Daniel
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
