Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264797AbRGSBKy>; Wed, 18 Jul 2001 21:10:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264769AbRGSBKf>; Wed, 18 Jul 2001 21:10:35 -0400
Received: from perninha.conectiva.com.br ([200.250.58.156]:56585 "HELO
	perninha.conectiva.com.br") by vger.kernel.org with SMTP
	id <S264827AbRGSBKa>; Wed, 18 Jul 2001 21:10:30 -0400
Date: Wed, 18 Jul 2001 20:39:01 -0300 (BRT)
From: Marcelo Tosatti <marcelo@conectiva.com.br>
To: Rik van Riel <riel@conectiva.com.br>
Cc: Linus Torvalds <torvalds@transmeta.com>,
        Alan Cox <alan@lxorguk.ukuu.org.uk>, linux-kernel@vger.kernel.org,
        Dave McCracken <dmc@austin.ibm.com>, Dirk Wetter <dirkw@rentec.com>
Subject: Re: [PATCH] swap usage of high memory (fwd)
In-Reply-To: <Pine.LNX.4.33L.0107181529100.28730-100000@imladris.rielhome.conectiva>
Message-ID: <Pine.LNX.4.21.0107182037410.8813-100000@freak.distro.conectiva>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Wed, 18 Jul 2001, Rik van Riel wrote:

> Hi Alan, Linus,
> 
> Dave found a stupid bug in the swapin code, leading to
> bad balancing problems in the VM.
> 
> I suspect marcelo's zone VM hack could even go away
> with this patch applied ;)

Rik,

Still able to trigger the problem with the GFP_HIGHUSER patch applied.



