Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261645AbUL3NtQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261645AbUL3NtQ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 30 Dec 2004 08:49:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261643AbUL3NhW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 30 Dec 2004 08:37:22 -0500
Received: from mail1.kontent.de ([81.88.34.36]:1194 "EHLO Mail1.KONTENT.De")
	by vger.kernel.org with ESMTP id S261629AbUL3NgN (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 30 Dec 2004 08:36:13 -0500
From: Oliver Neukum <oliver@neukum.org>
To: Lei Ming <LeiMing@HotPop.com>
Subject: Re: What does "Tainted: P" or "Tainted: GF" mean?
Date: Thu, 30 Dec 2004 14:36:22 +0100
User-Agent: KMail/1.6.2
Cc: LKML <linux-kernel@vger.kernel.org>
References: <41D3FED3.7030909@HotPop.com>
In-Reply-To: <41D3FED3.7030909@HotPop.com>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
Message-Id: <200412301436.23272.oliver@neukum.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Am Donnerstag, 30. Dezember 2004 14:12 schrieb Lei Ming:
> Sorry for asking this silly question:
> 
> When I use lsmod to list all the modules, it displays "Tainted: P", and 
> on my friend's machine it's "Tainted: GF".
> 
> I know what "Tainted" mean, but what does "P" or "GF" mean? If there are 
> others than these two, where can I find a list?

kernel/panic.c:

/**
 *	print_tainted - return a string to represent the kernel taint state.
 *
 *  'P' - Proprietary module has been loaded.
 *  'F' - Module has been forcibly loaded.
 *  'S' - SMP with CPUs not designed for SMP.
 *  'R' - User forced a module unload.
 *  'M' - Machine had a machine check experience.
 *  'B' - System has hit bad_page.
 *
 *	The string is overwritten by the next call to print_taint().
 */

	HTH
		Oliver
