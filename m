Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261843AbUCaIfV (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 31 Mar 2004 03:35:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261844AbUCaIfV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 31 Mar 2004 03:35:21 -0500
Received: from grendel.digitalservice.pl ([217.67.200.140]:64417 "HELO
	mail.digitalservice.pl") by vger.kernel.org with SMTP
	id S261843AbUCaIfR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 31 Mar 2004 03:35:17 -0500
From: "R. J. Wysocki" <rjwysocki@sisk.pl>
Organization: SiSK
To: linux-kernel@vger.kernel.org
Subject: 2.6.5-rc3: unknown symbol in tekram.ko
Date: Wed, 31 Mar 2004 10:42:24 +0200
User-Agent: KMail/1.5
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200403311042.25265.rjwysocki@sisk.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I get something like this after 'make modules_install':

if [ -r System.map ]; then /sbin/depmod -ae -F System.map  2.6.5-rc3; fi
WARNING: /lib/modules/2.6.5-rc3/kernel/drivers/net/irda/tekram.ko needs 
unknown symbol irda_task_delete

-- 
Rafael J. Wysocki,
SiSK
[tel. (+48) 605 053 693]
----------------------------
For a successful technology, reality must take precedence over public 
relations, for nature cannot be fooled.
					-- Richard P. Feynman
