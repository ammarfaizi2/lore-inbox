Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263334AbSIPXNQ>; Mon, 16 Sep 2002 19:13:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263344AbSIPXNQ>; Mon, 16 Sep 2002 19:13:16 -0400
Received: from smtpzilla3.xs4all.nl ([194.109.127.139]:46864 "EHLO
	smtpzilla3.xs4all.nl") by vger.kernel.org with ESMTP
	id <S263334AbSIPXNN>; Mon, 16 Sep 2002 19:13:13 -0400
Message-ID: <3D866667.1EBFDF31@linux-m68k.org>
Date: Tue, 17 Sep 2002 01:16:55 +0200
From: Roman Zippel <zippel@linux-m68k.org>
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.19 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel <linux-kernel@vger.kernel.org>,
       kbuild-devel <kbuild-devel@lists.sourceforge.net>
Subject: linux kernel conf 0.6
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

At http://www.xs4all.nl/~zippel/lc/lkc-0.6.tar.gz you can find the
latest version of the new config system. Changes this time:
- update to 2.5.35
- I included my convert script and prepare/fixup patch to convert all
archs
- qconf got a split screen mode
- the save bug is fixed
- the converter mostly ignores "define_bool CONFIG_FOO n" now, they are
only used for type definitions. They were only needed to keep the old
config system working, but shouldn't be needed anymore, this allows to
generate slightly better dependencies in the generated configs.

bye, Roman
