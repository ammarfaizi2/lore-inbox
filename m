Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261600AbULTSEL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261600AbULTSEL (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Dec 2004 13:04:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261599AbULTSEK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Dec 2004 13:04:10 -0500
Received: from boa.mtg-marinetechnik.de ([62.153.155.10]:65006 "EHLO
	cascabel.mtg-marinetechnik.de") by vger.kernel.org with ESMTP
	id S261597AbULTSDu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Dec 2004 13:03:50 -0500
Message-ID: <41C713EF.8050003@mtg-marinetechnik.de>
Date: Mon, 20 Dec 2004 19:03:27 +0100
From: Richard Ems <richard.ems@mtg-marinetechnik.de>
Organization: MTG Marinetechnik GmbH
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.3) Gecko/20040913
X-Accept-Language: en, de, es
MIME-Version: 1.0
To: Jon Mason <jdmason@gmail.com>
Cc: linux-kernel@vger.kernel.org, linux-net@vger.kernel.org
References: <200412171100.16601.richard.ems@mtg-marinetechnik.de>	 <89245775041217090726eb2751@mail.gmail.com>	 <41C31421.7090102@mtg-marinetechnik.de>	 <8924577504121710054331bb54@mail.gmail.com>	 <8924577504121712527144a5cf@mail.gmail.com>	 <41C6E2E1.8030801@mtg-marinetechnik.de> <8924577504122009126c40c1fe@mail.gmail.com>
In-Reply-To: <8924577504122009126c40c1fe@mail.gmail.com>
X-Enigmail-Version: 0.89.0.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Subject: Re: PROBLEM: Network hang: "eth0: Tx timed out (f0080), is buffer 
  full?" (Plain)
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi jon, hi list,

here the next network hang with the patched dl2k.c driver:

Dec 20 18:49:08 urutu kernel: eth1: HostError! IntStatus 0002. 202 143 8 7c2
Dec 20 18:52:08 urutu kernel: nfs: server jupiter not responding, still 
trying
Dec 20 18:54:15 urutu kernel: NETDEV WATCHDOG: eth1: transmit timed out
Dec 20 18:54:15 urutu kernel: eth1: Tx timed out (d50080) 214 143 800 0
Dec 20 18:54:31 urutu kernel: nfs: server jupiter not responding, still 
trying
Dec 20 18:54:35 urutu kernel: nfs: server jupiter not responding, still 
trying
Dec 20 18:54:51 urutu kernel: nfs: server diablo not responding, still 
trying
Dec 20 18:54:55 urutu kernel: nfs: server jupiter not responding, still 
trying
Dec 20 18:59:01 urutu /usr/sbin/cron[24118]: (root) CMD ( rm -f 
/var/spool/cron/lastrun/cron.hourly)
Dec 20 18:59:31 urutu kernel: NETDEV WATCHDOG: eth1: transmit timed out
Dec 20 18:59:31 urutu kernel: eth1: Tx timed out (d30080) 212 143 800 0


Thanks, Richard

-- 
Richard Ems
Tel: +49 40 65803 312
Fax: +49 40 65803 392
Richard.Ems@mtg-marinetechnik.de

MTG Marinetechnik GmbH - Wandsbeker Königstr. 62 - D 22041 Hamburg

GF Dipl.-Ing. Ullrich Keil
Handelsregister: Abt. B Nr. 11 500 - Amtsgericht Hamburg Abt. 66
USt.-IdNr.: DE 1186 70571

