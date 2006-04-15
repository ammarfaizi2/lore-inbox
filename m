Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030290AbWDOQzw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030290AbWDOQzw (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 15 Apr 2006 12:55:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030291AbWDOQzv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 15 Apr 2006 12:55:51 -0400
Received: from mx7.mail.ru ([194.67.23.27]:20560 "EHLO mx7.mail.ru")
	by vger.kernel.org with ESMTP id S1030290AbWDOQzv (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 15 Apr 2006 12:55:51 -0400
From: Andrey Borzenkov <arvidjaar@mail.ru>
To: Patrick McHardy <kaber@trash.net>
Subject: Re: Openswan, iptables (fiaif) and 2.6.16 kernel
Date: Sat, 15 Apr 2006 20:55:47 +0400
User-Agent: KMail/1.9.1
Cc: linux-kernel@vger.kernel.org
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200604152055.48130.arvidjaar@mail.ru>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

> 2.6.16 does a second policy lookup after SNAT, you probably SNAT
> the packets to an address that doesn't match the policy anymore.

Could you please give pointers where is it documented? All documents I have 
suggest that SNAT is done as the last step, so any rule should use real and 
not SNAT'ed address.

Thank you

Andrey
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2.2 (GNU/Linux)

iD8DBQFEQSWUR6LMutpd94wRAtJ0AJ45p5p54hDdyyjBPWejRtlr+DoNdQCgy1/3
H2MtVmha+rE6vRxzkdSrrI8=
=RHjq
-----END PGP SIGNATURE-----
