Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129944AbRAUVLV>; Sun, 21 Jan 2001 16:11:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129999AbRAUVLN>; Sun, 21 Jan 2001 16:11:13 -0500
Received: from rhdv.cistron.nl ([195.64.71.178]:5897 "EHLO rhdv.cistron.nl")
	by vger.kernel.org with ESMTP id <S129944AbRAUVLA>;
	Sun, 21 Jan 2001 16:11:00 -0500
Date: Sun, 21 Jan 2001 23:06:45 +0200
From: "Robert H. de Vries" <rhdv@rhdv.cistron.nl>
To: "Linus Torvalds" <torvalds@transmeta.com>
Subject: [ANN] POSIX timer patch for 2.4.0
Message-ID: <Pine.LNX.4.21.0007231135020.1019-100000@rhdv.cistron.nl>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Loop: majordomo@vger.rutgers.edu
X-Mailer: KMail [version 1.1.99]
Cc: "Kernel Mailing List" <linux-kernel@vger.kernel.org>
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

This patch adds the POSIX timer system calls to the kernel.

The patch has been in a stable state for some time now.
It has been tested on intel hardware only (SMP and UP).
It also has been in use by myself and some other people for a year or so, 
which gives me some confidence that there are no bugs left.

As this patch does not influence other kernel code, it is my opinion that it 
is safe to add. So please feel free to add this to the mainstream kernel 
distribution. Comments are also welcome.

The kernel patch and auxiliary code can be found on my web
page: http://www.rhdv.cistron.nl/posix.html as the patch is largish (70 kB).
The direct link to the patch is http://www.rhdv.cistron.nl/2.4.0.timer.patch

	Robert

-- 
Robert de Vries
rhdv@rhdv.cistron.nl
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
