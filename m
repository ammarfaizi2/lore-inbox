Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130208AbRAPEUb>; Mon, 15 Jan 2001 23:20:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130754AbRAPEUL>; Mon, 15 Jan 2001 23:20:11 -0500
Received: from d147.as5200.mesatop.com ([208.164.122.147]:62087 "HELO
	localhost.localdomain") by vger.kernel.org with SMTP
	id <S130208AbRAPEUC>; Mon, 15 Jan 2001 23:20:02 -0500
From: Steven Cole <elenstev@mesatop.com>
Reply-To: elenstev@mesatop.com
Date: Mon, 15 Jan 2001 21:22:11 -0700
X-Mailer: KMail [version 1.1.99]
Content-Type: text/plain; charset=US-ASCII
To: linux-kernel@vger.kernel.org
In-Reply-To: <01011520000900.01250@localhost.localdomain>
In-Reply-To: <01011520000900.01250@localhost.localdomain>
Subject: Re: 2.4.1-pre7 build error.
Cc: torvalds@transmeta.com, mason@suse.com
MIME-Version: 1.0
Message-Id: <01011521221100.01130@localhost.localdomain>
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 15 January 2001 20:00, Steven Cole wrote:
> Got this for 2.4.1-pre7
>
> make[2]: *** No rule to make target `/usr/src/linux/incl', needed by
> `softirq.o'.  Stop.
> make[2]: *** Waiting for unfinished jobs....
> make[2]: Leaving directory `/usr/src/linux-2.4.1-pre7/kernel'
> make[1]: *** [first_rule] Error 2

I have successfully built 2.4.1-pre7 and am now running same.
I just finished rebuilding 2.4.1-pre7 using 2.4.1-pre7, so everything
is looking fine now.

I was incautiously running 2.4.1-pre5 with the newly integrated
ReiserFS even though I knew that potential problems were being
worked out.

BTW, it looks like I get the same messages when shutting down 2.4.1-pre7 
associated with having ReiserFS as the root filesystem.  This was fixed with 
2.4.0-ac1. The patch to fix this was posted to the reiserfs-list. 

Steven
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
