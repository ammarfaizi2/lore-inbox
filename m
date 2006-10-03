Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030470AbWJCSih@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030470AbWJCSih (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 3 Oct 2006 14:38:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030469AbWJCSih
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 3 Oct 2006 14:38:37 -0400
Received: from mail.aknet.ru ([82.179.72.26]:25360 "EHLO mail.aknet.ru")
	by vger.kernel.org with ESMTP id S1030470AbWJCSig (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 3 Oct 2006 14:38:36 -0400
Message-ID: <4522AEA1.5060304@aknet.ru>
Date: Tue, 03 Oct 2006 22:40:33 +0400
From: Stas Sergeev <stsp@aknet.ru>
User-Agent: Thunderbird 1.5.0.7 (X11/20060913)
MIME-Version: 1.0
To: Arjan van de Ven <arjan@infradead.org>
Cc: Linux kernel <linux-kernel@vger.kernel.org>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>, Hugh Dickins <hugh@veritas.com>,
       Ulrich Drepper <drepper@redhat.com>, Valdis.Kletnieks@vt.edu
Subject: Re: [patch] remove MNT_NOEXEC check for PROT_EXEC mmaps
References: <45150CD7.4010708@aknet.ru>	 <Pine.LNX.4.64.0609231555390.27012@blonde.wat.veritas.com>	 <451555CB.5010006@aknet.ru>	 <Pine.LNX.4.64.0609231647420.29557@blonde.wat.veritas.com>	 <1159037913.24572.62.camel@localhost.localdomain>	 <45162BE5.2020100@aknet.ru>	 <1159106032.11049.12.camel@localhost.localdomain>	 <45169C0C.5010001@aknet.ru> <4516A8E3.4020100@redhat.com>	 <4516B2C8.4050202@aknet.ru> <4516B721.5070801@redhat.com>	 <45198395.4050008@aknet.ru>	 <1159396436.3086.51.camel@laptopd505.fenrus.org> <451E3C0C.10105@aknet.ru>	 <1159887682.2891.537.camel@laptopd505.fenrus.org>	 <45229A99.6060703@aknet.ru> <1159899820.2891.542.camel@laptopd505.fenrus.org>
In-Reply-To: <1159899820.2891.542.camel@laptopd505.fenrus.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello.

Arjan van de Ven wrote:
> you do "noexec" and then complain that executing (!!) windows binaries
> from that gets more of a problem!
It only became slower and more memory-consuming -
is this really what you wanted to achieve?
Also, you haven't commented on the other points,
namely, the problem of getting a shm with an exec
permission, and the current limitation of an ld.so
fix (and the solution to it).

