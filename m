Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261860AbUJZAUM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261860AbUJZAUM (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 25 Oct 2004 20:20:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261317AbUJZAUE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 25 Oct 2004 20:20:04 -0400
Received: from alephnull.demon.nl ([212.238.201.82]:8077 "EHLO
	xi.wantstofly.org") by vger.kernel.org with ESMTP id S261915AbUJYPDv
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 25 Oct 2004 11:03:51 -0400
Date: Mon, 25 Oct 2004 17:03:49 +0200
From: Lennert Buytenhek <buytenh@wantstofly.org>
To: kraxel@bytesex.org, linux-kernel@vger.kernel.org
Subject: bttv hang problem on 2.6.8
Message-ID: <20041025150349.GA22915@xi.wantstofly.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

(please CC on replies, I'm not on the list)

Hi,

When there is a background thread doing VIDIOCSYNC in a loop, issuing
VIDIOCSPICT in the current thread on the same file descriptor causes
it to go into uninterruptable sleep and hang.  This is on kernel 2.6.8
using the bttv driver, and appears easily reproducible.

Anyone any ideas?


thanks,
Lennert
