Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S272282AbTHEVLh (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 5 Aug 2003 17:11:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272303AbTHEVLg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 5 Aug 2003 17:11:36 -0400
Received: from colin2.muc.de ([193.149.48.15]:11535 "HELO colin2.muc.de")
	by vger.kernel.org with SMTP id S272282AbTHEVLQ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 5 Aug 2003 17:11:16 -0400
Date: 5 Aug 2003 23:11:12 +0200
Date: Tue, 5 Aug 2003 23:11:12 +0200
From: Andi Kleen <ak@colin2.muc.de>
To: Arjan van de Ven <arjanv@redhat.com>
Cc: Andrew Morton <akpm@osdl.org>, Andi Kleen <ak@muc.de>, torvalds@osdl.org,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Export touch_nmi_watchdog
Message-ID: <20030805211112.GC31598@colin2.muc.de>
References: <20030805192908.GA19867@averell> <20030805123811.1fe61585.akpm@osdl.org> <20030805200810.GA31598@colin2.muc.de> <1060114808.5308.9.camel@laptop.fenrus.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1060114808.5308.9.camel@laptop.fenrus.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> having a more generic/portable "trigger_watchdog" function would be
> better then, such that ALL watchdogs, and not just the NMI one can hook
> into this

Well the function is already used and it's just a name. You could always
hook other watchdogs into it too.

-Andi
