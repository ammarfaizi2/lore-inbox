Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964898AbWJCSXt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964898AbWJCSXt (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 3 Oct 2006 14:23:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964899AbWJCSXs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 3 Oct 2006 14:23:48 -0400
Received: from pentafluge.infradead.org ([213.146.154.40]:56026 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S964898AbWJCSXr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 3 Oct 2006 14:23:47 -0400
Subject: Re: [patch] remove MNT_NOEXEC check for PROT_EXEC mmaps
From: Arjan van de Ven <arjan@infradead.org>
To: Stas Sergeev <stsp@aknet.ru>
Cc: Linux kernel <linux-kernel@vger.kernel.org>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>, Hugh Dickins <hugh@veritas.com>,
       Ulrich Drepper <drepper@redhat.com>, Valdis.Kletnieks@vt.edu
In-Reply-To: <45229A99.6060703@aknet.ru>
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
Content-Type: text/plain
Organization: Intel International BV
Date: Tue, 03 Oct 2006 20:23:39 +0200
Message-Id: <1159899820.2891.542.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <arjan@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>  point. :)
> 
> > What breaks?
> You missed the beginning of the discussion, but briefly:
> http://bugs.debian.org/cgi-bin/bugreport.cgi?bug=386945
> ... breaks UML and dosemu.
> Also I speculate that it makes Wine slower causing it to
> fallback to read() if the windows partition is mounted with
> "noexec" (which I think is/was common). In that case people
> will never figure out why Wine suddenly became slower and
> more memory-consuming than before.

BUT THIS IS MADNESS!

you do "noexec" and then complain that executing (!!) windows binaries
from that gets more of a problem!

> 
-- 
if you want to mail me at work (you don't), use arjan (at) linux.intel.com

