Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129853AbQLEWYI>; Tue, 5 Dec 2000 17:24:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129849AbQLEWX7>; Tue, 5 Dec 2000 17:23:59 -0500
Received: from altrade.nijmegen.inter.nl.net ([193.67.237.6]:45259 "EHLO
	altrade.nijmegen.inter.nl.net") by vger.kernel.org with ESMTP
	id <S129525AbQLEWXo>; Tue, 5 Dec 2000 17:23:44 -0500
Date: Tue, 5 Dec 2000 22:23:39 +0100
From: Frank van Maarseveen <F.vanMaarseveen@inter.NL.net>
To: Andrew Morton <andrewm@uow.edu.au>
Cc: tytso@mit.edu, linux-kernel@vger.kernel.org
Subject: Re: 2.4.0-test11: kernel: waitpid(823) failed, -512
Message-ID: <20001205222339.A20421@iapetus.localdomain>
In-Reply-To: <20001203233611.A8410@iapetus.localdomain>; <200012050133.eB51XdJ14685@snap.thunk.org> <3A2C4917.1AEEE91D@uow.edu.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 1.0i
In-Reply-To: <3A2C4917.1AEEE91D@uow.edu.au>; from andrewm@uow.edu.au on Tue, Dec 05, 2000 at 12:47:03PM +1100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 05, 2000 at 12:47:03PM +1100, Andrew Morton wrote:
> 
> Ted,
> 
> it's caused by exec_usermodehelper().

Patch seems to work. Tested on 2.4.0-test11 which revealed the problem

-- 
Frank
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
