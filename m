Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261543AbVB1D4p@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261543AbVB1D4p (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 27 Feb 2005 22:56:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261550AbVB1D4p
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 27 Feb 2005 22:56:45 -0500
Received: from fire.osdl.org ([65.172.181.4]:41629 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S261543AbVB1D4o (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 27 Feb 2005 22:56:44 -0500
Message-ID: <422293DE.9030007@osdl.org>
Date: Sun, 27 Feb 2005 19:45:34 -0800
From: "Randy.Dunlap" <rddunlap@osdl.org>
User-Agent: Mozilla Thunderbird 0.9 (X11/20041103)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: "Randy.Dunlap" <rddunlap@osdl.org>
CC: lkml <linux-kernel@vger.kernel.org>, torvalds <torvalds@osdl.org>,
       akpm <akpm@osdl.org>
Subject: Re: [PATCH] parport_pc: use devinitdata
References: <20050227192916.037f479f.rddunlap@osdl.org>
In-Reply-To: <20050227192916.037f479f.rddunlap@osdl.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Randy.Dunlap wrote:
> parport_init_mode is used by devinit code so it should be __devinitdata;
> 
> Error: ./drivers/parport/parport_pc.o .text refers to 0000000000002601 R_X86_64_PC32     .init.data+0x00000000000000e0

Yes, aeb already fixed this one....  ignore it.

-- 
~Randy
