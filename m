Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263031AbUDLTg1 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 12 Apr 2004 15:36:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263037AbUDLTg1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 12 Apr 2004 15:36:27 -0400
Received: from [62.241.33.80] ([62.241.33.80]:24080 "EHLO
	mx00.linux-systeme.com") by vger.kernel.org with ESMTP
	id S263031AbUDLTgW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 12 Apr 2004 15:36:22 -0400
From: Marc-Christian Petersen <m.c.p@wolk-project.de>
Organization: Working Overloaded Linux Kernel
To: linux-kernel@vger.kernel.org
Subject: Re: 2.6.5-mm4
Date: Mon, 12 Apr 2004 21:35:57 +0200
User-Agent: KMail/1.6.1
Cc: Marcus Hartig <m.f.h@web.de>
References: <407AEBB0.1050305@web.de>
In-Reply-To: <407AEBB0.1050305@web.de>
X-Operating-System: Linux 2.6.4-wolk2.3 i686 GNU/Linux
MIME-Version: 1.0
Content-Disposition: inline
Message-Id: <200404122135.57622@WOLK>
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 12 April 2004 21:19, Marcus Hartig wrote:

Hi Marcus,

> patch: "kbuild-external-module-support" ?

actually, this one: "move-__this_module-to-modpost.patch" started breaking 
nvidia, but strangely not for all people. For me it worked fine (prior to 
2.6.5-mm4), but other people got "invalid module format" after compiling 
nvidia driver and tried to load it. P.S.: kbuild-external-module-support 
breaks VMware too :p

> brakes nicely my nVidia driver for installation at stage 2. Happy easter
> gift. No setting of KBUILD_EXTMOD or editing the install script helps,
> nice job.
> Sorry to say this, but I do not believe, that we get more support, if the
> Linux kernel breaks with every version all good drivers, also
> closed-source, but the best, fastest and stable 3D drivers you can get at
> this time. I hope it goes not in the stable line so soon.

I hope it will go into mainline after the glitches are fixed up. The problem 
is, Andrew and friends need proper bug reports to fix these kind of things 
up asap. If no one speaks up about a problem, everyone expect its working fine 
for all, so go for it into mainline.

ciao, Marc
