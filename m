Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1756203AbWKVSEk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756203AbWKVSEk (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 22 Nov 2006 13:04:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756243AbWKVSEk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 22 Nov 2006 13:04:40 -0500
Received: from mailout05.sul.t-online.com ([194.25.134.82]:49130 "EHLO
	mailout05.sul.t-online.com") by vger.kernel.org with ESMTP
	id S1756203AbWKVSEk convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 22 Nov 2006 13:04:40 -0500
MIME-Version: 1.0
Subject: mapping of pages out of upper 128MB into kernel address space
From: <pledr@t-online.de>
To: <linux-kernel@vger.kernel.org>
X-Mailer: T-Online eMail 6.01.0001
Content-Type: Text/Plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Date: 22 Nov 2006 18:05 GMT
X-Antivirus: avast! (VPS 0650-0, 22.11.2006), Outbound message
X-Antivirus-Status: Clean
Message-ID: <1GmwSV-2BnPRg0@fwd32.sul.t-online.de>
X-ID: bVgZY2Zbre5Ods2EbSh3rI6aTSPk4vPxX5ndkicOE-dqU1kPCFM8Em
X-TOI-MSGID: 12a85756-5a6a-4955-90c5-aa6f2c1f69bc
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,
in a kernel module I have to translate user addresses into kernel addresses. The user uses shared memory allocated with shm_open / ftruncate. This shared memory is allocated somewhere in the upmost 128MB of physical memory that is NOT permanently mapped into the kernel ( found in swapper_pg_dir ). How can I "smp_save" map this memory into the kernel address space ?

Kind regards
Peter Lezoch
