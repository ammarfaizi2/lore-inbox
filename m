Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267303AbSLKTis>; Wed, 11 Dec 2002 14:38:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267302AbSLKTis>; Wed, 11 Dec 2002 14:38:48 -0500
Received: from halon.barra.com ([144.203.11.1]:9957 "EHLO halon.barra.com")
	by vger.kernel.org with ESMTP id <S267301AbSLKTir>;
	Wed, 11 Dec 2002 14:38:47 -0500
From: Fedor Karpelevitch <fedor@apache.org>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [2.4]ALi M5451 sound hangs on init; workaround
Date: Wed, 11 Dec 2002 11:42:31 -0800
User-Agent: KMail/1.5
Cc: lkml <linux-kernel@vger.kernel.org>, Vicente Aguilar <bisente@bisente.com>,
       alsa-devel@lists.sourceforge.net,
       Debian-Laptops <debian-laptop@lists.debian.org>
References: <200212110715.20617.fedor@apache.org> <200212111036.21771.fedor@apache.org> <1039635588.18587.8.camel@irongate.swansea.linux.org.uk>
In-Reply-To: <1039635588.18587.8.camel@irongate.swansea.linux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200212111142.31709.fedor@apache.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> On Wed, 2002-12-11 at 18:36, Fedor Karpelevitch wrote:
> > almost as I posted before, just passing pointers to the read
> > method. It works, but the question as to what is this supposed to
> > affect remains...
>
> If I am reading the docs right then its just a thinko in the code
> and it is meant to be toggling that bit not whacking the entire
> register.

So I wonder what toggling those bits is supposed to change. I would 
test that somehow then
