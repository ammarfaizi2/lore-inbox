Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263191AbUDZSwg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263191AbUDZSwg (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 26 Apr 2004 14:52:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263215AbUDZSwg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 26 Apr 2004 14:52:36 -0400
Received: from hell.org.pl ([212.244.218.42]:11271 "HELO hell.org.pl")
	by vger.kernel.org with SMTP id S263191AbUDZSwe (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 26 Apr 2004 14:52:34 -0400
Date: Mon, 26 Apr 2004 20:52:38 +0200
From: Karol Kozimor <sziwan@hell.org.pl>
To: Herbert Xu <herbert@gondor.apana.org.au>
Cc: linux-kernel@vger.kernel.org, swsusp-devel@lists.sourceforge.net
Subject: Re: [AGP] intel_845_configure() at resume
Message-ID: <20040426185238.GA24238@hell.org.pl>
Mail-Followup-To: Herbert Xu <herbert@gondor.apana.org.au>,
	linux-kernel@vger.kernel.org, swsusp-devel@lists.sourceforge.net
References: <20040425182949.GA8151@hell.org.pl> <E1BI3rB-0001ej-00@gondolin.me.apana.org.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-2
Content-Disposition: inline
In-Reply-To: <E1BI3rB-0001ej-00@gondolin.me.apana.org.au>
User-Agent: Mutt/1.4.2i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Thus wrote Herbert Xu:
> Karol Kozimor <sziwan@hell.org.pl> wrote:
> > I've been trying to nail down the AGP problems most swsusp[12]/pmdisk users
> > are experiencing (deadlocks or reboots around the phase of copying the
> > original kernel back).
> 
> Please test my patch at the bottom of
> 
> http://bugs.debian.org/234976

That seems to fix Pavel's swsusp here, I can now suspend from X with
glxgears running. I didn't do any thorough testing though, only a 
couple of cycles. Thanks for your work.
Best regards,

-- 
Karol 'sziwan' Kozimor
sziwan@hell.org.pl
