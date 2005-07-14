Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262973AbVGNKD5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262973AbVGNKD5 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 14 Jul 2005 06:03:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262976AbVGNKD5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 14 Jul 2005 06:03:57 -0400
Received: from linux01.gwdg.de ([134.76.13.21]:49344 "EHLO linux01.gwdg.de")
	by vger.kernel.org with ESMTP id S262973AbVGNKD4 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 14 Jul 2005 06:03:56 -0400
Date: Thu, 14 Jul 2005 12:03:35 +0200 (MEST)
From: Jan Engelhardt <jengelh@linux01.gwdg.de>
To: Egry =?ISO-8859-1?Q?G=E1bor?= <gaboregry@t-online.hu>
cc: Sam Ravnborg <sam@ravnborg.org>, Linus Torvalds <torvalds@osdl.org>,
       Roman Zippel <zippel@linux-m68k.org>, Andrew Morton <akpm@osdl.org>,
       Massimo Maiurana <maiurana@inwind.it>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       KernelFR <kernelfr@traduc.org>,
       Arnaldo Carvalho de Melo <acme@conectiva.com.br>
Subject: Re: [PATCH 0/19] Kconfig I18N completion
In-Reply-To: <1121280104.2975.84.camel@spirit>
Message-ID: <Pine.LNX.4.61.0507141200190.18072@yvahk01.tjqt.qr>
References: <1121273456.2975.3.camel@spirit>  <Pine.LNX.4.58.0507131038560.17536@g5.osdl.org>
  <1121277818.2975.68.camel@spirit>  <20050713201147.GA23746@mars.ravnborg.org>
 <1121280104.2975.84.camel@spirit>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>> Patch 19/19 contains a .po file.
>
>Yes, the patch 19/19 contains the translation of configuration...
>I see Linus doesn't want the huge language files in kernel source.
>But what is Linus opinion about this little .po file?

What is little? Given that there's 'roughly' 119 languages (find 
/usr/share/locale -type d -maxdepth 1 | wc -l), you'd surely reconsider if 
adding 119 23KB files, if it was considered "small".

As I perceive it, the policy is: no PO files in mainline at all. I'm fine with 
that.

Keeping the translations in sync with the mainline Kconfig help texts/etc. is 
also not an easy task unless you got a lot of time to spare.


Jan Engelhardt
-- 
