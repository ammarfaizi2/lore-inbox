Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314748AbSESSCk>; Sun, 19 May 2002 14:02:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314769AbSESSCj>; Sun, 19 May 2002 14:02:39 -0400
Received: from dell-paw-3.cambridge.redhat.com ([195.224.55.237]:46587 "EHLO
	passion.cambridge.redhat.com") by vger.kernel.org with ESMTP
	id <S314748AbSESSCi>; Sun, 19 May 2002 14:02:38 -0400
X-Mailer: exmh version 2.4 06/23/2000 with nmh-1.0.4
From: David Woodhouse <dwmw2@infradead.org>
X-Accept-Language: en_GB
In-Reply-To: <E179VI7-0004AY-00@the-village.bc.nu> 
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: rui.sousa@laposte.net (Rui Sousa), rusty@rustcorp.com.au (Rusty Russell),
        linux-kernel@vger.kernel.org,
        kernel-janitor-discuss@lists.sourceforge.net
Subject: Re: AUDIT of 2.5.15 copy_to/from_user 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Sun, 19 May 2002 19:02:27 +0100
Message-ID: <12975.1021831347@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


alan@lxorguk.ukuu.org.uk said:
> > > After that we always use __copy_from_user() and we trust it not to fail. 
> > This is correct 

> The only check done in access_ok on x86 is the 0xC0000000->0xFFFFFFFF
> check with isnt affected by remappings. 

Right.... so trusting __copy_to_user() not to fail doesn't seem 
particularly correct.

--
dwmw2


