Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129713AbRBBXy1>; Fri, 2 Feb 2001 18:54:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130112AbRBBXyR>; Fri, 2 Feb 2001 18:54:17 -0500
Received: from pizda.ninka.net ([216.101.162.242]:41096 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S129713AbRBBXx5>;
	Fri, 2 Feb 2001 18:53:57 -0500
From: "David S. Miller" <davem@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <14971.18508.936198.264306@pizda.ninka.net>
Date: Fri, 2 Feb 2001 15:52:44 -0800 (PST)
To: "Michael H. Warfield" <mhw@wittsend.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Ok, someone is trying to be funny
In-Reply-To: <20010202185146.A6960@alcove.wittsend.com>
In-Reply-To: <14971.17550.868312.308804@pizda.ninka.net>
	<20010202185146.A6960@alcove.wittsend.com>
X-Mailer: VM 6.75 under 21.1 (patch 13) "Crater Lake" XEmacs Lucid
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Michael H. Warfield writes:
 > On Fri, Feb 02, 2001 at 03:36:46PM -0800, David S. Miller wrote:
 > 	So block them using the /etc/mail/access database for sendmail
 > and do it with a "451" error code.  The data will back up on their
 > mail server and start clogging their mail spool till they get a clue.
 > (Ok...  5 day expiration on the messages, but ITMT, they get several
 > warning and error messages from each too).

We don't use sendmail at vger, we use zmailer.  Sendmail could
not keep up with the load :-)

And yes I've done the zmailer equivalent (manual SPAM block database)
of what you've suggested.

Later,
David S. Miller
davem@redhat.com
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
