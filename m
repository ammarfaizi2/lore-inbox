Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265987AbUBJR0M (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 10 Feb 2004 12:26:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265981AbUBJRXG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 10 Feb 2004 12:23:06 -0500
Received: from hera.kernel.org ([63.209.29.2]:32211 "EHLO hera.kernel.org")
	by vger.kernel.org with ESMTP id S266064AbUBJRTM (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 10 Feb 2004 12:19:12 -0500
To: linux-kernel@vger.kernel.org
From: hpa@zytor.com (H. Peter Anvin)
Subject: Re: Does anyone still care about BSD ptys?
Date: Tue, 10 Feb 2004 17:19:04 +0000 (UTC)
Organization: Transmeta Corporation, Santa Clara CA
Message-ID: <c0b3q8$uf3$1@terminus.zytor.com>
References: <c07c67$vrs$1@terminus.zytor.com> <20040209175119.GC1795@intern.kubla.de> <Pine.LNX.4.53.0402091327020.9986@chaos> <20040210111632.GA1229@intern.kubla.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 8bit
X-Trace: terminus.zytor.com 1076433544 31204 63.209.29.3 (10 Feb 2004 17:19:04 GMT)
X-Complaints-To: news@terminus.zytor.com
NNTP-Posting-Date: Tue, 10 Feb 2004 17:19:04 +0000 (UTC)
X-Newsreader: trn 4.0-test76 (Apr 2, 2001)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Followup to:  <20040210111632.GA1229@intern.kubla.de>
By author:    Dominik Kubla <dominik@kubla.de>
In newsgroup: linux.dev.kernel
> 
> Try removing you BSD pty's and most likely you will see that telnetd
> happily uses System V pty's. If not then you should really update your
> telnetd.  Both netkit-telnetd and telnetd-ssl, which is derived from it,
> can use System V-ptys since at least 5 years, probably even longer.
> If both BSD and System V pty's are present on the system, the code will use
> BSD. (That's why i removed the BSD pty's in the first place!)
> 

Eep!

Using BSD ptys is a security hazard.  They should *definitely* not be
usef preferentially.  On my system (RH9) they aren't used by telnet
even though they exist.

	-hpa
-- 
PGP public key available - finger hpa@zytor.com
Key fingerprint: 2047/2A960705 BA 03 D3 2C 14 A8 A8 BD  1E DF FE 69 EE 35 BD 74
"The earth is but one country, and mankind its citizens."  --  Bahá'u'lláh
Just Say No to Morden * The Shadows were defeated -- Babylon 5 is renewed!!
