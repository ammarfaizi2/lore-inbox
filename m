Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130810AbQKANjs>; Wed, 1 Nov 2000 08:39:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130762AbQKANji>; Wed, 1 Nov 2000 08:39:38 -0500
Received: from enterprise.cistron.net ([195.64.68.33]:54800 "EHLO
	enterprise.cistron.net") by vger.kernel.org with ESMTP
	id <S130810AbQKANj2>; Wed, 1 Nov 2000 08:39:28 -0500
From: miquels@cistron.nl (Miquel van Smoorenburg)
Subject: Re: Looking for better 2.2-based VM (do_try_to_free_pages fails, machine hangs)
Date: 1 Nov 2000 13:39:36 GMT
Organization: Cistron Internet Services B.V.
Message-ID: <8tp6eo$9l1$1@enterprise.cistron.net>
In-Reply-To: <20001101133307.A10265@bylbo.nowhere.earth>
X-Trace: enterprise.cistron.net 973085976 9889 195.64.65.201 (1 Nov 2000 13:39:36 GMT)
X-Complaints-To: abuse@cistron.nl
To: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In article <20001101133307.A10265@bylbo.nowhere.earth>,
Yann Dirson  <ydirson@altern.org> wrote:
>Using a 2.2.17 kernel I often experience problems where I get messages like
>"VM: do_try_to_free_pages failed for <some process>", and the machine hangs
>until the VM can recover, which sometimes takes too long for me to wait.  I
>suppose that the problem is similar sometimes when I get a frozen system
>under X, but can't see the kernel messages then.

I'm seeing the same on some machines. Running several instances of
bonnie on a dual SMP Intel with a DAC 1164 raid controller would
kill the machine in a few hours. However it has been running several
bonnies now without a hitch for 2 days, on 2.2.18pre18

Mike.
-- 
People get the operating system they deserve.
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
