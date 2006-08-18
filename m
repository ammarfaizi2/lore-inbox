Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751257AbWHRMfJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751257AbWHRMfJ (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 18 Aug 2006 08:35:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751263AbWHRMfJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 18 Aug 2006 08:35:09 -0400
Received: from moutng.kundenserver.de ([212.227.126.183]:38114 "EHLO
	moutng.kundenserver.de") by vger.kernel.org with ESMTP
	id S1751257AbWHRMfH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 18 Aug 2006 08:35:07 -0400
Date: Fri, 18 Aug 2006 14:31:14 +0200 (CEST)
From: Bodo Eggert <7eggert@gmx.de>
To: Arjan van de Ven <arjan@infradead.org>
cc: 7eggert@gmx.de, Lennart Sorensen <lsorense@csclub.uwaterloo.ca>,
       Dirk <noisyb@gmx.net>, linux-kernel@vger.kernel.org
Subject: Re: PATCH/FIX for drivers/cdrom/cdrom.c
In-Reply-To: <1155818138.4494.56.camel@laptopd505.fenrus.org>
Message-ID: <Pine.LNX.4.58.0608181428430.2760@be1.lrz>
References: <6Kxns-7AV-13@gated-at.bofh.it> <6Kytd-1g2-31@gated-at.bofh.it>
  <6KyCQ-1w7-25@gated-at.bofh.it>  <E1GDgyZ-0000jV-MV@be1.lrz>
 <1155818138.4494.56.camel@laptopd505.fenrus.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-be10.7eggert.dyndns.org-MailScanner-Information: See www.mailscanner.info for information
X-be10.7eggert.dyndns.org-MailScanner: Found to be clean
X-be10.7eggert.dyndns.org-MailScanner-From: 7eggert@web.de
X-Provags-ID: kundenserver.de abuse@kundenserver.de login:9b3b2cc444a07783f194c895a09f1de9
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 17 Aug 2006, Arjan van de Ven wrote:
> On Thu, 2006-08-17 at 14:27 +0200, Bodo Eggert wrote:

> > This will, however, not prevent other users from maliciously destroying the
> > CD by not using O_EXCL.
> 
> if the user wants to destroy his own burning cd... then why is it the
> kernels job to stop him?

It's user a destroying the CD of user b (e.g. because he erroneously 
believes his CD with the plain tar archive is in the burner, or because
he's simply malicious).
-- 
"Of course, as admin, I can read all your email. But I am not THAT bored!"
	-- unknown author in comp.unix.aix
