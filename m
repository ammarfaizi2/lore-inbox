Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261745AbVDRGU6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261745AbVDRGU6 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 18 Apr 2005 02:20:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261757AbVDRGU5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 18 Apr 2005 02:20:57 -0400
Received: from wproxy.gmail.com ([64.233.184.205]:22540 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261745AbVDRGUx convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 18 Apr 2005 02:20:53 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=hbjJFhwKQxceWp5sN6GaVNq5ef7uZOaxcYzJPKs7v948i6G1idNmrrX/+Hat3Zglc8lBmzDK4QA8DjJ2S0aNHBEw+BCxoReBLMhiMrUUyWRAe/zVVPEJuKE5vRBfRhNDgTyjsiiDYQffSSV3iU519LI0nCmdPSASlLuVX4V33Pg=
Message-ID: <17d798805041723205bd480ca@mail.gmail.com>
Date: Mon, 18 Apr 2005 02:20:51 -0400
From: Allison <fireflyblue@gmail.com>
Reply-To: Allison <fireflyblue@gmail.com>
To: linux-kernel@vger.kernel.org
Subject: Kernel page table and module text
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Since module is loaded in non-contiguous memory, there has to be an
entry in the kernel page table for all modules that are loaded on the
system. I am trying to find entries corresponding to my module text in
the page tables.

I am not clear about how the kernel page table is organized after the
system switches to protected mode.

I printed out the page starting with swapper_pg_dir . But I do not
find the addresses for all the modules loaded in the system.

Do I still need to read the pg0 and pg1 pages ?

If somebody can explain how to traverse the kernel page tables, that
would be very helpful.

thanks,
Allison
