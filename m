Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129235AbRA2Us4>; Mon, 29 Jan 2001 15:48:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129274AbRA2Usr>; Mon, 29 Jan 2001 15:48:47 -0500
Received: from [212.26.214.179] ([212.26.214.179]:16138 "EHLO zweden.rul.nl")
	by vger.kernel.org with ESMTP id <S129235AbRA2Usg>;
	Mon, 29 Jan 2001 15:48:36 -0500
Date: Mon, 29 Jan 2001 21:48:30 +0100 (MET)
From: Robert-Jan Oosterloo <oosterlo@worldonline.nl>
Reply-To: Robert-Jan Oosterloo <oosterlo@worldonline.nl>
To: linux-kernel@vger.kernel.org
Subject: ide-tape problems with 2.4.0
Message-ID: <Pine.LNX.3.96.1010129214412.3024B-100000@zweden.rul.nl>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I have a HP Colorado 4/8GB Travan tape streamer. Under 2.2.18 it works
perfect. But under 2.4.0 it doesn't seem to want to read from the tape
anymore.

When I do a tar tvf /dev/tape, I get an I/O error and in syslog messages
like:

Jan 29 17:10:23 ijsland kernel: ide-tape: ht0: I/O error, pc =  8, key =
5, asc = 2c, ascq =  0.

But writing to the tape works fine.

Is this a known problem?

Thanks!

Robert-Jan

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
