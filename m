Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S270226AbRHGX3b>; Tue, 7 Aug 2001 19:29:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S270219AbRHGX3U>; Tue, 7 Aug 2001 19:29:20 -0400
Received: from router-100M.swansea.linux.org.uk ([194.168.151.17]:62738 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S270218AbRHGX3O>; Tue, 7 Aug 2001 19:29:14 -0400
Subject: Re: Exporting kernel memory to application
To: imran.badr@cavium.com
Date: Wed, 8 Aug 2001 00:31:20 +0100 (BST)
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <003501c11f8f$aa9d6270$6401a8c0@IMRANPC> from "Imran Badr" at Aug 07, 2001 03:24:03 PM
X-Mailer: ELM [version 2.5 PL5]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E15UGJk-0004Gc-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> I am in a situation where it is required to export a kernel memory
> (allocated by kmalloc in the device driver) to the user application. I would
> really appreciate any guidance or suggestion.

Look at the sound drivers, they do this, although with memory allocated
by get_free_pages() - the rest of the theory is the same
