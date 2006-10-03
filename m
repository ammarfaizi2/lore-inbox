Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030262AbWJCSmi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030262AbWJCSmi (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 3 Oct 2006 14:42:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030472AbWJCSmi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 3 Oct 2006 14:42:38 -0400
Received: from pentafluge.infradead.org ([213.146.154.40]:46295 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S1030458AbWJCSmg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 3 Oct 2006 14:42:36 -0400
Subject: Re: [patch] remove MNT_NOEXEC check for PROT_EXEC mmaps
From: Arjan van de Ven <arjan@infradead.org>
To: Stas Sergeev <stsp@aknet.ru>
Cc: Linux kernel <linux-kernel@vger.kernel.org>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>, Hugh Dickins <hugh@veritas.com>,
       Ulrich Drepper <drepper@redhat.com>, Valdis.Kletnieks@vt.edu
In-Reply-To: <4522AEA1.5060304@aknet.ru>
References: <45150CD7.4010708@aknet.ru>
	 <Pine.LNX.4.64.0609231555390.27012@blonde.wat.veritas.com>
	 <451555CB.5010006@aknet.ru>
	 <Pine.LNX.4.64.0609231647420.29557@blonde.wat.veritas.com>
	 <1159037913.24572.62.camel@localhost.localdomain>
	 <45162BE5.2020100@aknet.ru>
	 <1159106032.11049.12.camel@localhost.localdomain>
	 <45169C0C.5010001@aknet.ru> <4516A8E3.4020100@redhat.com>
	 <4516B2C8.4050202@aknet.ru> <4516B721.5070801@redhat.com>
	 <45198395.4050008@aknet.ru>
	 <1159396436.3086.51.camel@laptopd505.fenrus.org> <451E3C0C.10105@aknet.ru>
	 <1159887682.2891.537.camel@laptopd505.fenrus.org>
	 <45229A99.6060703@aknet.ru>
	 <1159899820.2891.542.camel@laptopd505.fenrus.org>
	 <4522AEA1.5060304@aknet.ru>
Content-Type: text/plain
Organization: Intel International BV
Date: Tue, 03 Oct 2006 20:42:14 +0200
Message-Id: <1159900934.2891.548.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <arjan@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2006-10-03 at 22:40 +0400, Stas Sergeev wrote:
> Hello.
> 
> Arjan van de Ven wrote:
> > you do "noexec" and then complain that executing (!!) windows binaries
> > from that gets more of a problem!
> It only became slower and more memory-consuming -
> is this really what you wanted to achieve?
> Also, you haven't commented on the other points,
> namely, the problem of getting a shm with an exec

then don't put noexec on /dev/shm.

> permission, and the current limitation of an ld.so
> fix (and the solution to it).

ld.so fix is phony. Really; I can always put an "unfixed" ld.so there
and use it as user. 

-- 
if you want to mail me at work (you don't), use arjan (at) linux.intel.com

