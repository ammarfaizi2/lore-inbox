Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315241AbSD2Xxv>; Mon, 29 Apr 2002 19:53:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315242AbSD2Xxu>; Mon, 29 Apr 2002 19:53:50 -0400
Received: from smtpzilla2.xs4all.nl ([194.109.127.138]:2822 "EHLO
	smtpzilla2.xs4all.nl") by vger.kernel.org with ESMTP
	id <S315241AbSD2Xxt>; Mon, 29 Apr 2002 19:53:49 -0400
Date: Tue, 30 Apr 2002 01:53:34 +0200 (CEST)
From: Roman Zippel <zippel@linux-m68k.org>
To: martin@dalecki.de
cc: linux-kernel@vger.kernel.org
Subject: ide broken again
Message-ID: <Pine.LNX.4.21.0204300143240.23113-100000@serv>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

1. PIO ide is broken again, very quickly the driver stops with "hda: lost
interrupt". Martin could please also test PIO modes, before releasing a
new patch?
2. Why was ide_request_region removed? I see the changelog entry, but I
somehow doubt you contacted any of the affected architectures or even
really tested it. request_region will fail on most archs without ioports
and no "hack" will change that.

bye, Roman

