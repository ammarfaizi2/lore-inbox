Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1755356AbWKMVyy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755356AbWKMVyy (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Nov 2006 16:54:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755357AbWKMVyy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Nov 2006 16:54:54 -0500
Received: from nf-out-0910.google.com ([64.233.182.190]:11505 "EHLO
	nf-out-0910.google.com") by vger.kernel.org with ESMTP
	id S1755356AbWKMVyw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Nov 2006 16:54:52 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:subject:from:to:cc:in-reply-to:references:content-type:date:message-id:mime-version:x-mailer:content-transfer-encoding;
        b=YIrwapF04WE07Vl6eQU8mKn8L0WRe/FsmZLRHoMqkZmSRDQJlqEBRRta+b/TIELwaiK5rXa734Y4eYf+Hoy7hu1Lah6fEc+q5MCm3cX7Wou/7zti8GWocwLGESYTWzOZn6Sf+SBHEo/3+0aODxCkUbxhyxfD262i68N/5tt0v7A=
Subject: Re: pcmcia: patch to fix pccard_store_cis
From: Romano Giannetti <romano.giannetti@gmail.com>
To: Dominik Brodowski <linux@dominikbrodowski.net>,
       Pete Zaitcev <zaitcev@redhat.com>
Cc: linux-pcmcia@lists.infradead.org, fabrice@bellet.info,
       linux-kernel@vger.kernel.org, Andrew Morton <akpm@osdl.org>
In-Reply-To: <602211f80611130212u2a00f9ayd722e170372212fc@mail.gmail.com>
References: <20061001122107.9260aa5d.zaitcev@redhat.com>
	 <20061002003138.GB16938@isilmar.linta.de>
	 <1159794094.8246.2.camel@localhost>
	 <20061103160247.GB11160@dominikbrodowski.de>
	 <602211f80611130212u2a00f9ayd722e170372212fc@mail.gmail.com>
Content-Type: text/plain
Date: Mon, 13 Nov 2006 22:54:44 +0100
Message-Id: <1163454885.13234.6.camel@localhost>
Mime-Version: 1.0
X-Mailer: Evolution 2.8.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2006-11-13 at 11:12 +0100, Romano Giannetti wrote:
>                 I tried your patch on top of the kernel 2.6.17.13 that
> came with ubuntu
>         edgy (and had sufficient trouble with it, I do not know if I'll be able
>         to try with a recent kernel.). This message is in copy to akpm which
>         asked me a report on the same problem.

I tried again, applying your patch after applying Linus' one (commit 
933cd864a5c95c296844493b65d868b7cf7548aa in Linus git). Nothing. Only
the first function of the card is discovered. 

I was trying to read the code, and I cannot find where the code in
socket_sysfs.c is supposed to loop over the various functions of the
card. Maybe there could be some problem there?

I would really like to help on this. My modem is dead from 1.6.13...

Romano




