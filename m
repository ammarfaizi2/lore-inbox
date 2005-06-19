Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262070AbVFSIXV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262070AbVFSIXV (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 19 Jun 2005 04:23:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262073AbVFSIXV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 19 Jun 2005 04:23:21 -0400
Received: from mx1.redhat.com ([66.187.233.31]:16521 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S262070AbVFSIXP (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 19 Jun 2005 04:23:15 -0400
Date: Sun, 19 Jun 2005 04:22:51 -0400
From: Dave Jones <davej@redhat.com>
To: Kyle Moffett <mrmacman_g4@mac.com>
Cc: "Martin J. Bligh" <mbligh@mbligh.org>, Jens Axboe <axboe@suse.de>,
       Andrew Morton <akpm@osdl.org>, James.Bottomley@SteelEye.com,
       linux-kernel@vger.kernel.org
Subject: Re: kernel bugzilla
Message-ID: <20050619082251.GA6483@redhat.com>
Mail-Followup-To: Dave Jones <davej@redhat.com>,
	Kyle Moffett <mrmacman_g4@mac.com>,
	"Martin J. Bligh" <mbligh@mbligh.org>, Jens Axboe <axboe@suse.de>,
	Andrew Morton <akpm@osdl.org>, James.Bottomley@SteelEye.com,
	linux-kernel@vger.kernel.org
References: <20050617001330.294950ac.akpm@osdl.org> <1119016223.5049.3.camel@mulgrave> <20050617142225.GO6957@suse.de> <20050617141003.2abdd8e5.akpm@osdl.org> <20050617212338.GA16852@suse.de> <491950000.1119044739@flay> <20050618191341.GA30620@redhat.com> <265EC713-9745-484D-8FF0-1C8D5FFE94F1@mac.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <265EC713-9745-484D-8FF0-1C8D5FFE94F1@mac.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jun 18, 2005 at 10:54:33PM -0400, Kyle Moffett wrote:
 > On Jun 18, 2005, at 15:13:41, Dave Jones wrote:
 > >On Fri, Jun 17, 2005 at 02:45:39PM -0700, Martin J. Bligh wrote:
 > >>The external one is infintely simpler than the internal IBM one, and
 > >>the distro ones. I *really, really* prefer to keep it that way.  
 > >>Having
 > >>said that, it does have a few fields (eg version, and
 > >>category/subcategory) that should be filled out properly, and that's
 > >>not easy to do via email.
 > >>For now, my intent is to allow bug filing via web only, and followup
 > >>comments by email. If lots of people scream and curse at me, I'll
 > >>reconsider I suppose.
 > >
 > >Something that I'd *really* love to see is usage of other bugzillas
 > >xml-rpc interfaces, so that for eg, if someone files a Fedora bug
 > >where some driver blows up, and I think it doesn't look like
 > >it's caused by any patch in our tree, I'd love to click a button
 > >in rh-bugzilla and have the bug automatically be also filed
 > >in bugme.osdl, with the various comments mirrored back to the
 > >originating bugzilla.
 > 
 > Another wishlist feature I've seen is to have a mailing list archiver
 > attached to bugzilla that receives and stores the last month worth of
 > emails on the list.  At any time someone can login and:
 
The volume of mail bugzilla-mail generates is obscene.
I've been on vacation for a week, and I have over a 1000
mails waiting for me from rh-bugzilla when I get back
to give you an indication.[*]

A month worth is just mammoth, and unless you have a lot
of spare time on your hands (or you have have a masochistic streak),
most of it will go unread, so I'm not sure such an archive
would be particularly useful.

I do have a bunch of scripts for rh-bugzilla that could probably
be adapted to osdl-bugme to obtain stats etc like
"show me how many bugs are in state x for kernel y", I'll
take a look at doing that soon.

		Dave

[*] Ok, rh-bugzilla gets a 'little' more than osdl-bugme does,
but that may not always be the case, especially if escalating
bugs to upstream becomes easier.

