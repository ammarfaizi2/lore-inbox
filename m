Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318797AbSHLTZ5>; Mon, 12 Aug 2002 15:25:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318798AbSHLTZ5>; Mon, 12 Aug 2002 15:25:57 -0400
Received: from stingr.net ([212.193.32.15]:37896 "EHLO hq.stingr.net")
	by vger.kernel.org with ESMTP id <S318797AbSHLTZ4>;
	Mon, 12 Aug 2002 15:25:56 -0400
Date: Mon, 12 Aug 2002 23:29:45 +0400
From: Paul P Komkoff Jr <i@stingr.net>
To: lkml <linux-kernel@vger.kernel.org>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: Linux 2.4.20-pre1
Message-ID: <20020812192945.GA20757@stingr.net>
Mail-Followup-To: lkml <linux-kernel@vger.kernel.org>,
	Alan Cox <alan@lxorguk.ukuu.org.uk>
References: <Pine.LNX.4.44.0208051938380.6811-100000@freak.distro.conectiva> <20020811085717.GA17738@codepoet.org> <1029095179.16236.16.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=koi8-r
Content-Disposition: inline
In-Reply-To: <1029095179.16236.16.camel@irongate.swansea.linux.org.uk>
User-Agent: Agent Darien Fawkes
X-Mailer: Intel Ultra ATA Storage Driver
X-RealName: Stingray Greatest Jr
Organization: Department of Fish & Wildlife
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Replying to Alan Cox:
> Not a good plan. EFI can be used on non ia64 so NULL_GUID belongs
> somewhere else

maybe but even without NULL_GUID I still need to add asm-ia64 to
KBUILD_INCLUDE_DIRS while trying to kbuild-25ify -ac (and marcelo now)

hint-hint: maybe it IS worth moving to generic include ?

hmm

-- 
Paul P 'Stingray' Komkoff 'Greatest' Jr /// (icq)23200764 /// (http)stingr.net
  When you're invisible, the only one really watching you is you (my keychain)
