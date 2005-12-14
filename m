Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750906AbVLNF4j@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750906AbVLNF4j (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 Dec 2005 00:56:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751283AbVLNF4j
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 Dec 2005 00:56:39 -0500
Received: from smtp110.sbc.mail.re2.yahoo.com ([68.142.229.95]:45945 "HELO
	smtp110.sbc.mail.re2.yahoo.com") by vger.kernel.org with SMTP
	id S1750906AbVLNF4j (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 Dec 2005 00:56:39 -0500
From: Dmitry Torokhov <dtor_core@ameritech.net>
To: "Yu, Luming" <luming.yu@intel.com>
Subject: Re: [PATCH] Sonypi: convert to the new platform device interface
Date: Wed, 14 Dec 2005 00:56:36 -0500
User-Agent: KMail/1.8.3
Cc: "Andrew Morton" <akpm@osdl.org>, "LKML" <linux-kernel@vger.kernel.org>,
       "Stelian Pop" <stelian@popies.net>,
       "Mattia Dongili" <malattia@linux.it>,
       "Brown, Len" <len.brown@intel.com>
References: <3ACA40606221794F80A5670F0AF15F840A6A9A2D@pdsmsx403>
In-Reply-To: <3ACA40606221794F80A5670F0AF15F840A6A9A2D@pdsmsx403>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="gb2312"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200512140056.37021.dtor_core@ameritech.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 14 December 2005 00:46, Yu, Luming wrote:
> Maybe this is out of topic for this patch.
> But, from my understanding, sonypi.c should be cleanly implemented in ACPI.
>

Probably. However:

1. ACPI hotkey support is not complete AFAIK.
2. ACPI hotkey does not utilize input layer.
3. Sonypi allows using special keys if one does not want to use ACPI for one
   reason or another.

-- 
Dmitry
