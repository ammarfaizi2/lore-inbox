Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S136098AbRD0QJU>; Fri, 27 Apr 2001 12:09:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S136097AbRD0QJA>; Fri, 27 Apr 2001 12:09:00 -0400
Received: from roc-24-169-102-121.rochester.rr.com ([24.169.102.121]:53770
	"EHLO roc-24-169-102-121.rochester.rr.com") by vger.kernel.org
	with ESMTP id <S136094AbRD0QIy>; Fri, 27 Apr 2001 12:08:54 -0400
Date: Fri, 27 Apr 2001 12:08:10 -0400
From: Chris Mason <mason@suse.com>
To: Tony Hoyle <tmh@magenta-netlogic.com>,
        jason <jason@lacan.dabney.caltech.edu>
cc: linux-kernel@vger.kernel.org
Subject: Re: kernel panic with 2.4.x and reiserfs
Message-ID: <271930000.988387690@tiny>
In-Reply-To: <3AE9913B.6090208@magenta-netlogic.com>
X-Mailer: Mulberry/2.0.8 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Friday, April 27, 2001 04:33:15 PM +0100 Tony Hoyle
<tmh@magenta-netlogic.com> wrote:
 
> Reiserfs doesn't cope well with crashes....  Under 2.4 I wouldn't
> recommend using it on any kind of critical server - it seems to
> progressively corrupt itself (I'm looking at the second reformat and
> reinstall in a week, and I'm not a happy bunny).

Could you please forward along the details of these corruptions (including
hardware)?  

> 
> As the warning on reiserfsck says, the rebuild-tree option is a last
> resort.  It's as likely to make the problem worse then improve it (It
> rounds all the file lengths up to a block size, padding with zeros, which
> breaks lots of stuff).  Backup what you can first.

It shouldn't always do this, most of the time it has enough info to get the
size right.  Which reiserfsck did you use?

-chris

