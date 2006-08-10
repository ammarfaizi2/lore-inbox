Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932327AbWHJVFq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932327AbWHJVFq (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 10 Aug 2006 17:05:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932329AbWHJVFp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 10 Aug 2006 17:05:45 -0400
Received: from smtp-104-thursday.nerim.net ([62.4.16.104]:50444 "EHLO
	kraid.nerim.net") by vger.kernel.org with ESMTP id S932327AbWHJVFn
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 10 Aug 2006 17:05:43 -0400
Date: Thu, 10 Aug 2006 23:05:45 +0200
From: Jean Delvare <khali@linux-fr.org>
To: Greg KH <gregkh@suse.de>
Cc: Andrew Morton <akpm@osdl.org>, Robert Love <rlove@rlove.org>,
       Shem Multinymous <multinymous@gmail.com>, linux-kernel@vger.kernel.org,
       Pavel Machek <pavel@suse.cz>, hdaps-devel@lists.sourceforge.net
Subject: Re: [PATCH 00/12] ThinkPad embedded controller and hdaps drivers
 (version 2)
Message-Id: <20060810230545.84bbcb45.khali@linux-fr.org>
In-Reply-To: <20060810203736.GA15208@suse.de>
References: <1155203330179-git-send-email-multinymous@gmail.com>
	<acdcfe7e0608100646s411f57ccse54db9fe3cfde3fb@mail.gmail.com>
	<20060810131820.23f00680.akpm@osdl.org>
	<20060810203736.GA15208@suse.de>
X-Mailer: Sylpheed version 2.2.7 (GTK+ 2.6.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

All,

> On Thu, Aug 10, 2006 at 01:18:20PM -0700, Andrew Morton wrote:
> > On Thu, 10 Aug 2006 09:46:47 -0400
> > "Robert Love" <rlove@rlove.org> wrote:
> > 
> > > Patches look great and I am glad someone has apparently better access
> > > to hardware specs than I did.
> > 
> > This situation is still a concern.  From where did this additional register
> > information come?
> > 
> > Was it reverse-engineered?  If so, by whom and how can we satisfy ourselves
> > of this?
> > 
> > Was it from published documents?
> > 
> > Was it improperly obtained from NDA'ed documentation?
> > 
> > Presumably the answer to the third question will be "no", but if
> > challenged, how can we defend this assertion?
> > 
> > So hm.  We're setting precedent here and we need Linus around to resolve
> > this.  Perhaps we can ask "Shem" to reveal his true identity to Linus (and
> > maybe me) privately and then we proceed on that basis.  The rule could be
> > "each of the Signed-off-by:ers should know the identity of the others".
> 
> For what it's worth, I'm not going to be handling these patches at all
> (normally the hwmon patches go to Linus through Jean and then through
> me.)

I said it in private before, and I say it publicly again: I am not
handling these patches either. I don't even want to read them.

> If the original developer does not want to work in the open like the
> rest of us, I can respect that, but unfortunatly I can't accept the risk
> of accepting their code.
> 
> And no, this is not "been beaten over the head by IP lawyers for three
> years about risks like this" portion of me talking, although that side
> does have a lot he could say about this situation...

As far as I am concerned, even the real name of the person who wrote
and sent these patches wouldn't be enough for me to take them. I would
ask for an explanation of how that person got access to information
about the HDAPS which even the original author of the driver didn't
know about. And I would ask for proofs of that explanation.

All this is very unlikely to happen as I understand it, and anyway it's
all too late. Regardless of its technical merits, this patchset has too
much legal uncertainty attached to it by now. I'm maintaining the hwmon
subsystem on my own time and money, it's painful and unrewarding enough
as it is without adding legal hazard into the picture.

-- 
Jean Delvare
