Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269849AbUJMVKl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269849AbUJMVKl (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 13 Oct 2004 17:10:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269851AbUJMVKj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 13 Oct 2004 17:10:39 -0400
Received: from alpha.logic.tuwien.ac.at ([128.130.175.20]:6873 "EHLO
	alpha.logic.tuwien.ac.at") by vger.kernel.org with ESMTP
	id S269847AbUJMVKf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 13 Oct 2004 17:10:35 -0400
Date: Wed, 13 Oct 2004 23:10:29 +0200
To: Ivan Kokshaysky <ink@jurassic.park.msu.ru>
Cc: linux-kernel@vger.kernel.org, debian-alpha@lists.debian.org,
       linux-alpha@vger.kernel.org
Subject: Re: 2.4.27, alpha arch, make bootimage and make bootpfile fails
Message-ID: <20041013211029.GB5056@gamma.logic.tuwien.ac.at>
References: <20041012173344.GA21846@gamma.logic.tuwien.ac.at> <20041013233247.A11663@jurassic.park.msu.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20041013233247.A11663@jurassic.park.msu.ru>
User-Agent: Mutt/1.3.28i
From: Norbert Preining <preining@logic.at>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mit, 13 Okt 2004, Ivan Kokshaysky wrote:
> > /usr/src/linux-2.4.27/arch/alpha/lib/lib.a -o bootloader
> > /usr/src/linux-2.4.27/lib/lib.a(vsprintf.o): In function `vsnprintf':
> > vsprintf.o(.text+0xcd4): undefined reference to `printk'
> 
> Thanks for the report. The appended patch should fix that.

Thanks a lot. This fixed it. Testing will be done tomorrow.

Best wishes

Norbert

-------------------------------------------------------------------------------
Norbert Preining <preining AT logic DOT at>         Technische Universität Wien
gpg DSA: 0x09C5B094      fp: 14DF 2E6C 0307 BE6D AD76  A9C0 D2BF 4AA3 09C5 B094
-------------------------------------------------------------------------------
WHAPLODE DROVE (n.)
A homicidal golf stroke.
			--- Douglas Adams, The Meaning of Liff
