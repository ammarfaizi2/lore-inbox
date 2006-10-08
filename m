Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750930AbWJHIcy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750930AbWJHIcy (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 8 Oct 2006 04:32:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750933AbWJHIcy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 8 Oct 2006 04:32:54 -0400
Received: from pentafluge.infradead.org ([213.146.154.40]:3740 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S1750926AbWJHIcx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 8 Oct 2006 04:32:53 -0400
Subject: Re: [patch] honour MNT_NOEXEC for access()
From: Arjan van de Ven <arjan@infradead.org>
To: Stas Sergeev <stsp@aknet.ru>
Cc: Ulrich Drepper <drepper@redhat.com>, Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Jakub Jelinek <jakub@redhat.com>,
       Linux kernel <linux-kernel@vger.kernel.org>,
       Hugh Dickins <hugh@veritas.com>
In-Reply-To: <4527FC8B.8010208@aknet.ru>
References: <4516B721.5070801@redhat.com> <45198395.4050008@aknet.ru>
	 <1159396436.3086.51.camel@laptopd505.fenrus.org> <451E3C0C.10105@aknet.ru>
	 <1159887682.2891.537.camel@laptopd505.fenrus.org>
	 <45229A99.6060703@aknet.ru>
	 <1159899820.2891.542.camel@laptopd505.fenrus.org>
	 <4522AEA1.5060304@aknet.ru>
	 <1159900934.2891.548.camel@laptopd505.fenrus.org>
	 <4522B4F9.8000301@aknet.ru>
	 <20061003210037.GO20982@devserv.devel.redhat.com>
	 <45240640.4070104@aknet.ru>  <45269BEE.7050008@aknet.ru>
	 <1160170464.12835.4.camel@localhost.localdomain>
	 <4526C7F4.6090706@redhat.com> <45278D2A.4020605@aknet.ru>
	 <4527D64A.7060002@redhat.com>  <4527FC8B.8010208@aknet.ru>
Content-Type: text/plain
Organization: Intel International BV
Date: Sun, 08 Oct 2006 10:32:44 +0200
Message-Id: <1160296364.3000.167.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <arjan@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2006-10-07 at 23:14 +0400, Stas Sergeev wrote:
> Hello.
> 
> Ulrich Drepper wrote:
> >> Now, as the access(X_OK) is fixed, would it be
> >> feasible for ld.so to start using it?
> > Just must be kidding.  No access control can be reliably implemented at
> > userlevel.  There is no point starting something as stupid as this.
> But in this case how can you ever solve the
> problem of ld.so executing the binaries for which
> the user does not have an exec permission?
> Yes, the userspace apps usually should not enforce
> the kernel's access control,

correct

>  but ld.so seems to be
> the special case - it is a kernel helper after all,

in what way is ld.so special in ANY way?

-- 
if you want to mail me at work (you don't), use arjan (at) linux.intel.com

