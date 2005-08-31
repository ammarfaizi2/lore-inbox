Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964801AbVHaNi1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964801AbVHaNi1 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 31 Aug 2005 09:38:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964803AbVHaNi1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 31 Aug 2005 09:38:27 -0400
Received: from wproxy.gmail.com ([64.233.184.199]:35598 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S964801AbVHaNi0 convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 31 Aug 2005 09:38:26 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=ovwOOJDnIzgEjEtJWGYKFf24gIf2Pe92OEURG0DfCnXkkJpLLm9dFZSv+bcbS9kvwp4J9I+Qc8Y1/uT6M/6sLyRyCth2Ox7WCYGZ4ul8WEcVuW3A5Pl3oCj9YnCMrTIJEWEPDTjtEKvCMbaVESAirTfFZuxeaPNJ73KZ6JjDxwg=
Message-ID: <9e473391050831063814cef924@mail.gmail.com>
Date: Wed, 31 Aug 2005 09:38:25 -0400
From: Jon Smirl <jonsmirl@gmail.com>
To: Eric Anholt <eta@lclark.edu>
Subject: Re: State of Linux graphics
Cc: Discuss issues related to the xorg tree 
	<xorg@lists.freedesktop.org>,
       lkml <linux-kernel@vger.kernel.org>,
       Xserver development <xorg@freedesktop.org>
In-Reply-To: <1125468920.84445.21.camel@leguin>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <9e47339105083009037c24f6de@mail.gmail.com>
	 <1125468920.84445.21.camel@leguin>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/31/05, Eric Anholt <eta@lclark.edu> wrote:
> the X Render extension."  No, EXA is a different acceleration
> architecture making different basic design decisions related to memory
> management and driver API.

I did start the EXA section off with this: "EXA replaces the existing
2D XAA drivers allowing the current server model to work a while
longer."

I'll edit the article to help clarify these points but Daniel has
disabled my login at fd.o so I can't alter the article.

> 
> "If the old hardware is missing the hardware needed to accelerate render
> there is nothing EXA can do to help."  Better memory management allows
> for better performance with composite due to improved placement of
> pixmaps, which XAA doesn't do.  So EXA can help.
> 
> "So it ends up that the hardware EXA works on is the same hardware we
> already had existing OpenGL drivers for."  No.  See, for example, the nv
> or i128 driver ports, both completed in very short timeframes.
> 
> "The EXA driver programs the 3D hardware from the 2D XAA driver adding
> yet another conflicting user to the long line of programs all trying to
> use the video hardware at the same time."  No, EXA is not an addition to
> XAA, it's a replacement.  It's not "yet another conflicting user" on
> your machine (and I have yet to actually see this purported conflict in
> my usage of either acceleration architecture).
> 
> "There is also a danger that EXA will keep expanding to expose more of
> the chip's 3D capabilities."  If people put effort into this because
> they see value in it, without breaking other people's code, why is this
> a "danger?"
> 
> --
> Eric Anholt                                     eta@lclark.edu
> http://people.freebsd.org/~anholt/              anholt@FreeBSD.org
> 
> 
> -----BEGIN PGP SIGNATURE-----
> Version: GnuPG v1.4.1 (FreeBSD)
> 
> iD8DBQBDFUr4HUdvYGzw6vcRAl0SAKCVOCHuVweh5CJoz8UzmkTqNxrEuwCfU/t0
> BJVf4HCTUJGn/g4JtsQO0Ds=
> =tWVr
> -----END PGP SIGNATURE-----
> 
> 
> 


-- 
Jon Smirl
jonsmirl@gmail.com
