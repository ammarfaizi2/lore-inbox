Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265048AbSJWPK0>; Wed, 23 Oct 2002 11:10:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265049AbSJWPK0>; Wed, 23 Oct 2002 11:10:26 -0400
Received: from mail.hometree.net ([212.34.181.120]:19624 "EHLO
	mail.hometree.net") by vger.kernel.org with ESMTP
	id <S265048AbSJWPKZ>; Wed, 23 Oct 2002 11:10:25 -0400
To: linux-kernel@vger.kernel.org
Path: forge.intermeta.de!not-for-mail
From: "Henning P. Schmiedehausen" <hps@intermeta.de>
Newsgroups: hometree.linux.kernel
Subject: Re: feature request - why not make netif_rx() a pointer?
Date: Wed, 23 Oct 2002 15:16:35 +0000 (UTC)
Organization: INTERMETA - Gesellschaft fuer Mehrwertdienste mbH
Message-ID: <ap6egj$ck$1@forge.intermeta.de>
References: <00b201c27a0e$3f82c220$800a140a@SLNW2K> <1035326559.16085.18.camel@rth.ninka.net>
Reply-To: hps@intermeta.de
NNTP-Posting-Host: forge.intermeta.de
X-Trace: tangens.hometree.net 1035386195 4888 212.34.181.4 (23 Oct 2002 15:16:35 GMT)
X-Complaints-To: news@intermeta.de
NNTP-Posting-Date: Wed, 23 Oct 2002 15:16:35 +0000 (UTC)
X-Copyright: (C) 1996-2002 Henning Schmiedehausen
X-No-Archive: yes
X-Newsreader: NN version 6.5.1 (NOV)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"David S. Miller" <davem@rth.ninka.net> writes:

>On Tue, 2002-10-22 at 14:15, Matti Aarnio wrote:
>>   ftp://zmailer.org/linux/netif_rx.patch

>Please EXPORT_GPL this, if you are going to do it at all.

>Only non-GPL compliant binary-modules can result from this
>change.

>People can easily do things like implement their own entire
>networking stack with this hook, which is not what we want nor
>is it allowed.

You will never understand, that <insert evil vendor here> can simply
add this modification to the kernel source ("vendor tree"), give this
source away under GPL license and then ship its binary kernel modules
with the source tree.

You won't be able to stop anyone doing this "illegal" thing. But you
hinder many legal users of this.

Not putting an export into the source or exporting GPL_ONLY symbols
won't hinder anyone. Because putting the hooks into a GPL source and
then releasing the result (code + hooks) under GPL is perfectly legal.

The only result are questions on this list, why the <insert your video
card / network / hw driver here> module works under "foobar" Linux and
not with the pristine sources.

Ah and lots of patches like "please put this into the kernel so I can
use the <insert your video card / network / hw driver here> module.

	Regards
		Henning

-- 
Dipl.-Inf. (Univ.) Henning P. Schmiedehausen       -- Geschaeftsfuehrer
INTERMETA - Gesellschaft fuer Mehrwertdienste mbH     hps@intermeta.de

Am Schwabachgrund 22  Fon.: 09131 / 50654-0   info@intermeta.de
D-91054 Buckenhof     Fax.: 09131 / 50654-20   
