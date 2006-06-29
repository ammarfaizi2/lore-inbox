Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751752AbWF2Hay@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751752AbWF2Hay (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 29 Jun 2006 03:30:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751758AbWF2Hay
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 29 Jun 2006 03:30:54 -0400
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:9359 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S1751752AbWF2Hax (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 29 Jun 2006 03:30:53 -0400
Date: Thu, 29 Jun 2006 09:30:33 +0200
From: Pavel Machek <pavel@suse.cz>
To: Ulrich Drepper <drepper@gmail.com>
Cc: Arjan van de Ven <arjan@infradead.org>, Jason Baron <jbaron@redhat.com>,
       akpm@osdl.org, linux-kernel@vger.kernel.org
Subject: Re: make PROT_WRITE imply PROT_READ
Message-ID: <20060629073033.GF27526@elf.ucw.cz>
References: <449B42B3.6010908@shaw.ca> <Pine.LNX.4.64.0606230934360.24102@dhcp83-5.boston.redhat.com> <1151071581.3204.14.camel@laptopd505.fenrus.org> <Pine.LNX.4.64.0606231002150.24102@dhcp83-5.boston.redhat.com> <1151072280.3204.17.camel@laptopd505.fenrus.org> <a36005b50606241145q4d1dd17dg85f80e07fb582cdb@mail.gmail.com> <20060627095632.GA22666@elf.ucw.cz> <a36005b50606280943l54138e80tbda08e1607136792@mail.gmail.com> <20060628194913.GA18039@elf.ucw.cz> <a36005b50606281647i58f2899eo7ae7e95757969d42@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a36005b50606281647i58f2899eo7ae7e95757969d42@mail.gmail.com>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.11+cvs20060126
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed 2006-06-28 16:47:00, Ulrich Drepper wrote:
> On 6/28/06, Pavel Machek <pavel@ucw.cz> wrote:
> >mmap() behaviour always was platform-specific, and it happens to be
> >quite strange on i386. So what.
> 
> Nonsense.  The mmap semantics is specified in POSIX.  If something
> doesn't work as requested it is a bug.  For the specific issue hurting
> x86 and likely others the standard explicitly allows requiring
> PROT_READ to be used or implicitly adding it.  Don't confuse people
> with wrong statement like yours.

Can you quote part of POSIX where it says that PROT_WRITE must imply
PROT_READ?
								Pavel
-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
