Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270158AbTGMHxy (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 13 Jul 2003 03:53:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270159AbTGMHxy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 13 Jul 2003 03:53:54 -0400
Received: from pc2-cwma1-4-cust86.swan.cable.ntl.com ([213.105.254.86]:29115
	"EHLO lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP
	id S270158AbTGMHxx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 13 Jul 2003 03:53:53 -0400
Subject: Re: Replace mod_inc_use_count with __module_get for watchdog
	drivers
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Jan Dittmer <j.dittmer@portrix.net>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <3F108837.8060604@portrix.net>
References: <3F108837.8060604@portrix.net>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Organization: 
Message-Id: <1058083553.31918.13.camel@dhcp22.swansea.linux.org.uk>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 (1.2.2-5) 
Date: 13 Jul 2003 09:05:53 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sad, 2003-07-12 at 23:14, Jan Dittmer wrote:
> Hi,
> 
> I found this comment in mixcomwd.c and proceeded accordingly.
> This prevents the watchdog drivers from being unloaded after initialized and 
> gets rid of the warnings. This doesn't just remove any occurance of 
> MOD_INC_USE_COUNT, but replaces it with __module_get().
> Is this correct?

Looks good to me.

