Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129881AbQJaBHx>; Mon, 30 Oct 2000 20:07:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129988AbQJaBHo>; Mon, 30 Oct 2000 20:07:44 -0500
Received: from ns.caldera.de ([212.34.180.1]:52999 "EHLO ns.caldera.de")
	by vger.kernel.org with ESMTP id <S129881AbQJaBHf>;
	Mon, 30 Oct 2000 20:07:35 -0500
Date: Tue, 31 Oct 2000 02:05:38 +0100
From: Christoph Hellwig <hch@ns.caldera.de>
To: Michael Elizabeth Chastain <mec@shout.net>
Cc: torvalds@transmeta.com, jgarzik@mandrakesoft.com, kaos@ocs.com.au,
        linux-kernel@vger.kernel.org
Subject: Re: test10-pre7
Message-ID: <20001031020538.A21452@caldera.de>
Mail-Followup-To: Michael Elizabeth Chastain <mec@shout.net>,
	torvalds@transmeta.com, jgarzik@mandrakesoft.com, kaos@ocs.com.au,
	linux-kernel@vger.kernel.org
In-Reply-To: <200010310052.SAA21366@duracef.shout.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 1.0i
In-Reply-To: <200010310052.SAA21366@duracef.shout.net>; from mec@shout.net on Mon, Oct 30, 2000 at 06:52:08PM -0600
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 30, 2000 at 06:52:08PM -0600, Michael Elizabeth Chastain wrote:
> Let me see if I have all this straight:
> 
> (1) Change Rules.make to use "new style" variables as its native form.
>     (1A) Add a "Compat.make" for old style Makefiles, and
>     (1B) Continue to convert all the remaining old style Makefiles.

This is difficult because old-style makefiles can do much more magic
then list-style ones.  But after a bit more thinking it looks like is
is possible ... (yeah I said otherwise some time ago).

	Christoph

-- 
Always remember that you are unique.  Just like everyone else.
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
