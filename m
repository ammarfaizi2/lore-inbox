Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S136024AbREHAGw>; Mon, 7 May 2001 20:06:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S136017AbREHAGm>; Mon, 7 May 2001 20:06:42 -0400
Received: from pizda.ninka.net ([216.101.162.242]:9387 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S136024AbREHAGa>;
	Mon, 7 May 2001 20:06:30 -0400
From: "David S. Miller" <davem@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <15095.14467.446430.966055@pizda.ninka.net>
Date: Mon, 7 May 2001 17:06:27 -0700 (PDT)
To: Linus Torvalds <torvalds@transmeta.com>
Cc: Marcelo Tosatti <marcelo@conectiva.com.br>, linux-kernel@vger.kernel.org
Subject: Re: page_launder() bug
In-Reply-To: <Pine.LNX.4.21.0105071645070.7915-100000@penguin.transmeta.com>
In-Reply-To: <Pine.LNX.4.21.0105071848210.7515-100000@freak.distro.conectiva>
	<Pine.LNX.4.21.0105071645070.7915-100000@penguin.transmeta.com>
X-Mailer: VM 6.75 under 21.1 (patch 13) "Crater Lake" XEmacs Lucid
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Linus Torvalds writes:
 > What do you expect me to do? The patch is buggy. It should be reverted.
 > What's your problem?

I think the problem he has is that you are acting as if the patch
causes corruptions and will end in failures.  This is how you are
coming across, at least.

Really, your problem with the patch seems to be aesthetic in nature
and that the patch is not doing things cleanly at all.  To this I will
not contest, it surely is not the way to fix this in the end.

If my analysis up to this point is correct, the patch should in fact
not be reverted.  Many patches in Alan's tree are not done in the most
aesthetically pleasing way to you, we all know this. But they do solve
problems for people.  Half of Alan's tree should be reverted if we
followed this rule, really.

Later,
David S. Miller
davem@redhat.com
