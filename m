Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268379AbUIWKu6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268379AbUIWKu6 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 23 Sep 2004 06:50:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268381AbUIWKu6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 23 Sep 2004 06:50:58 -0400
Received: from fw.osdl.org ([65.172.181.6]:46781 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S268379AbUIWKu5 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 23 Sep 2004 06:50:57 -0400
Date: Thu, 23 Sep 2004 03:48:50 -0700
From: Andrew Morton <akpm@osdl.org>
To: Lukas Hejtmanek <xhejtman@mail.muni.cz>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.9-rc2-mm2 fn_hash_insert oops
Message-Id: <20040923034850.1f48e467.akpm@osdl.org>
In-Reply-To: <20040923103723.GA12145@mail.muni.cz>
References: <20040923100906.GB11230@mail.muni.cz>
	<20040923031451.56147952.akpm@osdl.org>
	<20040923103723.GA12145@mail.muni.cz>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Lukas Hejtmanek <xhejtman@mail.muni.cz> wrote:
>
> However there is still the issue with endless loop in fn_hash_delete :(

Well there are a couple of other fixes in there.

You could try http://www.zip.com.au/~akpm/linux/patches/stuff/x.bz2 which
is my current tree, against 2.6.9-rc2.  It has the recent net fixes.
