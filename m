Return-Path: <linux-kernel-owner+willy=40w.ods.org-S270033AbUJHQCZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270033AbUJHQCZ (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 8 Oct 2004 12:02:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270044AbUJHQCX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 8 Oct 2004 12:02:23 -0400
Received: from village.ehouse.ru ([193.111.92.18]:54539 "EHLO mail.ehouse.ru")
	by vger.kernel.org with ESMTP id S270033AbUJHQCB (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 8 Oct 2004 12:02:01 -0400
From: "Sergey S. Kostyliov" <rathamahata@ehouse.ru>
Reply-To: "Sergey S. Kostyliov" <rathamahata@ehouse.ru>
To: "Mukker, Atul" <Atulm@lsil.com>
Subject: Re: Megaraid random loss of luns
Date: Fri, 8 Oct 2004 20:01:47 +0400
User-Agent: KMail/1.7
Cc: comsatcat@earthlink.net, linux-kernel@vger.kernel.org
References: <0E3FA95632D6D047BA649F95DAB60E57033BCAD6@exa-atlanta>
In-Reply-To: <0E3FA95632D6D047BA649F95DAB60E57033BCAD6@exa-atlanta>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200410082001.48141.rathamahata@ehouse.ru>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!
On Friday 08 October 2004 16:51, Mukker, Atul wrote:
> I _highly_ recommend to replace the default driver with the latest 2.20.4.0
> driver and retry.

Unfortunately, version 2.20.4.0 doesn't recognize my AMI megaraid 160 (Series 475)

[rathamahata@white megaraid]$ grep Version ./megaraid_mbox.c
 * Version      : v2.20.4 (September 27 2004)
[rathamahata@white megaraid]$ /sbin/lspci  | grep Mega
02:04.0 RAID bus controller: American Megatrends Inc. MegaRAID (rev 02)
[rathamahata@white megaraid]$ /sbin/lspci -n  | grep 02:04.0
02:04.0 Class 0104: 101e:1960 (rev 02)
[rathamahata@white megaraid]$


-- 
Sergey S. Kostyliov <rathamahata@ehouse.ru>
Jabber ID: rathamahata@jabber.org
