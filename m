Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263491AbTJ0UgA (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 27 Oct 2003 15:36:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263494AbTJ0UgA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 27 Oct 2003 15:36:00 -0500
Received: from bristol.phunnypharm.org ([65.207.35.130]:6279 "EHLO
	bristol.phunnypharm.org") by vger.kernel.org with ESMTP
	id S263491AbTJ0Uf6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 27 Oct 2003 15:35:58 -0500
Date: Mon, 27 Oct 2003 15:21:31 -0500
From: Ben Collins <bcollins@debian.org>
To: Mike Fedyk <mfedyk@matchmail.com>
Cc: Bradley Chapman <kakadu_croc@yahoo.com>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org, linux1394-devel@lists.sourceforge.net
Subject: Re: This bug appears under 2.6.0-test8 as well (was: 2.6.0-test7-mm1)
Message-ID: <20031027202131.GW7904@phunnypharm.org>
References: <20031018132741.GV866@phunnypharm.org> <20031018180741.69117.qmail@web40912.mail.yahoo.com> <20031018194617.GZ866@phunnypharm.org> <20031027201348.GH4511@matchmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20031027201348.GH4511@matchmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 27, 2003 at 12:13:48PM -0800, Mike Fedyk wrote:
> On Sat, Oct 18, 2003 at 03:46:17PM -0400, Ben Collins wrote:
> > As would be expected considering I'm holding off changes to let 2.6
> > focus on core issues. The "bug" is pretty much harmless as-is, even if
> > noisy, and wont show up under normal compiles with debugging disables.
> > 
> > Plus, my fix is a little more than trivial, so I'm keeping it for 2.6.1.
> 
> Oh great, let's wait for the "little more than trivial" bug fixes until
> after it's released....
> 
> I understand that you're busy, and your schedule may force you to wait until
> after 2.6.0, but 2.6-test is to help get the bugs out of a release, and this
> is a bug fix so it should be accepted...


Obviously you haven't been reading Linus' posts about what he'll accept
into 2.6.0-test before 2.6.0 is final. He wont take my patches, and
rightfully so.

This isn't a matter of my choice, it's a matter of timing. Get over it,
and download the latest stuff from linux1394.org if you need it that
badly. Here's a hint:

# cd /usr/src/linux-2.6.0-test9
# rm -rf drivers/ieee1394
# wget -o trunk.tar.gz http://www.linux1394.org/viewcvs/trunk/trunk.tar.gz?tarball=1
# tar zxf trunk.tar.gz 
# mv trunk drivers/ieee1394
# rm -f trunk.tar.gz

It doesn't get any simpler than that.

-- 
Debian     - http://www.debian.org/
Linux 1394 - http://www.linux1394.org/
Subversion - http://subversion.tigris.org/
WatchGuard - http://www.watchguard.com/
