Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131716AbRCTDw1>; Mon, 19 Mar 2001 22:52:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131717AbRCTDwR>; Mon, 19 Mar 2001 22:52:17 -0500
Received: from pizda.ninka.net ([216.101.162.242]:1923 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S131716AbRCTDwI>;
	Mon, 19 Mar 2001 22:52:08 -0500
From: "David S. Miller" <davem@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <15030.54194.780246.320476@pizda.ninka.net>
Date: Mon, 19 Mar 2001 19:51:14 -0800 (PST)
To: Fabio Riccardi <fabio@chromium.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: user space web server accelerator support
In-Reply-To: <3AB6D0A5.EC4807E3@chromium.com>
In-Reply-To: <3AB6D0A5.EC4807E3@chromium.com>
X-Mailer: VM 6.75 under 21.1 (patch 13) "Crater Lake" XEmacs Lucid
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Fabio Riccardi writes:
 > How could this be fixed?

Why not pass the filedescriptors to apache over a UNIX domain
socket?  I see no need for a new facility.

Later,
David S. Miller
davem@redhat.com
