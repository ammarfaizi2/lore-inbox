Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132568AbRCZTiO>; Mon, 26 Mar 2001 14:38:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132577AbRCZTiD>; Mon, 26 Mar 2001 14:38:03 -0500
Received: from runyon.cygnus.com ([205.180.230.5]:45779 "EHLO cygnus.com")
	by vger.kernel.org with ESMTP id <S132568AbRCZTh7>;
	Mon, 26 Mar 2001 14:37:59 -0500
From: Michael Elizabeth Chastain <chastain@cygnus.com>
Date: Mon, 26 Mar 2001 11:37:16 -0800
Message-Id: <200103261937.LAA21613@bosch.cygnus.com>
To: esr@snark.thyrsus.com
Subject: Re: [kbuild-devel] CML1 cleanup patch, take 3
Cc: kbuild-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Eric Raymond writes:
> Bjorn Wesen <bjorn@sparta.lu.se> informs me that the CRIS symbol bugs
> will be fixed in the next CRIS port update.

Hey, there's even a spec which says that config symbols have to look
like CONFIG_*:

  # Documentation/kbuild/config-language.txt
  A /symbol/ is a single unquoted word.  A symbol must have a name of
  the form CONFIG_*.  scripts/mkdep.c relies on this convention in order
  to generate dependencies on individual CONFIG_* symbols instead of
  making one massive dependency on include/linux/autoconf.h.

Michael
