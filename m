Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129105AbQJ3Wa0>; Mon, 30 Oct 2000 17:30:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129170AbQJ3WaQ>; Mon, 30 Oct 2000 17:30:16 -0500
Received: from www.inreko.ee ([195.222.18.2]:47026 "EHLO www.inreko.ee")
	by vger.kernel.org with ESMTP id <S129105AbQJ3WaH>;
	Mon, 30 Oct 2000 17:30:07 -0500
Date: Tue, 31 Oct 2000 00:38:01 +0200
From: Marko Kreen <marko@l-t.ee>
To: Mirko Klemm <Mirko.Klemm@t-online.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: request advice: how stable is devfs in 2.4.0-test9?
Message-ID: <20001031003801.A2172@l-t.ee>
In-Reply-To: <00103022454801.00908@trabant>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <00103022454801.00908@trabant>; from Mirko.Klemm@t-online.de on Mon, Oct 30, 2000 at 10:45:48PM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 30, 2000 at 10:45:48PM +0100, Mirko Klemm wrote:
> Could anyone please send me a comment on how actually usable the devfs 
> support in the 2.4.0 test series is at the moment?

Fine.  I was forced to use it from 2.3.99-something and
have not had any problems with it.  (I lifted whole system
from one disk to another and forgot to create /dev :)


> I am currently using 2.4.0-test* as an "ordinary user" and want to try some 
> of the 2.4 specific new features out, but this is my only system and I don't 
> want it to be messed up so much, so I'd like to hear some comments first.
> Which version of devfsd/utils is needed?

I have devfsd 1.3.10.

You better be sure you have following lines in devfsd.conf:

REGISTER        .*              MKOLDCOMPAT
UNREGISTER      .*              RMOLDCOMPAT

You can later reconfigure most stuff to use new layout
but especially X is a pain.

-- 
marko

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
