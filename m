Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268729AbUJKJDB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268729AbUJKJDB (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 11 Oct 2004 05:03:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268730AbUJKJDB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 11 Oct 2004 05:03:01 -0400
Received: from wproxy.gmail.com ([64.233.184.204]:9707 "EHLO mproxy.gmail.com")
	by vger.kernel.org with ESMTP id S268729AbUJKJC6 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 11 Oct 2004 05:02:58 -0400
Message-ID: <1a50bd37041011020211e96208@mail.gmail.com>
Date: Mon, 11 Oct 2004 14:32:53 +0530
From: Ricky lloyd <ricky.lloyd@gmail.com>
Reply-To: Ricky lloyd <ricky.lloyd@gmail.com>
To: linux-kernel@vger.kernel.org
Subject: 2.6.9-rc4: warnings galore
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

hi,

Now that readw(), writew() etc family of routines are inline
functions, looks like this change
has resulted in gcc spewing out lots of warnings about not type
casting the args for these
routines.

is typecasting all the concerned args to (void __iomem *) the only
solution to this ? if yes,
there are a lot of places to fix this in the drivers/ subdir. I can go
ahead and submit a patch.

did i miss anything by the way ???


-- 
-> Ricky
