Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1754424AbWKZXPB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754424AbWKZXPB (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 26 Nov 2006 18:15:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754451AbWKZXPB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 26 Nov 2006 18:15:01 -0500
Received: from main.gmane.org ([80.91.229.2]:33444 "EHLO ciao.gmane.org")
	by vger.kernel.org with ESMTP id S1754366AbWKZXPA (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 26 Nov 2006 18:15:00 -0500
X-Injected-Via-Gmane: http://gmane.org/
To: linux-kernel@vger.kernel.org
From: Jon Escombe <lists@dresco.co.uk>
Subject: Re: is there any Hard-disk shock-protection for 2.6.18 and above?
Date: Sun, 26 Nov 2006 23:14:51 +0000 (UTC)
Message-ID: <loom.20061127T000355-778@post.gmane.org>
References: <455DAF74.1050203@schlagmichtod.de> <20061121205124.GB4199@ucw.cz> <20061124072109.GY4999@kernel.dk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: main.gmane.org
User-Agent: Loom/3.14 (http://gmane.org/)
X-Loom-IP: 82.68.23.174 (Mozilla/5.0 (X11; U; Linux i686; en-GB; rv:1.8.0.8) Gecko/20061108 Fedora/1.5.0.8-1.fc5 Firefox/1.5.0.8)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jens Axboe <jens.axboe <at> oracle.com> writes:

> 
> On Tue, Nov 21 2006, Pavel Machek wrote:
> > Hi!
> > 
> > > Well, the actual question is the following,
> > > I read about HDAPS on thinkWiki. But there is no known-to-work patch for
> > > 2.6.18 and above to enable queue-freezing/harddisk parking.
> > > After some googeling and digging in gamne i read that someone said that
> > > there are plans for some generic support for HD-parking in the kernel
> > > and thus making such patches obsolete.
> > > My quesiotn just is if this is true and if there are any chances that
> > > the kernel will support that soonly.
> > ...
> > > So i hope this issue can be adressed soon. but i also know that most of
> > > you are very busy and i can not evaluate how difficult such a change
> > > would be. However if anyone wants to test some things or more
> > > information, i am ready. Just CC me :)
> > 
> > I'm afraid we need your help with development here. Porting old patch
> > to 2.6.19-rc6 should be easy, and then you can start 'how do I
> > makethis generic' debate.
> 
> 2.6.19 will finally have the generic block layer commands, so this can
> be implemented properly.
> 

That's good to know. Sounds like we'll be able to have another attempt at
getting this functionality upstream..

In the meantime, the current code has been cleaned up and updated to work with
2.6.18. Patches are on the hdaps-devel list.

http://sourceforge.net/mailarchive/forum.php?forum=hdaps-devel (or gmane for an
easier view ;)

Regards,
Jon.


