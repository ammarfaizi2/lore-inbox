Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271006AbTGVSwD (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 22 Jul 2003 14:52:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271007AbTGVSwD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 22 Jul 2003 14:52:03 -0400
Received: from codepoet.org ([166.70.99.138]:57728 "EHLO winder.codepoet.org")
	by vger.kernel.org with ESMTP id S271006AbTGVSwA (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 22 Jul 2003 14:52:00 -0400
Date: Tue, 22 Jul 2003 13:07:05 -0600
From: Erik Andersen <andersen@codepoet.org>
To: Jeff Garzik <jgarzik@pobox.com>
Cc: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: Promise SATA driver GPL'd
Message-ID: <20030722190705.GA2500@codepoet.org>
Reply-To: andersen@codepoet.org
Mail-Followup-To: Erik Andersen <andersen@codepoet.org>,
	Jeff Garzik <jgarzik@pobox.com>,
	linux-kernel <linux-kernel@vger.kernel.org>
References: <20030722184532.GA2321@codepoet.org> <20030722185443.GB6004@gtf.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030722185443.GB6004@gtf.org>
User-Agent: Mutt/1.3.28i
X-Operating-System: Linux 2.4.19-rmk7, Rebel-NetWinder(Intel StrongARM 110 rev 3), 185.95 BogoMips
X-No-Junk-Mail: I do not want to get *any* junk mail.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue Jul 22, 2003 at 02:54:43PM -0400, Jeff Garzik wrote:
> Bart, Alan, and I have been looking at this.  It uses the ancient CAM
> model, that we don't really want to merge directly in the kernel.  It's
> very close to the libata model, from the user perspective, so life is 
> good.

I was reading over your libata driver yesterday.  Certainly a lot
cleaner than the cam stuff IMHO.  Given the info made available
via the Promise driver, I expect that I could get an initial
libata host adaptor driver hacked together in short order.  After
all, the Intel one is just 400 lines.  So unless you (or anyone
else) have already started or would prefer to do the honors,
I'll try to hack something together this evening,

 -Erik

--
Erik B. Andersen             http://codepoet-consulting.com/
--This message was written using 73% post-consumer electrons--
