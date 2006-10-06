Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422955AbWJFVI6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422955AbWJFVI6 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 6 Oct 2006 17:08:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422959AbWJFVI6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 6 Oct 2006 17:08:58 -0400
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:63885 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP
	id S1422955AbWJFVI5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 6 Oct 2006 17:08:57 -0400
Subject: Re: [patch] honour MNT_NOEXEC for access()
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Stas Sergeev <stsp@aknet.ru>
Cc: Andrew Morton <akpm@osdl.org>, Jakub Jelinek <jakub@redhat.com>,
       Arjan van de Ven <arjan@infradead.org>,
       Linux kernel <linux-kernel@vger.kernel.org>,
       Hugh Dickins <hugh@veritas.com>, Ulrich Drepper <drepper@redhat.com>
In-Reply-To: <45269BEE.7050008@aknet.ru>
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
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Fri, 06 Oct 2006 22:34:24 +0100
Message-Id: <1160170464.12835.4.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.2 (2.6.2-1.fc5.5) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ar Gwe, 2006-10-06 am 22:09 +0400, ysgrifennodd Stas Sergeev:
> Hi Andrew.
> 
> The attached patch makes the access(X_OK) to take the
> "noexec" mount option into an account.
> 
> Signed-off-by: Stas Sergeev <stsp@aknet.ru>
> CC: Jakub Jelinek <jakub@redhat.com>
> CC: Arjan van de Ven <arjan@infradead.org>
> CC: Alan Cox <alan@lxorguk.ukuu.org.uk>

I doubt anyone uses access() any more for anything but this doesn't seem
to conflict with the POSIX spec.


