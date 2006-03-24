Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932458AbWCXQeO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932458AbWCXQeO (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 24 Mar 2006 11:34:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932459AbWCXQeO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 24 Mar 2006 11:34:14 -0500
Received: from relay4.usu.ru ([194.226.235.39]:60125 "EHLO relay4.usu.ru")
	by vger.kernel.org with ESMTP id S932458AbWCXQeN (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 24 Mar 2006 11:34:13 -0500
Message-ID: <44241FF9.9070904@ums.usu.ru>
Date: Fri, 24 Mar 2006 21:36:09 +0500
From: "Alexander E. Patrakov" <patrakov@ums.usu.ru>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; ru-RU; rv:1.8.0.1) Gecko/20060130 SeaMonkey/1.0
MIME-Version: 1.0
To: LKML <linux-kernel@vger.kernel.org>
Subject: 2.6.16: Broken deps of spectrum_cs
Content-Type: text/plain; charset=KOI8-R; format=flowed
Content-Transfer-Encoding: 7bit
X-AntiVirus: checked by AntiVir MailGate (version: 2.0.1.15; AVE: 6.34.0.14; VDF: 6.34.0.95; host: usu2.usu.ru)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In linux-2.6.16, it is possible to compile spectrum_cs.ko without enabling 
firmware loader. Result:

WARNING: /lib/modules/2.6.16/kernel/drivers/net/wireless/spectrum_cs.ko 
needs unknown symbol request_firmware

-- 
Alexander E. Patrakov
