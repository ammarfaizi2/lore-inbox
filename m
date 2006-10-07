Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750867AbWJGLQ6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750867AbWJGLQ6 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 7 Oct 2006 07:16:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750876AbWJGLQ6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 7 Oct 2006 07:16:58 -0400
Received: from mail.aknet.ru ([82.179.72.26]:17423 "EHLO mail.aknet.ru")
	by vger.kernel.org with ESMTP id S1750848AbWJGLQ5 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 7 Oct 2006 07:16:57 -0400
Message-ID: <45278D2A.4020605@aknet.ru>
Date: Sat, 07 Oct 2006 15:19:06 +0400
From: Stas Sergeev <stsp@aknet.ru>
User-Agent: Thunderbird 1.5.0.7 (X11/20060913)
MIME-Version: 1.0
To: Ulrich Drepper <drepper@redhat.com>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, Jakub Jelinek <jakub@redhat.com>,
       Arjan van de Ven <arjan@infradead.org>,
       Linux kernel <linux-kernel@vger.kernel.org>,
       Hugh Dickins <hugh@veritas.com>, Jesper Juhl <jesper.juhl@gmail.com>
Subject: Re: [patch] honour MNT_NOEXEC for access()
References: <4516B721.5070801@redhat.com> <45198395.4050008@aknet.ru>	 <1159396436.3086.51.camel@laptopd505.fenrus.org> <451E3C0C.10105@aknet.ru>	 <1159887682.2891.537.camel@laptopd505.fenrus.org>	 <45229A99.6060703@aknet.ru>	 <1159899820.2891.542.camel@laptopd505.fenrus.org>	 <4522AEA1.5060304@aknet.ru>	 <1159900934.2891.548.camel@laptopd505.fenrus.org>	 <4522B4F9.8000301@aknet.ru>	 <20061003210037.GO20982@devserv.devel.redhat.com>	 <45240640.4070104@aknet.ru>  <45269BEE.7050008@aknet.ru> <1160170464.12835.4.camel@localhost.localdomain> <4526C7F4.6090706@redhat.com>
In-Reply-To: <4526C7F4.6090706@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello.

Ulrich Drepper пишет:
> The change itself is conceptually correct.  I haven't looked at the
> technical details but it looks OK.
Thankyou. Finally this seemingly hopeless thread
started to yield the positive results. :)

Now, as the access(X_OK) is fixed, would it be
feasible for ld.so to start using it?

