Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261464AbUCPL7R (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 16 Mar 2004 06:59:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261582AbUCPL7R
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 16 Mar 2004 06:59:17 -0500
Received: from smtp-out.girce.epro.fr ([195.6.195.146]:55262 "EHLO
	srvsec2.girce.epro.fr") by vger.kernel.org with ESMTP
	id S261464AbUCPL7Q (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 16 Mar 2004 06:59:16 -0500
Message-ID: <05bf01c40b4d$553bdb70$3cc8a8c0@epro.dom>
From: "Colin Leroy" <colin@colino.net>
To: <linux-kernel@vger.kernel.org>
Cc: "Benjamin Herrenschmidt" <benh@kernel.crashing.org>,
       "Tom Rini" <trini@kernel.crashing.org>
Subject: 2.6.5-rc1: compilation error on ppc32
Date: Tue, 16 Mar 2004 12:53:44 +0100
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2800.1158
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1165
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

2.6.5-rc1 compilation fails at arch/ppc/syslib/indirect_pci.c lines 47 and
86: variable dev isn't defined.
The change breaking it is a change from out_be32() to PCI_CFG_OUT (line
17513 of the patch at
http://www.kernel.org/pub/linux/kernel/v2.6/testing/patch-2.6.5-rc1.bz2 ,
which strangely enough doesn't show in bkweb interface).

-- 
Colin
  This message represents the official view of the voices
  in my head.

