Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263064AbVFXPrD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263064AbVFXPrD (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 24 Jun 2005 11:47:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263065AbVFXPoJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 24 Jun 2005 11:44:09 -0400
Received: from chretien.genwebhost.com ([209.59.175.22]:51897 "EHLO
	chretien.genwebhost.com") by vger.kernel.org with ESMTP
	id S263077AbVFXPmB convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 24 Jun 2005 11:42:01 -0400
Date: Fri, 24 Jun 2005 08:41:48 -0700
From: randy_dunlap <rdunlap@xenotime.net>
To: =?ISO-8859-1?B?TWljaGFfXw==?= Piotrowski 
	<piotrowskim@trex.wsi.edu.pl>
Cc: paolo.ciarrocchi@gmail.com, jesper.juhl@gmail.com,
       linux-kernel@vger.kernel.org
Subject: Re: Script to help users to report a BUG
Message-Id: <20050624084148.2f81ae60.rdunlap@xenotime.net>
In-Reply-To: <42BBAD9D.9030404@trex.wsi.edu.pl>
References: <4d8e3fd30506191332264eb4ae@mail.gmail.com>
	<20050622120848.717e2fe2.rdunlap@xenotime.net>
	<42B9CFA1.6030702@trex.wsi.edu.pl>
	<20050622174744.75a07a7f.rdunlap@xenotime.net>
	<9a87484905062311246243774e@mail.gmail.com>
	<20050623120647.2a5783d1.rdunlap@xenotime.net>
	<9a87484905062312131e5f6b05@mail.gmail.com>
	<42BAF608.6080802@trex.wsi.edu.pl>
	<4d8e3fd305062313032c9789e8@mail.gmail.com>
	<42BAFE3E.2050407@trex.wsi.edu.pl>
	<4d8e3fd305062400524f0ad358@mail.gmail.com>
	<42BBAD9D.9030404@trex.wsi.edu.pl>
Organization: YPO4
X-Mailer: Sylpheed version 1.0.5 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-Antivirus-Scanner: Clean mail though you should still use an Antivirus
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - chretien.genwebhost.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [0 0] / [47 12]
X-AntiAbuse: Sender Address Domain - xenotime.net
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 24 Jun 2005 08:52:13 +0200 Micha__ Piotrowski wrote:

| Hi,
| Paolo Ciarrocchi wrote:
| 
| >One comment Michal,
| >I don't like the selection of the editor, I still prefer the idea
| >behind the following patch (that doesn't apply anymore)
| >
| >-echo "[2.] Full description of the problem/report: (press Return when done)"
| >+echo "[2.] Full description of the problem/report: (end with a line
| >+containing only a '.')"
| >echo -e "\n[2.] Full description of the problem/report:" >> $ORT_F
| >read TXT
| >echo "$TXT" >> $ORT_F
| >+while [ "$TXT" != "." ]  ; do
| >+    read TXT
| >+    echo "$TXT" >> $ORT_F
| >+done
| >
| >Do see you the idea ? We don't need an editor to file the BUG.
| >My original idea was to have a very simple and efficient script.
| >
| >Hope it helps.
| >
| >  
| >
| Good idea (for me). Randy what do you think about it?

Yes, I prefer this over using an editor.

thanks,
---
~Randy
