Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932334AbWEBAiF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932334AbWEBAiF (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 1 May 2006 20:38:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932336AbWEBAiE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 1 May 2006 20:38:04 -0400
Received: from allen.werkleitz.de ([80.190.251.108]:36250 "EHLO
	allen.werkleitz.de") by vger.kernel.org with ESMTP id S932334AbWEBAiD
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 1 May 2006 20:38:03 -0400
Date: Tue, 2 May 2006 02:37:55 +0200
From: Johannes Stezenbach <js@linuxtv.org>
To: David Woodhouse <dwmw2@infradead.org>
Cc: "Randy.Dunlap" <rdunlap@xenotime.net>, lkml <linux-kernel@vger.kernel.org>,
       akpm <akpm@osdl.org>
Message-ID: <20060502003755.GA26327@linuxtv.org>
References: <20060430174426.a21b4614.rdunlap@xenotime.net> <1146503166.2885.137.camel@hades.cambridge.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1146503166.2885.137.camel@hades.cambridge.redhat.com>
User-Agent: Mutt/1.5.11+cvs20060403
X-SA-Exim-Connect-IP: 84.189.212.223
Subject: Re: [PATCH] CodingStyle: add typedefs chapter
X-SA-Exim-Version: 4.2.1 (built Mon, 27 Mar 2006 13:42:28 +0200)
X-SA-Exim-Scanned: Yes (on allen.werkleitz.de)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 01, 2006, David Woodhouse wrote:
> On Sun, 2006-04-30 at 17:44 -0700, Randy.Dunlap wrote:
> > + (b) Clear integer types, where the abstraction _helps_ avoid confusion
> > +     whether it is "int" or "long".
> > +
> > +     u8/u16/u32 are perfectly fine typedefs. 
> 
> No, u8/u16/u32 are fall into category (d):
> 
>  (d) New types which are identical to standard C99 types, in certain
>      exceptional circumstances.
> 
>      Although it would only take a short amount of time for the eyes and
>      brain to become accustomed to the standard types like 'uint32_t',
>      some people object to their use anyway.
> 
>      Therefore, the gratuitous 'u8/u16/u32/u64' types and their signed
>      equivalents which are identical to standard types are permitted --
>      although they are not mandatory.

IMHO u32 etc. are the well established data types used
everywhere in kernel source. Your wording suggests that
the use of C99 types would be better, and while I respect
your personal opinion, I think it is wrong to put that in the
kernel CodingStyle document.

c.f. http://lkml.org/lkml/2004/12/14/127


Johannes
