Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030306AbWGFQXV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030306AbWGFQXV (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 6 Jul 2006 12:23:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030310AbWGFQXV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 6 Jul 2006 12:23:21 -0400
Received: from pentafluge.infradead.org ([213.146.154.40]:18583 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S1030306AbWGFQXU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 6 Jul 2006 12:23:20 -0400
Subject: Re: 2.6.17 x86_64 regression - reboot fails due to deadlock
From: Arjan van de Ven <arjan@infradead.org>
To: "Mr. Berkley Shands" <bshands@exegy.com>
Cc: linux-kernel@vger.kernel.org, Dave Lloyd <dlloyd@exegy.com>
In-Reply-To: <44AD37C2.50601@exegy.com>
References: <44AD37C2.50601@exegy.com>
Content-Type: text/plain
Date: Thu, 06 Jul 2006 18:23:16 +0200
Message-Id: <1152202996.3084.60.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <arjan@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> In kdb, the system sits idle awaiting something to schedule, but nothing 
> will schedule since there is
> a deadlock on the supermicro. Any clues as to how to find which notifier 
> is deadlocked?

Hi,


if it's really a deadlock, then lockdep (new in 2.6.18-rc1) ought to
find it... just enable the various locking debug options in the -rc1
kernel and... it's active.


Greetings,
  Arjan van de Ven

