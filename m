Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131542AbRCSSoa>; Mon, 19 Mar 2001 13:44:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131573AbRCSSoU>; Mon, 19 Mar 2001 13:44:20 -0500
Received: from perninha.conectiva.com.br ([200.250.58.156]:48134 "HELO
	postfix.conectiva.com.br") by vger.kernel.org with SMTP
	id <S131542AbRCSSoL>; Mon, 19 Mar 2001 13:44:11 -0500
Date: Mon, 19 Mar 2001 22:56:18 -0300 (BRST)
From: Rik van Riel <riel@conectiva.com.br>
X-X-Sender: <riel@duckman.distro.conectiva>
To: Mike Galbraith <mikeg@wen-online.de>
Cc: Linus Torvalds <torvalds@transmeta.com>, <linux-mm@kvack.org>,
        <linux-kernel@vger.kernel.org>
Subject: 3rd version of R/W mmap_sem patch available
In-Reply-To: <Pine.LNX.4.33.0103191802330.2076-100000@mikeg.weiden.de>
Message-ID: <Pine.LNX.4.33.0103192254130.1320-100000@duckman.distro.conectiva>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 19 Mar 2001, Mike Galbraith wrote:

> @@ -1135,6 +1170,7 @@
	[large patch]

I've been finding small bugs in both my late-night code and in
Mike's code and have redone the changes in do_anonymous_page(),
do_no_page() and do_swap_page() much more carefully...

Now the code is beautiful and it might even be bugfree ;)

If you feel particularly adventurous, please help me test the
patch; it is available from:

	http://www.surriel.com/patches/2.4/2.4.2-ac20-rwmmap_sem3

regards,

Rik
--
Linux MM bugzilla: http://linux-mm.org/bugzilla.shtml

Virtual memory is like a game you can't win;
However, without VM there's truly nothing to lose...

		http://www.surriel.com/
http://www.conectiva.com/	http://distro.conectiva.com/

