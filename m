Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266989AbSK2JRX>; Fri, 29 Nov 2002 04:17:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266991AbSK2JRX>; Fri, 29 Nov 2002 04:17:23 -0500
Received: from mailout01.sul.t-online.com ([194.25.134.80]:32421 "EHLO
	mailout01.sul.t-online.com") by vger.kernel.org with ESMTP
	id <S266989AbSK2JRW> convert rfc822-to-8bit; Fri, 29 Nov 2002 04:17:22 -0500
Message-ID: <3DE7324F.B5965432@folkwang-hochschule.de>
Date: Fri, 29 Nov 2002 10:24:31 +0100
From: Joern Nettingsmeier <nettings@folkwang-hochschule.de>
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.4.20-pre1 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: jgarzik@pobox.com, linux-kernel@vger.kernel.org
Subject: 8139/mii module problem with 2.5.49/50
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

hi jeff, hi everyone !

i can compile 2.5.50 just fine, except for huge-page-table-support,
which bails out.

but i'm stuck w/o networking, since the 8139too driver can't be loaded.
it complains about an unresolved symbol, because the mii module fails to
load due to "unknown module format".
the same problem occurred in 2.5.49.

my first thought was to run depmod, but afaik it's obsolete now...?
other modules (like tdfx or crypto) load fine.

this is a dual p3/600 machine on an asus p2b-ds (bx chipset) with a
realtek 8139 pci nic.

i'd be happy to try out patches.

sorry if this has been asked before, i'm not subscribed to lkml and
there's always some lag in the archives.
i'd appreciate a cc: on replies. thanks.

best,

jörn


-- 
Jörn Nettingsmeier     
Kurfürstenstr 49, 45138 Essen, Germany      
http://spunk.dnsalias.org (my server)
http://www.linuxdj.com/audio/lad/ (Linux Audio Developers)
