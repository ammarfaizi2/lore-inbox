Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266508AbRGDGNn>; Wed, 4 Jul 2001 02:13:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266510AbRGDGNd>; Wed, 4 Jul 2001 02:13:33 -0400
Received: from mail.bmlv.gv.at ([193.171.152.34]:38064 "EHLO mail.bmlv.gv.at")
	by vger.kernel.org with ESMTP id <S266508AbRGDGNW>;
	Wed, 4 Jul 2001 02:13:22 -0400
Message-Id: <3.0.6.32.20010704081621.00921a60@pop3.bmlv.gv.at>
X-Mailer: QUALCOMM Windows Eudora Light Version 3.0.6 (32)
Date: Wed, 04 Jul 2001 08:16:21 +0200
To: Rik van Riel <riel@conectiva.com.br>
From: "Ph. Marek" <marek@bmlv.gv.at>
Subject: Re: Ideas for TUX2
Cc: <linux-kernel@vger.kernel.org>, <phillips@bonn-fries.net>
In-Reply-To: <Pine.LNX.4.33L.0107032042220.28737-100000@imladris.rielhom
 e.conectiva>
In-Reply-To: <3.0.6.32.20010703082513.0091f900@pop3.bmlv.gv.at>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>> If a file's data has been changed, it suffices to update the inode and the
>> of free blocks bitmap (fbb).
>> But updating them in one go is not possible
>
>You seem to have missed some fundamental understanding of
>exactly how phase tree works; the wohle point of phase
>tree is to make atomic updates like this possible!
Well, my point was, that with several thousand inodes spread over the disk
it won't always be possible to update the inode AND the fbb in one go.
So I proposed the 2nd inode with generation counter!


Regards,

Phil
