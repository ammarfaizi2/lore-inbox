Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261394AbUBTVBE (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 20 Feb 2004 16:01:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261401AbUBTVBE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 20 Feb 2004 16:01:04 -0500
Received: from 209-166-240-202.cust.walrus.com ([209.166.240.202]:6861 "EHLO
	ti3.telemetry-investments.com") by vger.kernel.org with ESMTP
	id S261394AbUBTVA7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 20 Feb 2004 16:00:59 -0500
Date: Fri, 20 Feb 2004 16:00:45 -0500
From: "Bill Rugolsky Jr." <brugolsky@telemetry-investments.com>
To: torvalds@osdl.org, akpm@osdl.org
Cc: linux-kernel@vger.kernel.org, brugolsky@telemetry-investments.com
Subject: [PATCH][0/4] poll()/select() timeout behavior
Message-ID: <20040220210045.GA1912@ti19.telemetry-investments.com>
Mail-Followup-To: "Bill Rugolsky Jr." <brugolsky@telemetry-investments.com>,
	torvalds@osdl.org, akpm@osdl.org, linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The following patches against linux-2.6.3 address several issues related
to timeouts in sys_poll() and sys_select().  The same problems exist in
2.4. One or more of the (trivially small) patches may be controversial,
so I've split them for purposes of discussion.

Regards,

	Bill Rugolsky
