Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964904AbVJDUX3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964904AbVJDUX3 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 4 Oct 2005 16:23:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964959AbVJDUX3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 4 Oct 2005 16:23:29 -0400
Received: from mail-in-05.arcor-online.net ([151.189.21.45]:64229 "EHLO
	mail-in-05.arcor-online.net") by vger.kernel.org with ESMTP
	id S964904AbVJDUX2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 4 Oct 2005 16:23:28 -0400
From: Bodo Eggert <harvested.in.lkml@7eggert.dyndns.org>
Subject: Re: Linker Problem
To: Sreeni <sreeni.pulichi@gmail.com>, linux-os@analogic.com,
       linux-kernel@vger.kernel.org
Reply-To: 7eggert@gmx.de
Date: Tue, 04 Oct 2005 22:23:15 +0200
References: <4U0Ek-3gT-5@gated-at.bofh.it>
User-Agent: KNode/0.7.2
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8Bit
Message-Id: <E1EMtJl-0000vD-Ce@be1.lrz>
X-be10.7eggert.dyndns.org-MailScanner-Information: See www.mailscanner.info for information
X-be10.7eggert.dyndns.org-MailScanner: Found to be clean
X-be10.7eggert.dyndns.org-MailScanner-From: harvested.in.lkml@posting.7eggert.dyndns.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Sreeni <sreeni.pulichi@gmail.com> wrote:

> My static kernel module demands the text/data to be placed at an
> absolute address.

This is a bug. Look at other drivers (e.g. drivers/video/hgafb.c)
on how to do that correctly.

Hint: This driver accesses 0x8000 bytes of memory starting at 0xb0000.

-- 
Ich danke GMX dafür, die Verwendung meiner Adressen mittels per SPF
verbreiteten Lügen zu sabotieren.
