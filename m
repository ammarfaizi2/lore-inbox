Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312357AbSDJBdg>; Tue, 9 Apr 2002 21:33:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S312358AbSDJBdf>; Tue, 9 Apr 2002 21:33:35 -0400
Received: from barbados.bluemug.com ([63.195.182.101]:34832 "EHLO
	barbados.bluemug.com") by vger.kernel.org with ESMTP
	id <S312357AbSDJBdf>; Tue, 9 Apr 2002 21:33:35 -0400
Date: Tue, 9 Apr 2002 18:20:21 -0700
To: Bill Davidsen <davidsen@tmr.com>
Cc: joeja@mindspring.com, linux-kernel@vger.kernel.org
Subject: Re: faster boots?
Message-ID: <20020410012021.GA8963@bluemug.com>
Mail-Followup-To: Bill Davidsen <davidsen@tmr.com>, joeja@mindspring.com,
	linux-kernel@vger.kernel.org
In-Reply-To: <Springmail.0994.1017964447.0.72656900@webmail.atl.earthlink.net> <Pine.LNX.3.96.1020405074539.7802A-100000@gatekeeper.tmr.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-PGP-ID: 5C09BB33
X-PGP-Fingerprint: C518 67A5 F5C5 C784 A196  B480 5C97 3BBD 5C09 BB33
From: Mike Touloumtzis <miket@bluemug.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 05, 2002 at 07:56:08AM -0500, Bill Davidsen wrote:
> 
> That really should take little time... slow boots are caused by two
> things, a generic kernel which has everything possible included, and a
> slow init script which not only does many things, but does them serially
> and accompanied by many messages. Watching Redhat tap dancing and farting
> through line after line of stuff is painful, and with a serial console on
> a server, hooked to a 9600bps modem, you can not only get a cup of coffe,
> but brew it and drink it as well.

The worst part is when you forget to remove "-C" from the init script
fsck on a machine with a 9600bps serial console.  After a power hit
one machine in our machine closet took 2 hours to come back; finally
figured out it spent most of that time waiting to write progress bars
and twirling batons to /dev/ttyS0.

miket
