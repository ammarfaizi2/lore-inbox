Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261249AbTFTEzv (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 20 Jun 2003 00:55:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261414AbTFTEzu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 20 Jun 2003 00:55:50 -0400
Received: from dp.samba.org ([66.70.73.150]:3814 "EHLO lists.samba.org")
	by vger.kernel.org with ESMTP id S261249AbTFTEzt (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 20 Jun 2003 00:55:49 -0400
From: Rusty Russell <rusty@rustcorp.com.au>
To: Adrian Bunk <bunk@fs.tum.de>
Cc: support@moxa.com.tw, linux-kernel@vger.kernel.org
Subject: Re: [2.5 patch] remove two unused variables from mxser.c 
In-reply-to: Your message of "Fri, 20 Jun 2003 01:12:23 +0200."
             <20030619231222.GF29247@fs.tum.de> 
Date: Fri, 20 Jun 2003 14:31:06 +1000
Message-Id: <20030620050950.32FB52C11D@lists.samba.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In message <20030619231222.GF29247@fs.tum.de> you write:
> The patch below removes two unused variables from drivers/char/mxser.c .

While you're there, would you fix the init returning "-1" for no good
reason at the bottom, too?  (I don't think they really meant EPERM).

Thanks,
Rusty.
--
  Anyone who quotes me in their sig is an idiot. -- Rusty Russell.
