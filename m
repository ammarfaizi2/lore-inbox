Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751175AbWI3Pou@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751175AbWI3Pou (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 30 Sep 2006 11:44:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751182AbWI3Pou
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 30 Sep 2006 11:44:50 -0400
Received: from main.gmane.org ([80.91.229.2]:5819 "EHLO ciao.gmane.org")
	by vger.kernel.org with ESMTP id S1751175AbWI3Pot (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 30 Sep 2006 11:44:49 -0400
X-Injected-Via-Gmane: http://gmane.org/
To: linux-kernel@vger.kernel.org
From: Oleg Verych <olecom@flower.upol.cz>
Subject: Re: [patch 2.6.18-git] RTC class uses subsys_init
Date: Sat, 30 Sep 2006 15:44:12 +0000 (UTC)
Organization: Palacky University in Olomouc, experimental physics department.
Message-ID: <slrneht47s.3sb.olecom@deen.upol.cz.local>
References: <200609282333.34224.david-b@pacbell.net>
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: 158.194.180.30
User-Agent: slrn/0.9.8.1pl1 (Debian)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 2006-09-29, David Brownell <david-b@pacbell.net> wrote:
> [RESEND] 
>
> This makes RTC core components use "subsys_init" instead of "module_init",
> as appropriate for subsystem infrastructure.  This is mostly useful for
> statically linking drivers in other parts of the tree that may provide an
> RTC interface as a secondary functionality (e.g. part of a multifunction
> chip); they won't need to worry so much about drivers/Makefile link order.
>
> Signed-off-by: David Brownell <dbrownell@users.sourceforge.net>
>

ACK

