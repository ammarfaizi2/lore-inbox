Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261208AbSIWMmb>; Mon, 23 Sep 2002 08:42:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261228AbSIWMmb>; Mon, 23 Sep 2002 08:42:31 -0400
Received: from [217.167.51.129] ([217.167.51.129]:27892 "EHLO zion.wanadoo.fr")
	by vger.kernel.org with ESMTP id <S261208AbSIWMma>;
	Mon, 23 Sep 2002 08:42:30 -0400
From: "Benjamin Herrenschmidt" <benh@kernel.crashing.org>
To: "Remco Post" <r.post@sara.nl>, <linux-kernel@vger.kernel.org>
Subject: Re: 2.5.38 on ppc/prep
Date: Mon, 23 Sep 2002 03:14:04 +0200
Message-Id: <20020923011404.31301@192.168.4.1>
In-Reply-To: <692386AC-CEEC-11D6-A08A-000393911DE2@sara.nl>
References: <692386AC-CEEC-11D6-A08A-000393911DE2@sara.nl>
X-Mailer: CTM PowerMail 4.0.1 carbon <http://www.ctmdev.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>after some tiny fixes to reiserfs and the makefile for prep bootfile 
>(using ../lib/lib.a vs. ../lib/libz.a) I managed to succesfully compile 
>a kernel. It even boots to the point where it frees unused kernel memory 
>and then stops... this includes succesfully mounting the root 
>filesystem...
>
>Just to let the world know what does and doesn't work on my powerstack 
>mobo.

Might be related to the mprotect bug signaled by Paul Mackerras
earlier on this list. Try using the linuxppc-2.5 bk tree

Ben.


