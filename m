Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267157AbTAUSdj>; Tue, 21 Jan 2003 13:33:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267158AbTAUSdj>; Tue, 21 Jan 2003 13:33:39 -0500
Received: from inet-mail3.oracle.com ([148.87.2.203]:14503 "EHLO
	inet-mail3.oracle.com") by vger.kernel.org with ESMTP
	id <S267157AbTAUSdf>; Tue, 21 Jan 2003 13:33:35 -0500
Date: Tue, 21 Jan 2003 10:42:29 -0800
From: Joel Becker <Joel.Becker@oracle.com>
To: Dave Jones <davej@codemonkey.org.uk>, lkml <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@digeo.com>, Linus Torvalds <torvalds@transmeta.com>,
       Wim Coekaerts <Wim.Coekaerts@oracle.com>
Subject: Re: [PATCH][2.5] hangcheck-timer
Message-ID: <20030121184228.GX20972@ca-server1.us.oracle.com>
References: <20030121011954.GO20972@ca-server1.us.oracle.com> <20030121125039.GA5997@codemonkey.org.uk> <20030121174001.GV20972@ca-server1.us.oracle.com> <20030121174237.GB13480@codemonkey.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030121174237.GB13480@codemonkey.org.uk>
User-Agent: Mutt/1.4i
X-Burt-Line: Trees are cool.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 21, 2003 at 05:42:37PM +0000, Dave Jones wrote:
> Ok, seems to make sense now, thanks.
> Wouldn't this belong under drivers/char/watchdog too though ?
> It seems very 'watchdog-ish' to me.

	I thought about that a bit.  Since there is no /dev/watchdog and
no userspace communication channel, it seemed bad to put it there.
Heck, with no device, it doesn't necessarily fit in drivers/char in the
first place.
	If a few folks think drivers/char/watchdog is better, I've no
problem with it.  If anyone has a better idea...

Joel

-- 

Life's Little Instruction Book #511

	"Call your mother."

Joel Becker
Senior Member of Technical Staff
Oracle Corporation
E-mail: joel.becker@oracle.com
Phone: (650) 506-8127
