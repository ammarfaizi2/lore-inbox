Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263226AbUJ2Ku4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263226AbUJ2Ku4 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 29 Oct 2004 06:50:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263233AbUJ2Kuz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 29 Oct 2004 06:50:55 -0400
Received: from pils.linux-kernel.at ([62.116.87.200]:50581 "EHLO
	pils.linux-kernel.at") by vger.kernel.org with ESMTP
	id S263226AbUJ2Kuu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 29 Oct 2004 06:50:50 -0400
Message-Id: <200410291050.i9TAo7Y7025791@pils.linux-kernel.at>
From: "Oliver Falk" <oliver@linux-kernel.at>
To: "'Jesper Juhl'" <juhl-lkml@dif.dk>, "'Andrew Morton'" <akpm@osdl.org>
Cc: <dan@fullmotions.com>, <linux-kernel@vger.kernel.org>
Subject: RE: SSH and 2.6.9
Date: Fri, 29 Oct 2004 12:52:32 +0200
Organization: linux-kernel.at
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Office Outlook, Build 11.0.6353
Thread-Index: AcS9pK23R0G9A5t9QP6CZZ6MeDf+ygAAG7lg
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1441
In-Reply-To: <Pine.LNX.4.61.0410291234530.22050@jjulnx.backbone.dif.dk>
X-Authenticated-Sender: user oliver from 172.16.1.213
X-lkernAT-MailScanner-Information: Please contact the ISP for more information
X-lkernAT-MailScanner: Found to be clean
X-lkernAT-MailScanner-SpamCheck: not spam, SpamAssassin (score=-4.599,
	required 5, autolearn=not spam, ALL_TRUSTED -3.30, AWL -1.30,
	BAYES_50 0.00)
X-MailScanner-From: oliver@linux-kernel.at
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > Jesper Juhl <juhl-lkml@dif.dk> wrote:
> > >
> > > Now I guess we just need for someone to find out why LEGACY_PTYS 
> > > breaks  ssh (and other apps?) with kernels >= 2.6.9,
> > 
> > Works OK here, witht he latest of everything.  Please send 
> > the faulty .config.
> > 
> > If you could generate the `strace -f' output from good and bad 
> > sessions and identify where things went wrong, that would help.
> > 
> 
> I have no problem here, and I can't reproduce it by enabling 
> LEGACY_PTYS either, so you'll have to get the .config and 
> strace etc from Danny Brow.

Similar problem occured at my box, but it's not kernel 2.6.9 which breaks
SSH. At leat for me...
If you are running FC3T3, then try to remount /dev. Since some version of
udev obsoletes the dev package and afterwards no /dev/pts/* exists, since
dev is no longer there and udev 'overmounted' /dev...

Best,
 Oliver

