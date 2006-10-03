Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030254AbWJCTy4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030254AbWJCTy4 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 3 Oct 2006 15:54:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030237AbWJCTyz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 3 Oct 2006 15:54:55 -0400
Received: from pentafluge.infradead.org ([213.146.154.40]:47003 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S1030254AbWJCTyy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 3 Oct 2006 15:54:54 -0400
Subject: Re: [patch] remove MNT_NOEXEC check for PROT_EXEC mmaps
From: Arjan van de Ven <arjan@infradead.org>
To: Stas Sergeev <stsp@aknet.ru>
Cc: Ulrich Drepper <drepper@redhat.com>,
       Linux kernel <linux-kernel@vger.kernel.org>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>, Hugh Dickins <hugh@veritas.com>,
       Valdis.Kletnieks@vt.edu
In-Reply-To: <4522BCBF.2050508@aknet.ru>
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
	 <45229A99.6060703@aknet.ru> <45229C8E.6080503@redhat.com>
	 <4522A691.7070700@aknet.ru> <4522B7CD.4040206@redhat.com>
	 <4522BCBF.2050508@aknet.ru>
Content-Type: text/plain
Organization: Intel International BV
Date: Tue, 03 Oct 2006 21:54:25 +0200
Message-Id: <1159905265.2891.551.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <arjan@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2006-10-03 at 23:40 +0400, Stas Sergeev wrote:
> Hello.
> 
> Ulrich Drepper wrote:
> > You really don't get it, do you.
> Yes, sorry. :)
> 
> > The way ld.so works can be implemented
> > in many other forms with other programs.
> Having "noexec" (in its older form) on *every* user-writable
> mount makes it harder for an attacker to run his own loaders,
> so implementing it in other forms was useless in the past.
> 
> > With some time and energy you
> > likely can write a perl or python script to do it.
> This is solvable the same way too - "chmod 'o-x' perl"

and chmod o-x bash ....
at which point.. game over.
(and yes you can do in bash pretty much what you can do in perl. heck
you can prove that.. shell is turning complete ;)


