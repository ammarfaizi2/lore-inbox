Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130747AbRAINJA>; Tue, 9 Jan 2001 08:09:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130748AbRAINIu>; Tue, 9 Jan 2001 08:08:50 -0500
Received: from [62.254.209.2] ([62.254.209.2]:27643 "EHLO cam-gw.zeus.co.uk")
	by vger.kernel.org with ESMTP id <S130747AbRAINIg>;
	Tue, 9 Jan 2001 08:08:36 -0500
Date: Tue, 9 Jan 2001 13:08:26 +0000 (GMT)
From: Stephen Landamore <stephenl@zeus.com>
To: linux-kernel@vger.kernel.org
cc: mingo@elte.hu
Subject: Re: [PLEASE-TESTME] Zerocopy networking patch, 2.4.0-1
Message-ID: <Pine.LNX.4.10.10101091301170.18208-100000@phaedra.cam.zeus.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Scanner: exiscan *14FyVt-00026y-00*WHcqF3YIl3s* http://duncanthrax.net/exiscan/
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ingo Molnar wrote:
> On Tue, 9 Jan 2001, Christoph Hellwig wrote:
>
>> Sure.  But sendfile is not one of the fundamental UNIX operations...
>
> Neither were eg. kernel-based semaphores. So what? Unix wasnt
> perfect and isnt perfect - but it was a (very) good starting
> point. If you are arguing against the existence or importance of
> sendfile() you should re-think, sendfile() is a unique (and
> important) interface because it enables moving information between
> files (streams) without involving any interim user-space memory
> buffer. No original Unix API did this AFAIK, so we obviously had to
> add it. It's an important Linux API category.

Ehh, that's not correct. HP-UX was the first to implement sendfile().
Linux (and other commercial unices) then copied the idea...

For the record, sendfile() exists because we (Zeus) asked HP for
it. (So of course we agree that sendfile is important!)

Regards,
Stephen

--
Stephen Landamore, <slandamore@zeus.com>              Zeus Technology
Tel: +44 1223 525000                      Universally Serving the Net
Fax: +44 1223 525100                              http://www.zeus.com
Zeus Technology, Zeus House, Cowley Road, Cambridge, CB4 0ZT, ENGLAND

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
