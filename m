Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131165AbRAWNaw>; Tue, 23 Jan 2001 08:30:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131212AbRAWNam>; Tue, 23 Jan 2001 08:30:42 -0500
Received: from 213-123-74-209.btconnect.com ([213.123.74.209]:56836 "EHLO
	penguin.homenet") by vger.kernel.org with ESMTP id <S131165AbRAWNa1>;
	Tue, 23 Jan 2001 08:30:27 -0500
Date: Tue, 23 Jan 2001 13:33:09 +0000 (GMT)
From: Tigran Aivazian <tigran@veritas.com>
To: linux-kernel@vger.kernel.org
Subject: Re: 2.4.1-pre8/10 klogd taking 100% of CPU time -- bug?
In-Reply-To: <Pine.LNX.4.21.0101231032080.1386-100000@penguin.homenet>
Message-ID: <Pine.LNX.4.21.0101231331460.916-100000@penguin.homenet>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 23 Jan 2001, Tigran Aivazian wrote:
> So, since kdb was unable to tell me what's going on (and truss also can't
> attach to it) one will have to debug it the old-fashioned way -- manually,
> i.e. by trussing klogd from the beginning and reading it's sources...

actually, all this means is that the task is busy looping in userspace (in
retrospective, it is easy to "guess").

Regards,
Tigran

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
