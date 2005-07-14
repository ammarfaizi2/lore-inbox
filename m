Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262844AbVGNAOB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262844AbVGNAOB (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 13 Jul 2005 20:14:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262806AbVGNALs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 13 Jul 2005 20:11:48 -0400
Received: from scrub.xs4all.nl ([194.109.195.176]:7897 "EHLO scrub.xs4all.nl")
	by vger.kernel.org with ESMTP id S262779AbVGNAKf (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 13 Jul 2005 20:10:35 -0400
Date: Thu, 14 Jul 2005 02:10:25 +0200 (CEST)
From: Roman Zippel <zippel@linux-m68k.org>
X-X-Sender: roman@scrub.home
To: =?UTF-8?Q?Egry_G=E1bor?= <gaboregry@t-online.hu>
cc: Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>,
       Massimo Maiurana <maiurana@inwind.it>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       KernelFR <kernelfr@traduc.org>,
       Arnaldo Carvalho de Melo <acme@conectiva.com.br>
Subject: Re: [PATCH 4/19] Kconfig I18N: lxdialog: multibyte character support
In-Reply-To: <1121274694.2975.18.camel@spirit>
Message-ID: <Pine.LNX.4.61.0507140207170.3728@scrub.home>
References: <1121273456.2975.3.camel@spirit> <1121274694.2975.18.camel@spirit>
MIME-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="-1463811837-794139641-1121299825=:3728"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

---1463811837-794139641-1121299825=:3728
Content-Type: TEXT/PLAIN; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE

Hi,

On Wed, 13 Jul 2005, Egry G=E1bor wrote:

> UTF-8 support for lxdialog with wchar. The installed wide ncurses=20
> (ncursesw) is optional because some languages (ex. English, Italian)=20
> and ISO 8859-xx charsets don't require this patch.

This is ugly, this just adds lots of #ifdefs with practically duplicated=20
code. Please use some wrapper functions/macros.

bye, Roman
---1463811837-794139641-1121299825=:3728--
