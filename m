Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263776AbTLXSkq (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 24 Dec 2003 13:40:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263777AbTLXSkq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 24 Dec 2003 13:40:46 -0500
Received: from thunk.org ([140.239.227.29]:56778 "EHLO thunker.thunk.org")
	by vger.kernel.org with ESMTP id S263776AbTLXSkl (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 24 Dec 2003 13:40:41 -0500
Date: Wed, 24 Dec 2003 13:40:27 -0500
From: "Theodore Ts'o" <tytso@mit.edu>
To: Albert Cahalan <albert@users.sourceforge.net>
Cc: linux-kernel mailing list <linux-kernel@vger.kernel.org>, rml@ximian.com,
       stan@ccs.neu.edu, Jari.Soderholm@edu.stadia.fi
Subject: Re: DEVFS is very good compared to UDEV
Message-ID: <20031224184027.GA5836@thunk.org>
Mail-Followup-To: Theodore Ts'o <tytso@mit.edu>,
	Albert Cahalan <albert@users.sourceforge.net>,
	linux-kernel mailing list <linux-kernel@vger.kernel.org>,
	rml@ximian.com, stan@ccs.neu.edu, Jari.Soderholm@edu.stadia.fi
References: <1072236794.1743.244.camel@cube>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1072236794.1743.244.camel@cube>
User-Agent: Mutt/1.5.4i
X-Habeas-SWE-1: winter into spring
X-Habeas-SWE-2: brightly anticipated
X-Habeas-SWE-3: like Habeas SWE (tm)
X-Habeas-SWE-4: Copyright 2002 Habeas (tm)
X-Habeas-SWE-5: Sender Warranted Email (SWE) (tm). The sender of this
X-Habeas-SWE-6: email in exchange for a license for this Habeas
X-Habeas-SWE-7: warrant mark warrants that this is a Habeas Compliant
X-Habeas-SWE-8: Message (HCM) and not spam. Please report use of this
X-Habeas-SWE-9: mark in spam to <http://www.habeas.com/report/>.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 23, 2003 at 10:33:15PM -0500, Albert Cahalan wrote:
> How quickly we forget where those names came from!
> Richard Gooch originally used the traditional names.
> Linus ordered the names changed as a condition for
> acceptance into the kernel. Of course, that led to
> devfsd being a requirement, which kind of took away
> the whole point of using devfs.
> 
> The Linus-approved names made devfs a pain to use,
> so few people used devfs and fewer helped out.
> 

And this is **precisely** why putting the device names in the kernel
via devfs was such a mistake.  Naming is policy, and should not be in
the kernel.  Yes, the new style names were Linus's idea, but the
problem was that while he has extremely good taste with respect to
code, unfortunately he had exquisitely bad taste with respect to devfs
device names.  And when one person's taste (even if that person is
Linus) about names can cause such grief, it should be an object lesson
about why putting that kind of user-visible naming policy in the
kernel is such a bad idea.

> Richard is only to blame for his inability to spell
> /dev/disk correctly. For that, he belongs in "jail"
> with a "j". It was enough of an eyesore to make me
> give up on devfs.

Shouldn't that be "jail" with a "g"?  (As in "gaol"?  :-)

					- Ted

