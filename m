Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S275021AbTHQGM0 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 17 Aug 2003 02:12:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S275023AbTHQGM0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 17 Aug 2003 02:12:26 -0400
Received: from codepoet.org ([166.70.99.138]:50831 "EHLO winder.codepoet.org")
	by vger.kernel.org with ESMTP id S275021AbTHQGMZ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 17 Aug 2003 02:12:25 -0400
Date: Sun, 17 Aug 2003 00:12:25 -0600
From: Erik Andersen <andersen@codepoet.org>
To: Marcelo Tosatti <marcelo@conectiva.com.br>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, Andries Brouwer <aebr@win.tue.nl>,
       Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: [PATCH] Backport recent 2.6 IDE updates to 2.4.x
Message-ID: <20030817061225.GA17621@codepoet.org>
Reply-To: andersen@codepoet.org
Mail-Followup-To: Erik Andersen <andersen@codepoet.org>,
	Marcelo Tosatti <marcelo@conectiva.com.br>,
	Alan Cox <alan@lxorguk.ukuu.org.uk>,
	Andries Brouwer <aebr@win.tue.nl>,
	Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
X-Operating-System: Linux 2.4.19-rmk7, Rebel-NetWinder(Intel StrongARM 110 rev 3), 185.95 BogoMips
X-No-Junk-Mail: I do not want to get *any* junk mail.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Not too long ago I submitted an IDE patch fixing
CONFIG_IDEDISK_STROKE.  That in turn prompted a flurry of
patches fixing a number of related IDE capacity problems.

I have backported the lot (which includes my original fix) to
2.4.x.  I believe these should be included into 2.4.x, but I
leave the final call to you.  I am running with all of these
patches in my 2.4.x kernel and everything is working nicely.

 -Erik

--
Erik B. Andersen             http://codepoet-consulting.com/
--This message was written using 73% post-consumer electrons--
