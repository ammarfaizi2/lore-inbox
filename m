Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261356AbVBGLL5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261356AbVBGLL5 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 7 Feb 2005 06:11:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261397AbVBGLL5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 7 Feb 2005 06:11:57 -0500
Received: from holomorphy.com ([66.93.40.71]:51163 "EHLO holomorphy.com")
	by vger.kernel.org with ESMTP id S261356AbVBGLL4 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 7 Feb 2005 06:11:56 -0500
Date: Mon, 7 Feb 2005 03:11:49 -0800
From: William Lee Irwin III <wli@holomorphy.com>
To: Jan Kasprzak <kas@fi.muni.cz>
Cc: linux-kernel@vger.kernel.org, torvalds@osdl.org
Subject: Re: Memory leak in 2.6.11-rc1?
Message-ID: <20050207111149.GH24805@holomorphy.com>
References: <20050121161959.GO3922@fi.muni.cz> <20050207110030.GI24513@fi.muni.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050207110030.GI24513@fi.muni.cz>
Organization: The Domain of Holomorphy
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 07, 2005 at 12:00:30PM +0100, Jan Kasprzak wrote:
> 	Well, with Linus' patch to fs/pipe.c the situation seems to
> improve a bit, but some leak is still there (look at the "monthly" graph
> at the above URL). The server has been running 2.6.11-rc2 + patch to fs/pipe.c
> for last 8 days. I am letting it run for a few more days in case you want
> some debugging info from a live system. I am attaching my /proc/meminfo
> and /proc/slabinfo.

Congratulations. You have 688MB of bio's.


-- wli
