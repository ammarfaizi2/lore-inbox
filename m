Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262614AbVCPPIN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262614AbVCPPIN (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 16 Mar 2005 10:08:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262621AbVCPPFu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 16 Mar 2005 10:05:50 -0500
Received: from hoemail1.lucent.com ([192.11.226.161]:46041 "EHLO
	hoemail1.lucent.com") by vger.kernel.org with ESMTP id S262614AbVCPPFA
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 16 Mar 2005 10:05:00 -0500
Message-ID: <B99995113B318D44BBE87DC50092EDA913E1BC98@nj7460exch006u.ho.lucent.com>
From: "Balasaygun, Oray (Oray)" <oray@lucent.com>
To: "'Tom Rini'" <trini@kernel.crashing.org>,
       Bastos Fernandez Alexandre <ALEBAS@televes.com>
Cc: "'Andrew Morton'" <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       Leo Li <leoli@freescale.com>,
       "Balasaygun, Oray (Oray)" <oray@lucent.com>
Subject: RE: [PATCH] ppc32: Update 8260_io/fcc_enet.c to function again
Date: Wed, 16 Mar 2005 10:04:39 -0500
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2657.72)
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I concur, the two essential things in my patch (2.6 API change and fix for bug 4310) are already picked up in your patch. I could have replied earlier but I thought I would take an hour or two to run with your patch on my board. But that can wait since you guys seem to be in a hurry with a decision on this.

Oray



-----Original Message-----
From: Tom Rini [mailto:trini@kernel.crashing.org]
Sent: Wednesday, March 16, 2005 9:55 AM
To: Bastos Fernandez Alexandre
Cc: 'Andrew Morton'; linux-kernel@vger.kernel.org; Leo Li; Balasaygun,
Oray (Oray)
Subject: Re: [PATCH] ppc32: Update 8260_io/fcc_enet.c to function again


On Wed, Mar 16, 2005 at 09:00:51AM +0100, Bastos Fernandez Alexandre wrote:

> What can we do?
> Has Oray's patch been commited? Or not yet?
> 
> I suggest commiting all the changes in this driver from linuxppc tree to
> linux tree
> and after this ask Oray to test again the driver and submmit new patch.
> Or ask Oray to submmit changes patch to linuxppc 

So, Oray's patch has two things in it, it looks like.  The basic
re-porting to 2.6 APIs, and support for the EON8260.  The EON8260
changes should be a bit cleaner to redo after the patch I sent goes in
as some of the other cleanups will help there.  But I'd also like to see
the full EON8260 changes :)  The 2.6 API parts look close, but I went
and expanded a good bit more on them.

I'd like to drop Oray's patch for now, and have the EON8260 work be
resubmitted to lkml/linuxppc-embedded@ozlabs.org.

-- 
Tom Rini
http://gate.crashing.org/~trini/
