Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261719AbULZSPy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261719AbULZSPy (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 26 Dec 2004 13:15:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261721AbULZSPy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 26 Dec 2004 13:15:54 -0500
Received: from ferdi.naasa.net ([212.8.0.5]:22281 "EHLO ferdi.naasa.net")
	by vger.kernel.org with ESMTP id S261719AbULZSPs (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 26 Dec 2004 13:15:48 -0500
From: Joerg Platte <lists@naasa.net>
Reply-To: lists@naasa.net
To: Patrick McHardy <kaber@trash.net>
Subject: Re: Kernel 2.6.10 with IPSEC problems?
Date: Sun, 26 Dec 2004 19:15:26 +0100
User-Agent: KMail/1.7.2
Cc: linux-kernel@vger.kernel.org
References: <200412261553.24178.lists@naasa.net> <41CEDB2B.7080309@trash.net>
In-Reply-To: <41CEDB2B.7080309@trash.net>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Message-Id: <200412261915.26681.lists@naasa.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Am Sonntag, 26. Dezember 2004 16:39 schrieb Patrick McHardy:
Hi!

> Since Linux 2.6.10-rcX. packets from a tunnel-mode SA are dropped if
> no policy exists. You most likely only have an input policy, but no
> forward policy. If you use setkey to configure your policies,
> duplicate the input policy and replace "-P in" with "-P fwd". If you
> let racoon generate the policy you need to upgrade to the latest
> version. pluto should already get it right.

Thanks for the fast reply. It solved my problem. Is this change somewhere 
documented? Where can I get this kind of information, if I have problems in 
the future with the kernel IPSEC implementation?

Regards,
Jörg

-- 
Hi! I'm a .signature virus! Copy me into your signature to help me spread!.-.
PGP Key: send mail with subject 'SEND PGP-KEY' PGP Key-ID: FD 4E 21 1D    oo|
PGP Fingerprint: 388A872AFC5649D3 BCEC65778BE0C605                  _ // /`'\
I am Ohm of Borg. Resistance is voltage divided by current.         \X/ (\_;/)
