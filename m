Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262982AbVGNJgD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262982AbVGNJgD (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 14 Jul 2005 05:36:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262985AbVGNJgD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 14 Jul 2005 05:36:03 -0400
Received: from linux01.gwdg.de ([134.76.13.21]:42430 "EHLO linux01.gwdg.de")
	by vger.kernel.org with ESMTP id S262982AbVGNJgB (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 14 Jul 2005 05:36:01 -0400
Date: Thu, 14 Jul 2005 11:35:53 +0200 (MEST)
From: Jan Engelhardt <jengelh@linux01.gwdg.de>
To: Albert Herranz <albert_herranz@yahoo.es>
cc: benh@kernel.crashing.org, linux-kernel@vger.kernel.org
Subject: Re: console remains blanked
In-Reply-To: <20050713231200.24037.qmail@web25801.mail.ukl.yahoo.com>
Message-ID: <Pine.LNX.4.61.0507141134060.18072@yvahk01.tjqt.qr>
References: <20050713231200.24037.qmail@web25801.mail.ukl.yahoo.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


>Looks like, since [1] was merged, a blanked console
>(due to inactivity for example) doesn't get unblanked
>anymore when new output is written to it.

The console is unblanked when you hit a key (or probably move a mouse too), 
not when some application outputs something on stdout/stderr/etc.

>[1]
>http://marc.theaimsgroup.com/?l=linux-kernel&m=111052009232499&w=2

Which kernel versions have this patch? I'm on 2.6.13-rc1 and have no problems 
with unblanking.



Jan Engelhardt
-- 
