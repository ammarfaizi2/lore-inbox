Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265224AbUFMRN5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265224AbUFMRN5 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 13 Jun 2004 13:13:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265226AbUFMRNC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 13 Jun 2004 13:13:02 -0400
Received: from gate.crashing.org ([63.228.1.57]:9923 "EHLO gate.crashing.org")
	by vger.kernel.org with ESMTP id S265224AbUFMRMc (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 13 Jun 2004 13:12:32 -0400
Subject: Re: [PATCH] Fix ppc64 out_be64
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Anton Blanchard <anton@samba.org>
Cc: Roland Dreier <roland@topspin.com>,
       linuxppc64-dev <linuxppc64-dev@lists.linuxppc.org>,
       Linux Kernel list <linux-kernel@vger.kernel.org>
In-Reply-To: <20040613162150.GA25389@krispykreme>
References: <521xkk77xh.fsf@topspin.com> <1087141822.8210.176.camel@gaston>
	 <20040613162150.GA25389@krispykreme>
Content-Type: text/plain
Message-Id: <1087146513.8556.180.camel@gaston>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Sun, 13 Jun 2004 12:08:34 -0500
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2004-06-13 at 11:21, Anton Blanchard wrote:
> Hi,
> 
> > Ugh ? The syntax of std is std rS, ds(rA), so your fix doesn't look
> > good to me, and it definitely builds with the current syntax, though I
> > agree the type is indeed wrong. I also spotted another bug where we
> > forgot to change an eieio into sync in there though.
> >
> > Does this totally untested patch works for you ?
> 
> It would be nice to make val unsigned long too :)

Ooops... that what happens with patches written before breakfast ;)

Ben.


