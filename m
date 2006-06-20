Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751259AbWFTPyT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751259AbWFTPyT (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 20 Jun 2006 11:54:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751353AbWFTPyT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 20 Jun 2006 11:54:19 -0400
Received: from cpe-72-226-39-15.nycap.res.rr.com ([72.226.39.15]:47879 "EHLO
	mail.cyberdogtech.com") by vger.kernel.org with ESMTP
	id S1751259AbWFTPyS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 20 Jun 2006 11:54:18 -0400
From: "Matt LaPlante" <laplam@rpi.edu>
To: "'Roman Zippel'" <zippel@linux-m68k.org>,
       "'Matthew Wilcox'" <matthew@wil.cx>
Cc: "'Linus Torvalds'" <torvalds@osdl.org>, <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH] Unify CONFIG_LBD and CONFIG_LSF handling
Date: Tue, 20 Jun 2006 11:53:24 -0400
Message-ID: <000601c69481$a9f86c40$fe01a8c0@cyberdogt42>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Office Outlook 11
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.2869
Thread-Index: AcaUgILuScocol2SQ2alE+psfDRwVgAAMBog
In-Reply-To: <Pine.LNX.4.64.0606201742280.12900@scrub.home>
X-Spam-Processed: mail.cyberdogtech.com, Tue, 20 Jun 2006 11:53:30 -0400
	(not processed: message from trusted or authenticated source)
X-Return-Path: laplam@rpi.edu
X-MDaemon-Deliver-To: linux-kernel@vger.kernel.org
X-MDAV-Processed: mail.cyberdogtech.com, Tue, 20 Jun 2006 11:53:30 -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> On Tue, 20 Jun 2006, Matthew Wilcox wrote:
> 
> > On Tue, Jun 20, 2006 at 04:20:53PM +0200, Roman Zippel wrote:
[snip]
> >
> > I don't really understand the complaint.  If <rare condition applies>,
> > say Y, otherwise say N.  If unsure, say Y.  The default is N.  Perhaps
> > all that's needed is to spell out the implications of saying Y?  How
> > about:
> >
> > 	  This option allows 32-bit systems to support files larger than
> > 	  2 Terabytes, at a cost of increased kernel memory usage.  Most
> > 	  people do not need the overhead and should answer N to this
> > 	  question, but if you do not understand this question, answering
> > 	  Y is safest.
> >
> > Or is that too verbose?
> 
> How likely is it that someone who doesn't understand the question needs
> this option? I think N is a safe answer here.
> 
> bye, Roman

This is the impression I had as well.  Even if you disagree though, I was
equally confused by the fact that if we say to answer Y as default, why is
the kconfig default already N?

-
Matt LaPlante


