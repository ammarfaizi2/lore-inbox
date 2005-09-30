Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932573AbVI3Htw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932573AbVI3Htw (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 30 Sep 2005 03:49:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932572AbVI3Htw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 30 Sep 2005 03:49:52 -0400
Received: from astound-64-85-224-245.ca.astound.net ([64.85.224.245]:3343 "EHLO
	master.linux-ide.org") by vger.kernel.org with ESMTP
	id S932267AbVI3Htv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 30 Sep 2005 03:49:51 -0400
Date: Fri, 30 Sep 2005 00:36:34 -0700 (PDT)
From: Andre Hedrick <andre@linux-ide.org>
To: "David S. Miller" <davem@davemloft.net>
cc: jgarzik@pobox.com, willy@w.ods.org, luben_tuikov@adaptec.com,
       patmans@us.ibm.com, ltuikov@yahoo.com, linux-kernel@vger.kernel.org,
       akpm@osdl.org, torvalds@osdl.org, linux-scsi@vger.kernel.org
Subject: Re: I request inclusion of SAS Transport Layer and AIC-94xx into
 the kernel
In-Reply-To: <20050929.002423.18974352.davem@davemloft.net>
Message-ID: <Pine.LNX.4.10.10509300015100.27623-100000@master.linux-ide.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Thu, 29 Sep 2005, David S. Miller wrote:

Dave,

Thanks for filling in the details I was missing about the TOE history.

Glad to see you laugh about the ski stuff.  I thought about snowboarding
then realized I would make a great mogal for someone to do an ali off.  If
you are open to questions about TOE/RDMA stuff, would like to chat with
you and see your POV on the subject.

> In that case, it is indeed a vendor trying to shove their particular
> solution down our throats.  They never even attempt to try out the
> alternatives, and we've even gone through the trouble of coming up
> with several.  And they do this because their whole buisness model is
> all about their scheme to the exclusion of anything else, not because
> what they have is better.

Luben,

Reading Dave's points above tends to point to adaptec's current direction,
as we all know. TOEs were rejected.

I stated I would help with SAS adoption because there is a SAS-Transport
model.  I asked about a possible libadaptec + libsas, and still waiting to
see if you and adaptec are up for the task.  Right now the only path open
is the one Jeff Garzik is putting forward along with James and Christop.
I have a vested interest in seeing SAS-Transport, otherwise I would have
cut and run a long time ago.

These long email threads where everyone is shout from the top of their
hill never wins anything.  After a while the hill becomes flat (from all
the stomping), and you become old and tired.

LSI pointed out they mask there SAS in firmware and make it show up in a
scsi-like or scsi state.  They also pointed out other vendors have taken
this road.  Even if Adaptec did not go this way in hardware, there still
has to be a way to map into SCSI ... sheesh this is Adaptec known for
SCSI.

Just an FYI, would suggest you cool your heels and listen for the quiet
responses.  There is more heat than light right now; maybe this thread
will offset some of the cost in the energy criss.  Will pass on advice
handed to me (when I was a maintainer) relax and listen, nobody is out to
get you (and they were right).

Cheers,

Andre

PS I didn't listen to that advice back then, don't make the same mistake.


