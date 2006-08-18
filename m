Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030219AbWHRMyL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030219AbWHRMyL (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 18 Aug 2006 08:54:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751266AbWHRMyL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 18 Aug 2006 08:54:11 -0400
Received: from pentafluge.infradead.org ([213.146.154.40]:62665 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S1751263AbWHRMyK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 18 Aug 2006 08:54:10 -0400
Subject: Re: PATCH/FIX for drivers/cdrom/cdrom.c
From: Arjan van de Ven <arjan@infradead.org>
To: Bodo Eggert <7eggert@gmx.de>
Cc: Lennart Sorensen <lsorense@csclub.uwaterloo.ca>, Dirk <noisyb@gmx.net>,
       linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.58.0608181428430.2760@be1.lrz>
References: <6Kxns-7AV-13@gated-at.bofh.it> <6Kytd-1g2-31@gated-at.bofh.it>
	 <6KyCQ-1w7-25@gated-at.bofh.it>  <E1GDgyZ-0000jV-MV@be1.lrz>
	 <1155818138.4494.56.camel@laptopd505.fenrus.org>
	 <Pine.LNX.4.58.0608181428430.2760@be1.lrz>
Content-Type: text/plain
Organization: Intel International BV
Date: Fri, 18 Aug 2006 14:53:44 +0200
Message-Id: <1155905624.4494.181.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <arjan@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2006-08-18 at 14:31 +0200, Bodo Eggert wrote:
> On Thu, 17 Aug 2006, Arjan van de Ven wrote:
> > On Thu, 2006-08-17 at 14:27 +0200, Bodo Eggert wrote:
> 
> > > This will, however, not prevent other users from maliciously destroying the
> > > CD by not using O_EXCL.
> > 
> > if the user wants to destroy his own burning cd... then why is it the
> > kernels job to stop him?
> 
> It's user a destroying the CD of user b (e.g. because he erroneously 
> believes his CD with the plain tar archive is in the burner, or because
> he's simply malicious).

that would only be if both A and B have write access to the same device,
at which point they can destroy eachother anyway
(nothing stops user B from issuing a blank command to the cdrw the
milisecond A is done)


-- 
if you want to mail me at work (you don't), use arjan (at) linux.intel.com

