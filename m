Return-Path: <linux-kernel-owner+w=401wt.eu-S1751952AbWLNSWH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751952AbWLNSWH (ORCPT <rfc822;w@1wt.eu>);
	Thu, 14 Dec 2006 13:22:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751970AbWLNSWH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 14 Dec 2006 13:22:07 -0500
Received: from tmailer.gwdg.de ([134.76.10.23]:46696 "EHLO tmailer.gwdg.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751956AbWLNSWG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 14 Dec 2006 13:22:06 -0500
Date: Thu, 14 Dec 2006 19:09:51 +0100 (MET)
From: Jan Engelhardt <jengelh@linux01.gwdg.de>
To: Chris Wedgwood <cw@f00f.org>
cc: Christoph Hellwig <hch@infradead.org>, Linus Torvalds <torvalds@osdl.org>,
       Jeff Garzik <jeff@garzik.org>, Greg KH <gregkh@suse.de>,
       Jonathan Corbet <corbet@lwn.net>, Andrew Morton <akpm@osdl.org>,
       Martin Bligh <mbligh@mbligh.org>,
       "Michael K. Edwards" <medwards.linux@gmail.com>,
       linux-kernel@vger.kernel.org
Subject: Re: GPL only modules [was Re: [GIT PATCH] more Driver core patches
 for 2.6.19]
In-Reply-To: <20061214175253.GB12498@tuatara.stupidest.org>
Message-ID: <Pine.LNX.4.61.0612141907450.12730@yvahk01.tjqt.qr>
References: <20061214003246.GA12162@suse.de> <22299.1166057009@lwn.net>
 <20061214005532.GA12790@suse.de> <Pine.LNX.4.64.0612131954530.5718@woody.osdl.org>
 <458171C1.3070400@garzik.org> <Pine.LNX.4.64.0612140855250.5718@woody.osdl.org>
 <20061214170841.GA11196@tuatara.stupidest.org> <20061214173827.GC3452@infradead.org>
 <20061214175253.GB12498@tuatara.stupidest.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Spam-Report: Content analysis: 0.0 points, 6.0 required
	_SUMMARY_
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Dec 14 2006 09:52, Chris Wedgwood wrote:
>On Thu, Dec 14, 2006 at 05:38:27PM +0000, Christoph Hellwig wrote:
>
>> Yes, EXPORT_SYMBOL_INTERNAL would make a lot more sense.
>
>A quick grep shows that changing this now would require updating
>nearly 1900 instances, so patches to do this would be pretty large and
>disruptive (though we could support both during a transition and
>migrate them over time).

I'd prefer to do it at once. But that's not my decision so you anyway do what
you want.

That said, I would like to keep EXPORT_SYMBOL_GPL, because EXPORT and INTERNAL
is somehow contrary. Just a wording issue.

	-`J'
-- 
