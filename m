Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131857AbQKJV2G>; Fri, 10 Nov 2000 16:28:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131842AbQKJV1r>; Fri, 10 Nov 2000 16:27:47 -0500
Received: from TELOS.ODYSSEY.CS.CMU.EDU ([128.2.185.175]:38923 "EHLO
	telos.odyssey.cs.cmu.edu") by vger.kernel.org with ESMTP
	id <S131733AbQKJV1h>; Fri, 10 Nov 2000 16:27:37 -0500
Date: Fri, 10 Nov 2000 16:27:23 -0500
From: Jan Harkes <jaharkes@cs.cmu.edu>
To: Pavel Machek <pavel@suse.cz>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [BUG] coda went from c 67 5 to c 67 0 [was Re: mount -tcoda /dev/cfs0 /mnt no longer works in -test9 and newer?]
Message-ID: <20001110162723.A30639@cs.cmu.edu>
Mail-Followup-To: Pavel Machek <pavel@suse.cz>,
	linux-kernel@vger.kernel.org
In-Reply-To: <20001106103539.A343@bug.ucw.cz> <20001107134841.A31058@cs.cmu.edu> <20001110213911.A300@bug.ucw.cz> <20001110224808.A443@bug.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 1.0.1i
In-Reply-To: <20001110224808.A443@bug.ucw.cz>; from pavel@suse.cz on Fri, Nov 10, 2000 at 10:48:08PM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 10, 2000 at 10:48:08PM +0100, Pavel Machek wrote:
> Hi!
> 
> I found where problem with coda lies: it went from character device at
> 67:5 to character device at 67:0. Ouch, ugly. Is it bug or what?
> 								Pavel

No, it always has been c67,0. It simply ignored the minor number up
until recently.

Jan

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
