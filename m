Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261646AbULNU0N@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261646AbULNU0N (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Dec 2004 15:26:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261647AbULNU0N
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Dec 2004 15:26:13 -0500
Received: from ns.suse.de ([195.135.220.2]:60882 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id S261646AbULNU0K (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Dec 2004 15:26:10 -0500
To: Linus Torvalds <torvalds@osdl.org>
Cc: Sam Ravnborg <sam@ravnborg.org>, Horst von Brand <vonbrand@inf.utfsm.cl>,
       Werner Almesberger <wa@almesberger.net>,
       Paul Mackerras <paulus@samba.org>, Greg KH <greg@kroah.com>,
       David Woodhouse <dwmw2@infradead.org>, Matthew Wilcox <matthew@wil.cx>,
       David Howells <dhowells@redhat.com>, hch@infradead.org,
       aoliva@redhat.com, linux-kernel@vger.kernel.org,
       libc-hacker@sources.redhat.com
Subject: Re: [RFC] Splitting kernel headers and deprecating __KERNEL__
References: <20041214135029.A1271@almesberger.net>
	<200412141923.iBEJNCY9011317@laptop11.inf.utfsm.cl>
	<20041214194531.GB13811@mars.ravnborg.org>
	<Pine.LNX.4.58.0412141150460.3279@ppc970.osdl.org>
From: Andreas Schwab <schwab@suse.de>
X-Yow: Mmmmmm-MMMMMM!!  A plate of STEAMING PIECES of a PIG mixed
 with the shreds of SEVERAL CHICKENS!!...  Oh BOY!!  I'm
 about to swallow a TORN-OFF section of a COW'S LEFT LEG
 soaked in COTTONSEED OIL and SUGAR!!  ..  Let's see..
 Next, I'll have the GROUND-UP flesh of CUTE, BABY LAMBS
 fried in the MELTED, FATTY TISSUES from a warm-blooded
 animal someone once PETTED!!  ...  YUM!!  That was GOOD!!
 For DESSERT, I'll have a TOFU BURGER with BEAN SPROUTS
 on a stone-ground, WHOLE WHEAT BUN!!
Date: Tue, 14 Dec 2004 21:25:46 +0100
In-Reply-To: <Pine.LNX.4.58.0412141150460.3279@ppc970.osdl.org> (Linus
 Torvalds's message of "Tue, 14 Dec 2004 11:58:47 -0800 (PST)")
Message-ID: <jer7lsocdx.fsf@sykes.suse.de>
User-Agent: Gnus/5.110002 (No Gnus v0.2) Emacs/21.3.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus Torvalds <torvalds@osdl.org> writes:

> We used to compile with "-nostdinc" to make sure that you couldn't include 
> user files even by mistake, but that was removed for some reason I can't 
> for the life of me remember any more.

??? We still do that, see NOSTDINC_FLAGS.

Andreas.

-- 
Andreas Schwab, SuSE Labs, schwab@suse.de
SuSE Linux Products GmbH, Maxfeldstraße 5, 90409 Nürnberg, Germany
Key fingerprint = 58CA 54C7 6D53 942B 1756  01D3 44D5 214B 8276 4ED5
"And now for something completely different."
