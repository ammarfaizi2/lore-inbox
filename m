Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932366AbWCARN7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932366AbWCARN7 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Mar 2006 12:13:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751493AbWCARN7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Mar 2006 12:13:59 -0500
Received: from liaag2ad.mx.compuserve.com ([149.174.40.155]:8352 "EHLO
	liaag2ad.mx.compuserve.com") by vger.kernel.org with ESMTP
	id S1751402AbWCARN6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Mar 2006 12:13:58 -0500
Date: Wed, 1 Mar 2006 12:10:27 -0500
From: Chuck Ebbert <76306.1226@compuserve.com>
Subject: Re: [patch] i386: port ATI timer fix from x86_64 to i386
To: Andi Kleen <ak@suse.de>
Cc: Andrew Morton <akpm@osdl.org>, Linus Torvalds <torvalds@osdl.org>,
       linux-kernel <linux-kernel@vger.kernel.org>
Message-ID: <200603011213_MC3-1-B998-965E@compuserve.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Type: text/plain;
	 charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In-Reply-To: <p73psl6zbwf.fsf@verdi.suse.de>

On 01 Mar 2006 11:40:00, Andi Kleen wrote:

> > Wonderful, thanks.  What's the relationship (if any) between this and the
> > recently-merged x86_64 fix?
>
> He just ported the x86-64 change over without any original authorship
> attribution :/

Oops, sorry about that.  Since I wrote "ported from x86_64" I assumed
credit was implicit.

> And some less functionality (only works for ACPI now)

I documented that. Without ACPI there wasn't infrastructure to do the early
PCI scan.

> and some totally unrelated Documentation cleanup

I added the two new boot options.  While doing that I noticed the *timer_pin_1
docs weren't in alphabetical order so I moved them.

> and a few random printk changes

One printk change.  The other was an exact port of the message from x86_64.
And the change I made wasn't random.  It might have been a bad idea but
it wasn't random.


-- 
Chuck
"The sleet in Crete falls neatly in the street."

