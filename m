Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266539AbUHYX47@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266539AbUHYX47 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 25 Aug 2004 19:56:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266513AbUHYX46
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 25 Aug 2004 19:56:58 -0400
Received: from imap.gmx.net ([213.165.64.20]:151 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S266173AbUHYXxi (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 25 Aug 2004 19:53:38 -0400
X-Authenticated: #8834078
From: Dominik Karall <dominik.karall@gmx.net>
To: predivan@ptt.yu
Subject: Re: Two .rej files when patching from 2.6.8.1 to 2.6.9-rc1
Date: Thu, 26 Aug 2004 01:58:02 +0200
User-Agent: KMail/1.6.2
Cc: linux kernel mailing list <linux-kernel@vger.kernel.org>
References: <20040826013136.72bd1906.predivan@ptt.yu>
In-Reply-To: <20040826013136.72bd1906.predivan@ptt.yu>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <200408260158.04729.dominik.karall@gmx.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 26 August 2004 03:31, Predrag Ivanovic wrote:
> Hi.
>
> There are two .rej files when I patch 2.6.8.1 to 2.6.9-rc1
> (I ran 'make mrproper' when I unpacked 2.6.8.1 tarball).
> These are :
> linux-2.6.9-rc1/Makefile.rej
> -------------------------------------------
> ***************
> .....
> .....
>    lock_kernel();
> ------------------------------------------------------------
>
> HTH.
> Pedja
> LGOEG

the 2.6.9-rc1 patch is build against 2.6.8, not 2.6.8.1, so you will need to 
do a 'patch -p1 < patch-2.6.8.1 -R' and patch afterwards with -rc1.

regards,
dominik
