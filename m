Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264732AbUEJPdP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264732AbUEJPdP (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 10 May 2004 11:33:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264748AbUEJPdP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 10 May 2004 11:33:15 -0400
Received: from host201.200-117-133.telecom.net.ar ([200.117.133.201]:48359
	"EHLO smtp.bensa.ar") by vger.kernel.org with ESMTP id S264732AbUEJPdO
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 10 May 2004 11:33:14 -0400
From: Norberto Bensa <norberto+linux-kernel@bensa.ath.cx>
To: Dominik Karall <dominik.karall@gmx.net>
Subject: Re: 2.6.6-mm1
Date: Mon, 10 May 2004 12:33:14 -0300
User-Agent: KMail/1.6.2
Cc: Linux Kernel ML <linux-kernel@vger.kernel.org>
References: <20040510024506.1a9023b6.akpm@osdl.org> <200405101202.14100.norberto+linux-kernel@bensa.ath.cx> <200405101722.10134.dominik.karall@gmx.net>
In-Reply-To: <200405101722.10134.dominik.karall@gmx.net>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <200405101233.14983.norberto+linux-kernel@bensa.ath.cx>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dominik Karall wrote:
> On Monday 10 May 2004 17:02, you wrote:
> > Dominik Karall wrote:
> > > I reverted this patch too, but it works without problems here.
> >
> > Hmmm... Do you use ACPI?
>
> yes

Ah yes. I found the problem. I was using an unofficial nvidia module (5341.) I 
went back to 5336 and everything works again.

$ uname -a
Linux venkman 2.6.6-mm1 #1 Mon May 10 11:18:44 ART 2004 i686 Pentium III 
(Coppermine) GenuineIntel GNU/Linux

Many many thanks for your time and help,
Norberto

