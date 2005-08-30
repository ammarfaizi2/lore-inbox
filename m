Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750927AbVH3Nrh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750927AbVH3Nrh (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 30 Aug 2005 09:47:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750928AbVH3Nrh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 30 Aug 2005 09:47:37 -0400
Received: from zproxy.gmail.com ([64.233.162.192]:40947 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1750926AbVH3Nrg convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 30 Aug 2005 09:47:36 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=aypye9fDtkfp09WWCFz0UNzzKdXmESIyVGF7pA/p4P7ej9KangjB9Tor9UahSaaIZjRTTmT2o3weUeAuesVDZcqsBAt7MTdryAmMXKkWxmaTyvNFzQ9D0CSpQ311HFgsdhG2FhDUvThu1Jjw89ZcNanoM/NhPxTz0l2y0Dc8v+w=
Message-ID: <9a87484905083006474f58c7c2@mail.gmail.com>
Date: Tue, 30 Aug 2005 15:47:32 +0200
From: Jesper Juhl <jesper.juhl@gmail.com>
To: Karsten Keil <kkeil@suse.de>
Subject: Re: [PATCH] isdn_v110 warning fix
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Thomas Pfeiffer <pfeiffer@pds.de>, isdn4linux@listserv.isdn4linux.de,
       Kai Germaschewski <kai.germaschewski@gmx.de>
In-Reply-To: <20050830105104.GA6918@pingi3.kke.suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <200508300105.44247.jesper.juhl@gmail.com>
	 <20050830105104.GA6918@pingi3.kke.suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/30/05, Karsten Keil <kkeil@suse.de> wrote:
> On Tue, Aug 30, 2005 at 01:05:43AM +0200, Jesper Juhl wrote:
> >
> 
> This is OK. Even if the codepath is never executed in a way that ret might
> be used uninitialized it does not harm to set ret = 0.
> 
> 
> Warning fix :
>  drivers/isdn/i4l/isdn_v110.c:523: warning: `ret' might be used uninitialized in this function
> 
> Signed-off-by: Jesper Juhl <jesper.juhl@gmail.com>
> Signed-off-by: Karsten Keil <kkeil@suse.de>
> 

Thank you for your feedback and for signing off on the patch. I'll
forward it to Andrew for inclusion in -mm.

-- 
Jesper Juhl <jesper.juhl@gmail.com>
Don't top-post  http://www.catb.org/~esr/jargon/html/T/top-post.html
Plain text mails only, please      http://www.expita.com/nomime.html
