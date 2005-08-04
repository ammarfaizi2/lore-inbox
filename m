Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262684AbVHDXOG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262684AbVHDXOG (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 4 Aug 2005 19:14:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262629AbVHDXMC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 4 Aug 2005 19:12:02 -0400
Received: from e35.co.us.ibm.com ([32.97.110.133]:24821 "EHLO
	e35.co.us.ibm.com") by vger.kernel.org with ESMTP id S262728AbVHDXKb
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 4 Aug 2005 19:10:31 -0400
Date: Thu, 04 Aug 2005 16:10:28 -0700
From: "Martin J. Bligh" <Martin.Bligh@us.ibm.com>
To: Hugh Dickins <hugh@veritas.com>, Andi Kleen <ak@suse.de>
cc: Danny ter Haar <dth@picard.cistron.nl>, Pavel Roskin <proski@gnu.org>,
       linux-kernel@vger.kernel.org
Subject: Re: 2.6.13-rc5-git2 does not boot on (my) amd64
Message-ID: <113800000.1123197027@[10.10.2.4]>
In-Reply-To: <Pine.LNX.4.61.0508042358530.8665@goblin.wat.veritas.com>
References: <dctuso$tl$1@news.cistron.nl.suse.lists.linux.kernel><p73iryl73nm.fsf@bragg.suse.de> <Pine.LNX.4.61.0508042358530.8665@goblin.wat.veritas.com>
X-Mailer: Mulberry/2.2.1 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



--Hugh Dickins <hugh@veritas.com> wrote (on Friday, August 05, 2005 00:06:25 +0100):

> On Thu, 5 Aug 2005, Andi Kleen wrote:
>> dth@picard.cistron.nl (Danny ter Haar) writes:
>> > 
>> > Freeing unused kernel memory: 248k freed
>> > VM: killing process hotplug
>> > VM: killing process hotplug
>> > VM: killing process hotplug
>> > VM: killing process hotplug
>> > Unable to handle kernel paging request at fffffff28017b5be RIP:
>> > [<fffffff28017b5be>]
>> 
>> Looks weird. Just to make sure can you do a make distclean and try
>> again? It might be a bad compile.
> 
> No, like Pavel's and Martin's reports, this is just an effect
> of the not-quite-fully-baked do_wp_page/get_user_pages race fix in
> 2.6.13-rc5-git2, which AlexN reported earlier.  Should now be fully
> fixed in Linus' current git, and in the 2.6.13-rc6 akpm prophesies
> to be coming soon - please all test that.

OK, nightly builds tests should auto-appear on http://test.kernel.org
tommorow morning. I'll try to remember to look for it; if you remember
before I wake up Hugh, should be published there ... ;-)

Thanks for the feedback,

M
