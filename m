Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262197AbVFRTOW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262197AbVFRTOW (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 18 Jun 2005 15:14:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262194AbVFRTOV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 18 Jun 2005 15:14:21 -0400
Received: from mx1.redhat.com ([66.187.233.31]:10126 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S262200AbVFRTNy (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 18 Jun 2005 15:13:54 -0400
Date: Sat, 18 Jun 2005 15:13:41 -0400
From: Dave Jones <davej@redhat.com>
To: "Martin J. Bligh" <mbligh@mbligh.org>
Cc: Jens Axboe <axboe@suse.de>, Andrew Morton <akpm@osdl.org>,
       James.Bottomley@SteelEye.com, linux-kernel@vger.kernel.org
Subject: Re: kernel bugzilla
Message-ID: <20050618191341.GA30620@redhat.com>
Mail-Followup-To: Dave Jones <davej@redhat.com>,
	"Martin J. Bligh" <mbligh@mbligh.org>, Jens Axboe <axboe@suse.de>,
	Andrew Morton <akpm@osdl.org>, James.Bottomley@SteelEye.com,
	linux-kernel@vger.kernel.org
References: <20050617001330.294950ac.akpm@osdl.org> <1119016223.5049.3.camel@mulgrave> <20050617142225.GO6957@suse.de> <20050617141003.2abdd8e5.akpm@osdl.org> <20050617212338.GA16852@suse.de> <491950000.1119044739@flay>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <491950000.1119044739@flay>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 17, 2005 at 02:45:39PM -0700, Martin J. Bligh wrote:

 > The external one is infintely simpler than the internal IBM one, and
 > the distro ones. I *really, really* prefer to keep it that way. Having 
 > said that, it does have a few fields (eg version, and category/subcategory) that should be filled out properly, and that's not easy to do via email.
 > For now, my intent is to allow bug filing via web only, and followup 
 > comments by email. If lots of people scream and curse at me, I'll
 > reconsider I suppose.

Something that I'd *really* love to see is usage of other bugzillas
xml-rpc interfaces, so that for eg, if someone files a Fedora bug
where some driver blows up, and I think it doesn't look like
it's caused by any patch in our tree, I'd love to click a button
in rh-bugzilla and have the bug automatically be also filed
in bugme.osdl, with the various comments mirrored back to the
originating bugzilla.

One of the problems faced by bug-reporters sometimes is that with
the multitude of bugzillas out there, and no cooperation between
them all, they don't know where to file their bug.
"My sound driver blew up, where do I file a bug"
bugzilla.redhat.com? bugme.osdl.org ? (in fact, I think the ALSA
folks have their own bugzilla if memory serves correctly)
[This demonstrates the problem -- even _I_ don't know, and I get a fair
 amount of alsa bug reports from end-users]

I've never actually looked into the xml-rpc implementation of bugzilla,
so my mental-image of how this stuff works may be grossly oversimplified,
but I've heard multiple folks claim this should be possible with some
scripting.  I've also heard people asking for the opposite.
"This bugme.osdl bug is present in RHEL/SLES/etc.. file a bug using
 xml-rpc in the various bugzillas so that it gets backported".

		Dave

