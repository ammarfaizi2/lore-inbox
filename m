Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129562AbRAOPZP>; Mon, 15 Jan 2001 10:25:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131048AbRAOPZE>; Mon, 15 Jan 2001 10:25:04 -0500
Received: from [62.254.209.2] ([62.254.209.2]:51185 "EHLO cam-gw.zeus.co.uk")
	by vger.kernel.org with ESMTP id <S129562AbRAOPY7>;
	Mon, 15 Jan 2001 10:24:59 -0500
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <14947.5703.60574.309140@leda.cam.zeus.com>
Date: Mon, 15 Jan 2001 15:24:55 +0000
From: Jonathan Thackray <jthackray@zeus.com>
To: linux-kernel@vger.kernel.org
Subject: Re: Is sendfile all that sexy?
In-Reply-To: <93t1q7$49c$1@penguin.transmeta.com>
X-Mailer: VM 6.89 under 21.1 (patch 3) "Acadia" XEmacs Lucid
Organization: Zeus Technology Ltd
X-Tel: +44 1223 525000
X-Fax: +44 1223 525100
X-Url: http://www.zeus.com/
X-Scanner: exiscan *14IBV9-00045G-00*iAwBbc5pTAM* http://duncanthrax.net/exiscan/
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> Does anybody but apache actually use it?

Zeus uses it! (it was HP who added it to HP-UX first at our request :-)

> PS.  I still _like_ sendfile(), even if the above sounds negative.  It's
> basically a "cool feature" that has zero negative impact on the design
> of the system.  It uses the same "do_generic_file_read()" that is used
> for normal "read()", and is also used by the loop device and by
> in-kernel fileserving.  But it's not really "important". 

It's a very useful system call and makes file serving much more
scalable, and I'm glad that most Un*xes now have support for it
(Linux, FreeBSD, HP-UX, AIX, Tru64). The next cool feature to add to
Linux is sendpath(), which does the open() before the sendfile()
all combined into one system call.

Ugh, I hear you all scream :-)

Jon.

-- 
Jonathan Thackray         Zeus House, Cowley Road, Cambridge CB4 OZT, UK
Software Engineer                   +44 1223 525000, fax +44 1223 525100
Zeus Technology                                     http://www.zeus.com/

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
