Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129509AbRCTEAh>; Mon, 19 Mar 2001 23:00:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131705AbRCTEA1>; Mon, 19 Mar 2001 23:00:27 -0500
Received: from pizda.ninka.net ([216.101.162.242]:6531 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S129509AbRCTEAS>;
	Mon, 19 Mar 2001 23:00:18 -0500
From: "David S. Miller" <davem@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <15030.54685.535763.403057@pizda.ninka.net>
Date: Mon, 19 Mar 2001 19:59:25 -0800 (PST)
To: Fabio Riccardi <fabio@chromium.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: user space web server accelerator support
In-Reply-To: <3AB6D574.8C123AE9@chromium.com>
In-Reply-To: <3AB6D0A5.EC4807E3@chromium.com>
	<15030.54194.780246.320476@pizda.ninka.net>
	<3AB6D574.8C123AE9@chromium.com>
X-Mailer: VM 6.75 under 21.1 (patch 13) "Crater Lake" XEmacs Lucid
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Fabio Riccardi writes:
 > How can Apache "grab" the file descriptor?
 > 
 > My understanding is that file descriptors are data structures private to
 > a process...
 > 
 > Am I missing something?

Unix sockets allow one processes to "give" a file descriptor to
another process via a facility called "file descriptor passing".

Later,
David S. Miller
davem@redhat.com
