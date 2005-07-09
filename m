Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263159AbVGIHiT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263159AbVGIHiT (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 9 Jul 2005 03:38:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263158AbVGIHiS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 9 Jul 2005 03:38:18 -0400
Received: from mail-in-07.arcor-online.net ([151.189.21.47]:30383 "EHLO
	mail-in-07.arcor-online.net") by vger.kernel.org with ESMTP
	id S263164AbVGIHiQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 9 Jul 2005 03:38:16 -0400
Date: Sat, 9 Jul 2005 09:37:48 +0200 (CEST)
From: Bodo Eggert <7eggert@gmx.de>
To: Adrian Bunk <bunk@stusta.de>
cc: Bodo Eggert <7eggert@gmx.de>, linux-kernel@vger.kernel.org
Subject: Re: Documentation mismatch in Documentation/kbuild/kconfig-language.txt
In-Reply-To: <20050708221756.GM3671@stusta.de>
Message-ID: <Pine.LNX.4.58.0507090934510.4231@be1.lrz>
References: <Pine.LNX.4.58.0507041639500.24224@be1.lrz> <20050708221756.GM3671@stusta.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 9 Jul 2005, Adrian Bunk wrote:
> On Mon, Jul 04, 2005 at 04:59:18PM +0200, Bodo Eggert wrote:

...
> > Therefore I can't use
> > config SGI_IOC4
> >     tristate
> >     prompt "SGI IOC4 Base IO support" if PROMPT_FOR_UNUSED_CORES
> >     depends on (IA64_GENERIC || IA64_SGI_SN2) && MMTIMER
> >     default n
...
> > Since the "if" is useless, misleading and redundand with this behaviour, I 
> > suggest stripping it out.
> 
> "if" is valuable in "default y" cases.

It should be, but either it's really applied to the config instead of the 
prompt (in which can also be added to the depends on list) or the 
menuconfig '/' function has bogus output.

-- 
Top 100 things you don't want the sysadmin to say:
25. The only copy of Norton Utilities was on THAT disk???
