Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751484AbWFVAMc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751484AbWFVAMc (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 21 Jun 2006 20:12:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751498AbWFVAMc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 21 Jun 2006 20:12:32 -0400
Received: from cpe-72-226-39-15.nycap.res.rr.com ([72.226.39.15]:43268 "EHLO
	mail.cyberdogtech.com") by vger.kernel.org with ESMTP
	id S1751484AbWFVAMb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 21 Jun 2006 20:12:31 -0400
From: "Matt LaPlante" <laplam@rpi.edu>
To: <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH] Unify CONFIG_LBD and CONFIG_LSF handling
Date: Wed, 21 Jun 2006 20:11:49 -0400
Message-ID: <000501c69590$7535fee0$fe01a8c0@cyberdogt42>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Office Outlook 11
thread-index: AcaUgnebHZmEK9N7QwWnIJ6L5jyC3ABDdreQ
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.2869
In-Reply-To: <1150819141.2891.214.camel@laptopd505.fenrus.org>
X-Spam-Processed: mail.cyberdogtech.com, Wed, 21 Jun 2006 20:11:57 -0400
	(not processed: message from trusted or authenticated source)
X-Return-Path: laplam@rpi.edu
X-Envelope-From: laplam@rpi.edu
X-MDaemon-Deliver-To: linux-kernel@vger.kernel.org
X-MDAV-Processed: mail.cyberdogtech.com, Wed, 21 Jun 2006 20:11:59 -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> -----Original Message-----
> From: Arjan van de Ven [mailto:arjan@infradead.org]
> Sent: Tuesday, June 20, 2006 11:59 AM
> To: Roman Zippel
> Cc: Matthew Wilcox; Linus Torvalds; linux-kernel@vger.kernel.org;
> webmaster@cyberdogtech.com
> Subject: Re: [PATCH] Unify CONFIG_LBD and CONFIG_LSF handling
> 
> 
> > > Or is that too verbose?
> >
> > How likely is it that someone who doesn't understand the question needs
> > this option? I think N is a safe answer here.
> 
> N is not the safe answer; Y is. If you set it to N you can't read all
> your files (if there is a big one) etc etc.
> The safe-but-a-bit-slower answer really is Y.
> 

So should default be changed to Y?  It's currently N for kconfig, despite
the recommendation to the contrary.


