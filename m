Return-Path: <linux-kernel-owner+willy=40w.ods.org-S933568AbWKWKp0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933568AbWKWKp0 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 23 Nov 2006 05:45:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933572AbWKWKp0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 23 Nov 2006 05:45:26 -0500
Received: from outmail1.freedom2surf.net ([194.106.33.237]:19655 "EHLO
	outmail.freedom2surf.net") by vger.kernel.org with ESMTP
	id S933568AbWKWKpZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 23 Nov 2006 05:45:25 -0500
Message-ID: <45657BD4.5040604@f2s.com>
Date: Thu, 23 Nov 2006 10:45:40 +0000
From: Ian Molton <spyro@f2s.com>
Organization: The Dragon Roost
User-Agent: Thunderbird 2.0a1 (X11/20061107)
MIME-Version: 1.0
To: linux-kernel-Mailing-list <linux-kernel@vger.kernel.org>
Subject: BUG: 2.6.19-rc6 net/irda/irlmp.c
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

spin_lock_irqsave_nested is used in net/irda/irlmp.c

Im not sure what it _should_ be, but thought it worth reporting.
