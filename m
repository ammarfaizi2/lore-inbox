Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261257AbUJWRdD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261257AbUJWRdD (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 23 Oct 2004 13:33:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261258AbUJWRdD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 23 Oct 2004 13:33:03 -0400
Received: from vsmtp12.tin.it ([212.216.176.206]:60669 "EHLO vsmtp12.tin.it")
	by vger.kernel.org with ESMTP id S261257AbUJWRcu (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 23 Oct 2004 13:32:50 -0400
Date: Sat, 23 Oct 2004 19:36:51 +0200
From: Luca Risolia <luca.risolia@studio.unibo.it>
To: Bill Davidsen <davidsen@tmr.com>
Cc: linux-kernel@vger.kernel.org, alan@lxorguk.ukuu.org.uk, luc@saillard.org
Subject: Re: Linux 2.6.9-ac3
Message-Id: <20041023193651.1cbcb80d.luca.risolia@studio.unibo.it>
In-Reply-To: <417A70A1.4040101@tmr.com>
References: <20041022101335.6dcf247a.luca.risolia@studio.unibo.it>
	<417A70A1.4040101@tmr.com>
X-Mailer: Sylpheed version 0.9.10 (GTK+ 1.2.10; i386-vine-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 23 Oct 2004 10:54:25 -0400
Bill Davidsen <davidsen@tmr.com> wrote:

> Luca Risolia wrote:
> >>o       Restore PWC driver                              (Luc Saillard)
> > 
> > 
> > This driver does decompression in kernel space, which is not
> > allowed. That part has to be removed from the driver before
> > asking for the inclusion in the mainline kernel.
> 
> What do you mean by "not allowed?"

http://marc.theaimsgroup.com/?l=linux-video&m=108627734619978&w=2

Also note how Alan Cox seems not to be actually coherent with his
previous opinions.

 Clearly it would nice if it were in 
> user space, but it would have to be in EVERY user application to be 
> useful. We have compression in kernel for ppp, and there's only one 
> significant use for that, requiring that every application support every 
> vendor hardware makes it a non-scalable NxM problem.

Hmm..What about a common library finally?

Luca Risolia
