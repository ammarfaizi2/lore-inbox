Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id <S129730AbQKZF3f>; Sun, 26 Nov 2000 00:29:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
        id <S130194AbQKZF3Z>; Sun, 26 Nov 2000 00:29:25 -0500
Received: from otter.mbay.net ([206.40.79.2]:49675 "EHLO otter.mbay.net")
        by vger.kernel.org with ESMTP id <S129730AbQKZF3J> convert rfc822-to-8bit;
        Sun, 26 Nov 2000 00:29:09 -0500
From: jalvo@mbay.net (John Alvord)
To: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] removal of "static foo = 0"
Date: Sun, 26 Nov 2000 05:01:03 GMT
Message-ID: <3a219890.57346310@mail.mbay.net>
In-Reply-To: <E13ztNR-0001ew-00@the-village.bc.nu>
In-Reply-To: <E13ztNR-0001ew-00@the-village.bc.nu>
X-Mailer: Forte Agent 1.5/32.451
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 26 Nov 2000 04:25:05 +0000 (GMT), Alan Cox
<alan@lxorguk.ukuu.org.uk> wrote:

>>  AB> of changes that yield a negligable advantage and reduce stability
>>  AB> a tiny little bit. That is pushing Linux in the direction of this
>>  AB> abyss. You notice that the view gets better, and I get nervous.
>> 
>> Can somebody stop this train load of bunk?
>> 
>> Uninitialized global variables always have a initial value of
>> zero.  Static or otherwise.  Period.
>
>That isnt what Andries is arguing about. Read harder. Its semantic differences
>rather than code differences.
>
>	static int a=0;
>
>says 'I thought about this. I want it to start at zero. I've written it this
>way to remind of the fact'
>
>Sure it generates the same code

It also says "I do not know much about the details of the kernel C
environment. In particular I do not know that all static variables are
initialized to 0 in the kernel startup. I have not read setup.S."

john alvord
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
