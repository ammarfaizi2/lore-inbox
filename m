Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129335AbRBEQvF>; Mon, 5 Feb 2001 11:51:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131020AbRBEQu4>; Mon, 5 Feb 2001 11:50:56 -0500
Received: from brutus.conectiva.com.br ([200.250.58.146]:17147 "EHLO
	brutus.conectiva.com.br") by vger.kernel.org with ESMTP
	id <S129335AbRBEQuw>; Mon, 5 Feb 2001 11:50:52 -0500
Date: Mon, 5 Feb 2001 14:49:58 -0200 (BRDT)
From: Rik van Riel <riel@conectiva.com.br>
To: Mohit Aron <aron@Zambeel.com>
cc: "'David Schwartz'" <davids@webmaster.com>, linux-kernel@vger.kernel.org
Subject: RE: system call sched_yield() doesn't work on Linux 2.2
In-Reply-To: <2B8089144916D411896D00D0B73C8353DB2C20@exchange.zambeel.com>
Message-ID: <Pine.LNX.4.21.0102051449080.1311-100000@duckman.distro.conectiva>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 4 Feb 2001, Mohit Aron wrote:

> you're expecting is lying in wait for me. Here is simple logic
> for you to figure out - if you have one run queue, and two
> threads calling sched_yield() (and hence theoretically putting
> themselves at the end of run queue), perfect alternation should
> be seen.

If you really feel as strongly about this as this
email suggests, why don't you send us a patch ?

Rik
--
Linux MM bugzilla: http://linux-mm.org/bugzilla.shtml

Virtual memory is like a game you can't win;
However, without VM there's truly nothing to lose...

		http://www.surriel.com/
http://www.conectiva.com/	http://distro.conectiva.com/

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
