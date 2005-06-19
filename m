Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261443AbVFSCzC@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261443AbVFSCzC (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 18 Jun 2005 22:55:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261502AbVFSCzC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 18 Jun 2005 22:55:02 -0400
Received: from smtpout.mac.com ([17.250.248.88]:51658 "EHLO smtpout.mac.com")
	by vger.kernel.org with ESMTP id S261443AbVFSCy5 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 18 Jun 2005 22:54:57 -0400
In-Reply-To: <20050618191341.GA30620@redhat.com>
References: <20050617001330.294950ac.akpm@osdl.org> <1119016223.5049.3.camel@mulgrave> <20050617142225.GO6957@suse.de> <20050617141003.2abdd8e5.akpm@osdl.org> <20050617212338.GA16852@suse.de> <491950000.1119044739@flay> <20050618191341.GA30620@redhat.com>
Mime-Version: 1.0 (Apple Message framework v728)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <265EC713-9745-484D-8FF0-1C8D5FFE94F1@mac.com>
Cc: "Martin J. Bligh" <mbligh@mbligh.org>, Jens Axboe <axboe@suse.de>,
       Andrew Morton <akpm@osdl.org>, James.Bottomley@SteelEye.com,
       linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 7bit
From: Kyle Moffett <mrmacman_g4@mac.com>
Subject: Re: kernel bugzilla
Date: Sat, 18 Jun 2005 22:54:33 -0400
To: Dave Jones <davej@redhat.com>
X-Mailer: Apple Mail (2.728)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Jun 18, 2005, at 15:13:41, Dave Jones wrote:
> On Fri, Jun 17, 2005 at 02:45:39PM -0700, Martin J. Bligh wrote:
>> The external one is infintely simpler than the internal IBM one, and
>> the distro ones. I *really, really* prefer to keep it that way.  
>> Having
>> said that, it does have a few fields (eg version, and
>> category/subcategory) that should be filled out properly, and that's
>> not easy to do via email.
>> For now, my intent is to allow bug filing via web only, and followup
>> comments by email. If lots of people scream and curse at me, I'll
>> reconsider I suppose.
>
> Something that I'd *really* love to see is usage of other bugzillas
> xml-rpc interfaces, so that for eg, if someone files a Fedora bug
> where some driver blows up, and I think it doesn't look like
> it's caused by any patch in our tree, I'd love to click a button
> in rh-bugzilla and have the bug automatically be also filed
> in bugme.osdl, with the various comments mirrored back to the
> originating bugzilla.

Another wishlist feature I've seen is to have a mailing list archiver
attached to bugzilla that receives and stores the last month worth of
emails on the list.  At any time someone can login and:
     o  Bind an archived email to a bugzilla bug-report
     o  Create a new bugzilla bug-report from an archived email (with
        extra fields specified by the user).
     o  Add an archived followup email in a thread to the bug-report.

Once an email is bound, it is marked for permanent storage in bugzilla
(as opposed to the temporary one month storage for all emails).

The first time the "create" or "bind" options are selected for a given
thread, a post would be sent to the list indicating the bind, from the
bugzilla address for that bug.  Any followup posts that CC that address
will automatically be included in the bug database.  It seems that would
allow users to quickly and easily tie the bug database to the email
archive, although I could very easily be missing something here.

Cheers,
Kyle Moffett

-----BEGIN GEEK CODE BLOCK-----
Version: 3.12
GCM/CS/IT/U d- s++: a18 C++++>$ UB/L/X/*++++(+)>$ P+++(++++)>$
L++++(+++) E W++(+) N+++(++) o? K? w--- O? M++ V? PS+() PE+(-) Y+
PGP+++ t+(+++) 5 X R? tv-(--) b++++(++) DI+ D+ G e->++++$ h!*()>++$  
r  !y?(-)
------END GEEK CODE BLOCK------

