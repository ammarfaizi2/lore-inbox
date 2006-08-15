Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965311AbWHOJDJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965311AbWHOJDJ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 15 Aug 2006 05:03:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965306AbWHOJDI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 15 Aug 2006 05:03:08 -0400
Received: from dsl027-180-168.sfo1.dsl.speakeasy.net ([216.27.180.168]:49593
	"EHLO sunset.davemloft.net") by vger.kernel.org with ESMTP
	id S965311AbWHOJC5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 15 Aug 2006 05:02:57 -0400
Date: Tue, 15 Aug 2006 02:02:59 -0700 (PDT)
Message-Id: <20060815.020259.80030950.davem@davemloft.net>
To: kevin@hilman.org
Cc: Linux-atm-general@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] net/atm compile error on ARM
From: David Miller <davem@davemloft.net>
In-Reply-To: <44E0CEC9.2050308@hilman.org>
References: <44E0CEC9.2050308@hilman.org>
X-Mailer: Mew version 4.2 on Emacs 21.4 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Kevin Hilman <kevin@hilman.org>
Date: Mon, 14 Aug 2006 12:28:09 -0700

> atm_proc_exit() is declared as __exit, and thus in .exit.text.  On
> some architectures (ARM) .exit.text is discarded at compile time, and
> since atm_proc_exit() is called by some other __init functions, it
> results in a link error.
> 
> Signed-off-by: Kevin Hilman <khilman@mvista.com>

Patch applied, thanks Kevin.
