Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030569AbWJJWKA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030569AbWJJWKA (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 10 Oct 2006 18:10:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030571AbWJJWKA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 10 Oct 2006 18:10:00 -0400
Received: from ug-out-1314.google.com ([66.249.92.170]:12493 "EHLO
	ug-out-1314.google.com") by vger.kernel.org with ESMTP
	id S1030573AbWJJWJ7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 10 Oct 2006 18:09:59 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:subject:from:to:cc:in-reply-to:references:content-type:date:message-id:mime-version:x-mailer:content-transfer-encoding;
        b=pbx3Nh8ccYecHTB//xazpAl+aBBwDG1JjDhS5hIvJkdnDghfdIsWzC8i36lQCkNJu3BrAIhvIX7m3SIt+N0zquhD4LG6hsJoAjVhIXwrLKQa5m4532h44CzhMyPe5SRGJcBKwrdM3S8X3dxKsMVTWUjFoYlBOEBXoGtLRpHnLzw=
Subject: Re: 2.6.18 suspend regression on Intel Macs
From: =?ISO-8859-1?Q?Fr=E9d=E9ric?= Riss <frederic.riss@gmail.com>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Pavel Machek <pavel@ucw.cz>, Arjan van de Ven <arjan@infradead.org>,
       Linux Kernel list <linux-kernel@vger.kernel.org>, len.brown@intel.com
In-Reply-To: <Pine.LNX.4.64.0610101447270.3952@g5.osdl.org>
References: <1160417982.5142.45.camel@funkylaptop>
	 <20061010103910.GD31598@elf.ucw.cz>
	 <1160476889.3000.282.camel@laptopd505.fenrus.org>
	 <Pine.LNX.4.64.0610100830370.3952@g5.osdl.org>
	 <1160507296.5134.4.camel@funkylaptop>
	 <1160509121.3000.327.camel@laptopd505.fenrus.org>
	 <1160509584.5134.11.camel@funkylaptop> <20061010195022.GA32134@elf.ucw.cz>
	 <Pine.LNX.4.64.0610101447270.3952@g5.osdl.org>
Content-Type: text/plain; charset=utf-8
Date: Wed, 11 Oct 2006 00:09:55 +0200
Message-Id: <1160518195.5134.38.camel@funkylaptop>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.1 
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Le mardi 10 octobre 2006 à 14:49 -0700, Linus Torvalds a écrit :
> 
> On Tue, 10 Oct 2006, Pavel Machek wrote:
> > 
> > Maybe you can just create a patch that modifies ACPI not to mask the
> > SCI bit? Reverting big chunk of ACPI code is likely not the right
> > solution.
> 
> I'm going to apply this after I've confirmed that it fixes the Mac Mini.

I was about to send a patch doing exactly the same. It fixes the issue
for me. Thanks.

Fred.

