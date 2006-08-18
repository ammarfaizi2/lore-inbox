Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932452AbWHRMpo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932452AbWHRMpo (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 18 Aug 2006 08:45:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932458AbWHRMpo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 18 Aug 2006 08:45:44 -0400
Received: from moutng.kundenserver.de ([212.227.126.171]:56258 "EHLO
	moutng.kundenserver.de") by vger.kernel.org with ESMTP
	id S932452AbWHRMpn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 18 Aug 2006 08:45:43 -0400
Date: Fri, 18 Aug 2006 14:39:38 +0200 (CEST)
From: Bodo Eggert <7eggert@gmx.de>
To: Helge Hafting <helge.hafting@aitel.hist.no>
cc: Lennart Sorensen <lsorense@csclub.uwaterloo.ca>,
       Jeff Garzik <jeff@garzik.org>, Alan Cox <alan@lxorguk.ukuu.org.uk>,
       7eggert@gmx.de, Arjan van de Ven <arjan@infradead.org>,
       Dirk <noisyb@gmx.net>, linux-kernel@vger.kernel.org
Subject: Re: PATCH/FIX for drivers/cdrom/cdrom.c
In-Reply-To: <44E47F54.3000300@aitel.hist.no>
Message-ID: <Pine.LNX.4.58.0608181431500.2760@be1.lrz>
References: <6Kxns-7AV-13@gated-at.bofh.it> <6Kytd-1g2-31@gated-at.bofh.it>
 <6KyCQ-1w7-25@gated-at.bofh.it> <E1GDgyZ-0000jV-MV@be1.lrz>
 <1155821951.15195.85.camel@localhost.localdomain> <20060817132309.GX13639@csclub.uwaterloo.ca>
 <44E471F2.5000003@garzik.org> <20060817135431.GE13641@csclub.uwaterloo.ca>
 <44E47F54.3000300@aitel.hist.no>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-be10.7eggert.dyndns.org-MailScanner-Information: See www.mailscanner.info for information
X-be10.7eggert.dyndns.org-MailScanner: Found to be clean
X-be10.7eggert.dyndns.org-MailScanner-From: 7eggert@web.de
X-Provags-ID: kundenserver.de abuse@kundenserver.de login:9b3b2cc444a07783f194c895a09f1de9
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 17 Aug 2006, Helge Hafting wrote:

> None on the file level I hope, for it will surely get abused.
> Windows have exclusive open for example, and there acrobat reader
> locks the pdf file it views, so you can't make a new version without
> killing acrobat first.  (And then you have to restart it to
> view the new file.)  Stupid in the extreme.  Fortunately, acrobat can't
> do that on linux where there is no (easy) opportunity to do so.

The default open mode on network-aware DOS-systems will automatically 
aquire an exclusive lock in order to maintain DOS 2.0 compatibility,
and the filename is part of the file's metadata. Windows seems to have
kept this behaviour.
-- 
"Bravery is being the only one who knows you're afraid."
-David Hackworth
