Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315456AbSGMXl4>; Sat, 13 Jul 2002 19:41:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315458AbSGMXlz>; Sat, 13 Jul 2002 19:41:55 -0400
Received: from chaos.physics.uiowa.edu ([128.255.34.189]:54462 "EHLO
	chaos.physics.uiowa.edu") by vger.kernel.org with ESMTP
	id <S315456AbSGMXly>; Sat, 13 Jul 2002 19:41:54 -0400
Date: Sat, 13 Jul 2002 18:44:43 -0500 (CDT)
From: Kai Germaschewski <kai@tp1.ruhr-uni-bochum.de>
X-X-Sender: kai@chaos.physics.uiowa.edu
To: Thunder from the hill <thunder@ngforever.de>
cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [Q] Objects with EXPORT_NO_SYMBOLS
In-Reply-To: <Pine.LNX.4.44.0207131610320.3331-100000@hawkeye.luckynet.adm>
Message-ID: <Pine.LNX.4.44.0207131841430.6108-100000@chaos.physics.uiowa.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 13 Jul 2002, Thunder from the hill wrote:

> Should an object which explicitly defines EXPORT_NO_SYMBOLS be listed in 
> export-objs? If not, then I just found some candidates...

In 2.5, there shouldn't be any source which has an "EXPORT_NO_SYMBOLS"  
line, if so just delete it.

Generally (2.4 and 2.5), a file should be listed in export-objs iff the
source contains some "EXPORT_SYMBOL(...)" statement.

--Kai


