Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129810AbRBBXwr>; Fri, 2 Feb 2001 18:52:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130112AbRBBXwh>; Fri, 2 Feb 2001 18:52:37 -0500
Received: from alcove.wittsend.com ([130.205.0.20]:20233 "EHLO
	alcove.wittsend.com") by vger.kernel.org with ESMTP
	id <S129810AbRBBXwW>; Fri, 2 Feb 2001 18:52:22 -0500
Date: Fri, 2 Feb 2001 18:51:46 -0500
From: "Michael H. Warfield" <mhw@wittsend.com>
To: "David S. Miller" <davem@redhat.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Ok, someone is trying to be funny
Message-ID: <20010202185146.A6960@alcove.wittsend.com>
Mail-Followup-To: "David S. Miller" <davem@redhat.com>,
	linux-kernel@vger.kernel.org
In-Reply-To: <14971.17550.868312.308804@pizda.ninka.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.2i
In-Reply-To: <14971.17550.868312.308804@pizda.ninka.net>; from davem@redhat.com on Fri, Feb 02, 2001 at 03:36:46PM -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 02, 2001 at 03:36:46PM -0800, David S. Miller wrote:

> Ok, it seems somebody is running a cron script or similar
> to keep resubscribing that meltingpot@miralink.com address
> to linux-kernel.

	So block them using the /etc/mail/access database for sendmail
and do it with a "451" error code.  The data will back up on their
mail server and start clogging their mail spool till they get a clue.
(Ok...  5 day expiration on the messages, but ITMT, they get several
warning and error messages from each too).

> So if you see the "moderation" message back from a posting
> you make to linux-kernel, please dont' report it to us here
> at vger.kernel.org, we know about it.

> Later,
> David S. Miller
> davem@redhat.com

	Mike
-- 
 Michael H. Warfield    |  (770) 985-6132   |  mhw@WittsEnd.com
  (The Mad Wizard)      |  (678) 463-0932   |  http://www.wittsend.com/mhw/
  NIC whois:  MHW9      |  An optimist believes we live in the best of all
 PGP Key: 0xDF1DD471    |  possible worlds.  A pessimist is sure of it!

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
