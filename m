Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265482AbTFWVNP (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 23 Jun 2003 17:13:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265520AbTFWVNP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 23 Jun 2003 17:13:15 -0400
Received: from ausadmmsrr501.aus.amer.dell.com ([143.166.83.88]:57864 "HELO
	AUSADMMSRR501.aus.amer.dell.com") by vger.kernel.org with SMTP
	id S265482AbTFWVNM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 23 Jun 2003 17:13:12 -0400
X-Server-Uuid: ff595059-9672-488a-bf38-b4dee96ef25b
Message-ID: <16E52145F803EF44BE0CAB504CEF34E70115A5E9@ausx2kmpc106.aus.amer.dell.com>
From: Matt_Domsch@Dell.com
To: bunk@fs.tum.de
cc: linux-kernel@vger.kernel.org, trivial@rustcorp.com.au
Subject: RE: [2.5 patch] postfix a constant in efi.h with ULL
Date: Mon, 23 Jun 2003 16:27:07 -0500
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2653.19)
X-WSS-ID: 12E9AF327629090-01-01
Content-Type: text/plain; 
 charset=iso-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> The patch below postfixes a constant in efi.h with ULL, on 32 bit archs
> this constant is too big for an int.
> -#define GPT_HEADER_SIGNATURE 0x5452415020494645L
> +#define GPT_HEADER_SIGNATURE 0x5452415020494645ULL

Sounds good.  Please submit for 2.4.x also.

Thanks,
Matt

-- 
Matt Domsch
Sr. Software Engineer
Dell Linux Solutions www.dell.com/linux
Linux on Dell mailing lists @ http://lists.us.dell.com


