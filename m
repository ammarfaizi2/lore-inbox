Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S291155AbSBHAat>; Thu, 7 Feb 2002 19:30:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S291226AbSBHAaj>; Thu, 7 Feb 2002 19:30:39 -0500
Received: from [63.231.122.81] ([63.231.122.81]:56621 "EHLO lynx.adilger.int")
	by vger.kernel.org with ESMTP id <S291224AbSBHAab>;
	Thu, 7 Feb 2002 19:30:31 -0500
Date: Thu, 7 Feb 2002 17:29:16 -0700
From: Andreas Dilger <adilger@turbolabs.com>
To: Stelian Pop <stelian.pop@fr.alcove.com>
Cc: Larry McVoy <lm@work.bitmover.com>,
        Linus Torvalds <torvalds@transmeta.com>,
        Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: linux-2.5.4-pre1 - bitkeeper testing
Message-ID: <20020207172916.D15496@lynx.turbolabs.com>
Mail-Followup-To: Stelian Pop <stelian.pop@fr.alcove.com>,
	Larry McVoy <lm@work.bitmover.com>,
	Linus Torvalds <torvalds@transmeta.com>,
	Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <20020207080714.GA10860@come.alcove-fr> <Pine.LNX.4.33.0202070833400.2269-100000@athlon.transmeta.com> <20020207092640.P27932@work.bitmover.com> <20020207194627.GA9057@come.alcove-fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20020207194627.GA9057@come.alcove-fr>; from stelian.pop@fr.alcove.com on Thu, Feb 07, 2002 at 08:46:27PM +0100
X-GPG-Key: 1024D/0D35BED6
X-GPG-Fingerprint: 7A37 5D79 BF1B CECA D44F  8A29 A488 39F5 0D35 BED6
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Feb 07, 2002  20:46 +0100, Stelian Pop wrote:
> On Thu, Feb 07, 2002 at 09:26:40AM -0800, Larry McVoy wrote:
> > Do a "bk help send", you probably
> > want "bk send -d -r+ torvalds@transmeta.com" to send the most recent cset.
> 
> I'd really like 'bk send' to drop me to a shell/mailer like and
> ask for confirmation before sending the mail (and eventually add
> for example the cc: line to l-k).

I'd agree.  I previously had a dialog with one of the BK developers
about making the email nicer (better subject, etc), but having it
dump the output to a file and fire up $EDITOR is probably a lot
better.  Maybe with a "bk send -e ..." or so.

> What I found easier to use is to 'bk send - > /tmp/foo' then send 
> foo using my regular mailer... But I lose the advantages of
> checking the last sended ChangeSet (in Bitkeeper/etc/send-a@b.com).

Yes, I ended up doing the same "bk send - > cset.X.bk" instead of
sending directly, because I wanted to add in a patch description or
other text to the beginning of the email.

Cheers, Andreas
--
Andreas Dilger
http://sourceforge.net/projects/ext2resize/
http://www-mddsp.enel.ucalgary.ca/People/adilger/

