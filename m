Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261937AbUKPISW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261937AbUKPISW (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 16 Nov 2004 03:18:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261936AbUKPISW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 16 Nov 2004 03:18:22 -0500
Received: from colino.net ([213.41.131.56]:57332 "EHLO paperstreet.colino.net")
	by vger.kernel.org with ESMTP id S261937AbUKPIST (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 16 Nov 2004 03:18:19 -0500
Date: Tue, 16 Nov 2004 09:17:43 +0100
From: Colin Leroy <colin.lkml@colino.net>
To: Philipp Matthias Hahn <pmhahn@titan.lahn.de>
Cc: Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Antonino Daplas <adaplas@pol.net>
Subject: Re: Linux 2.6.10-rc2 SAVAGEFB startup crash
Message-ID: <20041116091743.78c5111f.colin.lkml@colino.net>
In-Reply-To: <20041116075548.GB4014@titan.lahn.de>
References: <Pine.LNX.4.58.0411141835150.2222@ppc970.osdl.org>
	<20041116075548.GB4014@titan.lahn.de>
X-Mailer: Sylpheed-Claws 0.9.12cvs146.11 (GTK+ 2.4.0; i686-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 16 Nov 2004 at 08h11, Philipp Matthias Hahn wrote:

Hi, 

> savagefb_create_i2c_busses+0x44/0xf0

You can also try
gdb> list *savagefb_create_i2c_busses+0x44

to get the corresponding chunk of code if your kernel has CONFIG_DEBUG.
-- 
Colin
