Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129552AbRCANGV>; Thu, 1 Mar 2001 08:06:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129576AbRCANGM>; Thu, 1 Mar 2001 08:06:12 -0500
Received: from zeus.kernel.org ([209.10.41.242]:13029 "EHLO zeus.kernel.org")
	by vger.kernel.org with ESMTP id <S129552AbRCANFz>;
	Thu, 1 Mar 2001 08:05:55 -0500
Date: Thu, 1 Mar 2001 13:04:13 +0000
From: "Stephen C. Tweedie" <sct@redhat.com>
To: Neal Gieselman <Neal.Gieselman@Visionics.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: ext3 fsck question
Message-ID: <20010301130413.B7647@redhat.com>
In-Reply-To: <D0FA767FA2D5D31194990090279877DA57328F@dbimail.digitalbiometrics.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <D0FA767FA2D5D31194990090279877DA57328F@dbimail.digitalbiometrics.com>; from Neal.Gieselman@Visionics.com on Wed, Feb 28, 2001 at 08:03:21PM -0600
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Wed, Feb 28, 2001 at 08:03:21PM -0600, Neal Gieselman wrote:
> 
> I applied the libs and other utilites from e2fsprogs by hand.
> I ran fsck.ext3 on my secondary partition and it ran fine.  The boot fsck
> on / was complaining about something but I could not catch it.
> I then went single user and ran fsck.ext3 on / while mounted.

e2fsck should complain loudly and ask for confirmation if you do that.
Goin ahead with the fsck is a bad move on a mounted, rw filesystem!

> Excuse the stupid question, but with ext3, do I really require the
> fsck.ext3?  

fsck.ext3 is just a link to e2fsck.  Make sure you're running recent
e2fsprogs, though (either the latest snapshot from
downloads.sourceforge.net or a build from
ftp.uk.linux.org:/pub/linux/sct/fs/jfs/).

Cheers,
 Stephen
