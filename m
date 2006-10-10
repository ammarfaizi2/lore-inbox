Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932198AbWJJTI0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932198AbWJJTI0 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 10 Oct 2006 15:08:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932240AbWJJTI0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 10 Oct 2006 15:08:26 -0400
Received: from nf-out-0910.google.com ([64.233.182.191]:42078 "EHLO
	nf-out-0910.google.com") by vger.kernel.org with ESMTP
	id S932198AbWJJTIZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 10 Oct 2006 15:08:25 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:subject:from:to:cc:in-reply-to:references:content-type:date:message-id:mime-version:x-mailer:content-transfer-encoding;
        b=sxrs23Uw3je4vpgoFprwULHtrt4rubqfad+QYSccIXzgbcLCGdzsilTO7XkqCggtCTU4pdwF+CgqUffNxGVHhbDKgfJ7YdH1ib2mnwZQKBvHBm1YqMsgCuw92bJSmUjE9dbLi1HOo78CBX8E10h9OW8U7s1duu2ahSpiC+BHIAY=
Subject: Re: 2.6.18 suspend regression on Intel Macs
From: =?ISO-8859-1?Q?Fr=E9d=E9ric?= Riss <frederic.riss@gmail.com>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Arjan van de Ven <arjan@infradead.org>, Pavel Machek <pavel@ucw.cz>,
       Linux Kernel list <linux-kernel@vger.kernel.org>, len.brown@intel.com
In-Reply-To: <Pine.LNX.4.64.0610100830370.3952@g5.osdl.org>
References: <1160417982.5142.45.camel@funkylaptop>
	 <20061010103910.GD31598@elf.ucw.cz>
	 <1160476889.3000.282.camel@laptopd505.fenrus.org>
	 <Pine.LNX.4.64.0610100830370.3952@g5.osdl.org>
Content-Type: text/plain; charset=utf-8
Date: Tue, 10 Oct 2006 21:08:15 +0200
Message-Id: <1160507296.5134.4.camel@funkylaptop>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.1 
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Le mardi 10 octobre 2006 à 08:33 -0700, Linus Torvalds a écrit :
> > If we do this we probably should at least key this of some DMI
> > identification for the mac mini..
> 
> No. That would be silly.
> 
> Having _conditional_ code is not only bigger, it's orders of magnitude 
> more complex and likely to break. It's much better to say: "We know at 
> least one machine needs this" than it is to say "We know machine X needs 
> this", because the latter has extra complexity that just doesn't buy you 
> anything.
> 
> It's much better to treat everybody the same, if that works. That way, you 
> don't have different code-paths.

So what's the plan? Should/Will the ACPI guys remove the bit-preserving
change brought in with the latest ACPICA merge?

Fred.

