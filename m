Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1760291AbWLFIUI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760291AbWLFIUI (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 6 Dec 2006 03:20:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1760293AbWLFIUI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 6 Dec 2006 03:20:08 -0500
Received: from main.gmane.org ([80.91.229.2]:60765 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1760291AbWLFIUG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 6 Dec 2006 03:20:06 -0500
X-Injected-Via-Gmane: http://gmane.org/
To: linux-kernel@vger.kernel.org
From: Koen Kooi <koen@dominion.kabel.utwente.nl>
Subject: Re: More ARM binutils fuckage
Date: Wed, 06 Dec 2006 09:17:49 +0100
Message-ID: <45767CAD.10809@dominion.kabel.utwente.nl>
References: <20061205193357.GF24038@flint.arm.linux.org.uk> <f2b55d220612051529t3c0dcda8ma920c13b00899b10@mail.gmail.com> <20061206002226.GK24038@flint.arm.linux.org.uk> <20061206010813.GC30401@xi.wantstofly.org> <582252003.20061206084328@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: dominion.kabel.utwente.nl
User-Agent: Thunderbird 1.5.0.8 (Macintosh/20061025)
In-Reply-To: <582252003.20061206084328@gmail.com>
X-Enigmail-Version: 0.94.1.2
Cc: linux-arm-kernel@lists.arm.linux.org.uk
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Paul Sokolovsky schreef:
> Hello Lennert,
> 
> Wednesday, December 6, 2006, 3:08:13 AM, you wrote:
> 
> []
>> (These
>> days I build all kernels in EABI mode with old-ABI compat.)  I have
>> not run into any code generation issues with this compiler yet.
> 
>   I wonder, if OABI-compat is known to actually work on OABI userspace,
> I mean, on something real, like xserver-kdrive ;-). Because I'd really
> like to build single kernel for both old and new userspace too, but
> afraid to try that, fearing to be put down by another broken feature
> ;-).

It does work, I routinely switched between softfpa and eabi userspace without reflashing
the kernel. You just need to make sure that both userspace images have the same modules.

regards,

Koen
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.5 (Darwin)

iD8DBQFFdnytMkyGM64RGpERAuvpAJ0ccwFvMWQrU1V3THSd1FlaDDwOTACfbj92
+PF+IsXCGxCJx1YThB9NHdQ=
=B7Ff
-----END PGP SIGNATURE-----

