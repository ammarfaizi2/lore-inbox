Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130218AbQLITOV>; Sat, 9 Dec 2000 14:14:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131182AbQLITOL>; Sat, 9 Dec 2000 14:14:11 -0500
Received: from Cantor.suse.de ([194.112.123.193]:33810 "HELO Cantor.suse.de")
	by vger.kernel.org with SMTP id <S130218AbQLITOF>;
	Sat, 9 Dec 2000 14:14:05 -0500
To: Linus Torvalds <torvalds@transmeta.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Re: kernel BUG at buffer.c:827 in test12-pre6 and 7
In-Reply-To: <Pine.LNX.4.10.10012090924390.1574-100000@penguin.transmeta.com>
From: Andi Kleen <ak@suse.de>
Date: 09 Dec 2000 19:43:37 +0100
In-Reply-To: Linus Torvalds's message of "9 Dec 2000 18:29:57 +0100"
Message-ID: <oupofyl8mg6.fsf@pigdrop.muc.suse.de>
User-Agent: Gnus/5.0803 (Gnus v5.8.3) Emacs/20.7
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus Torvalds <torvalds@transmeta.com> writes:


> > 	Modulo the comments above - fine with me. However, there is stuff in
> > drivers/md that I don't understand. Ingo, could you comment on the use of
> > ->b_end_io there?
> 
> I already sent him mail about it for the same reason. 

How about sending mail to all the journaling FS groups too? -- the change is surely
to break all the JFS which use usually b_end_io to submit the data after the journal
has been flushed.


-Andi
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
