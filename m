Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261859AbVCAK5b@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261859AbVCAK5b (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 1 Mar 2005 05:57:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261867AbVCAK5a
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 1 Mar 2005 05:57:30 -0500
Received: from hs-grafik.net ([80.237.205.72]:33750 "EHLO
	ds80-237-205-72.dedicated.hosteurope.de") by vger.kernel.org
	with ESMTP id S261859AbVCAK5I convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 1 Mar 2005 05:57:08 -0500
From: Alexander Gran <alex@zodiac.dnsalias.org>
To: Andrew Morton <akpm@osdl.org>
Subject: Re: Fw: Re: 2.6.11-rc5-mm1
Date: Tue, 1 Mar 2005 11:57:03 +0100
User-Agent: KMail/1.7.2
Cc: linux kernel mailing list <linux-kernel@vger.kernel.org>,
       Dominik Brodowski <linux@brodo.de>
References: <20050301024804.09eadb6e.akpm@osdl.org>
In-Reply-To: <20050301024804.09eadb6e.akpm@osdl.org>
X-Need-Girlfriend: always
X-Ignorant-User: yes
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 8BIT
Content-Disposition: inline
Message-Id: <200503011157.03764@zodiac.zodiac.dnsalias.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Am Dienstag, 1. März 2005 11:48 schrieb Andrew Morton:
> Alex, please use mailing lists...

sorry, I was used to have reply-to set to the mailing list ;) 
double-checking next time..

> Dominik, do we really always want to drag in the firmware loader if
> CONFIG_PCMCIA?

Hmm. I've enabled the firmware loader that fixes at least the compile error...
Now rebooting. More info after my system programming exam in 1 hour..... ;)

regards
Alex

> Begin forwarded message:
>
> Date: Tue, 1 Mar 2005 11:35:40 +0100
> From: Alexander Gran <alex@zodiac.dnsalias.org>
> To: Andrew Morton <akpm@osdl.org>
> Subject: Re: 2.6.11-rc5-mm1
>
> Am Dienstag, 1. März 2005 10:27 schrieben Sie:
> > - A pcmcia update which obsoletes cardmgr (although cardmgr still works)
> > and makes pcmcia work more like regular hotpluggable devices.  See the
> > changelong in pcmcia-dont-send-eject-request-events-to-userspace.patch
> > for details.
>
> drivers/built-in.o(.text+0xdd219): In function `pcmcia_load_firmware':
> : undefined reference to `request_firmware'
>
> drivers/built-in.o(.text+0xdd295): In function `pcmcia_load_firmware':
> : undefined reference to `release_firmware'
>
> make: *** [.tmp_vmlinux1] Error 1
>
> .config attached
>
> regards
> Alex

-- 
Encrypted Mails welcome.
PGP-Key at http://zodiac.dnsalias.org/misc/pgpkey.asc | Key-ID: 0x6D7DD291
