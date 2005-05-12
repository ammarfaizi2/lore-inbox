Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261974AbVELOoD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261974AbVELOoD (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 12 May 2005 10:44:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261978AbVELOoD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 12 May 2005 10:44:03 -0400
Received: from gateway-1237.mvista.com ([12.44.186.158]:8947 "EHLO
	dhcp153.mvista.com") by vger.kernel.org with ESMTP id S261974AbVELOoB
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 12 May 2005 10:44:01 -0400
Date: Thu, 12 May 2005 07:43:58 -0700 (PDT)
From: Daniel Walker <dwalker@mvista.com>
To: mingo@elte.hu
cc: linux-kernel@vger.kernel.org
Subject: RT and Cascade interrupts
Message-ID: <Pine.LNX.4.44.0505120740270.31369-100000@dhcp153.mvista.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


	It seems like the cascade interrupts could run in threads, but 
i386 doesn't, and I know ARM crashed with cascades in threads. You may have a 
bit of a slow down, but it seems possible. Does anyone have some reasoning 
for why we aren't running the cascades in threads?

Daniel


