Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129210AbQLEQDP>; Tue, 5 Dec 2000 11:03:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129226AbQLEQDF>; Tue, 5 Dec 2000 11:03:05 -0500
Received: from anchor-post-34.mail.demon.net ([194.217.242.92]:11020 "EHLO
	anchor-post-34.mail.demon.net") by vger.kernel.org with ESMTP
	id <S129210AbQLEQC6>; Tue, 5 Dec 2000 11:02:58 -0500
Date: Tue, 5 Dec 2000 15:28:36 +0000 (GMT)
From: Steve Hill <steve@navaho.co.uk>
To: PaulJakma <paulj@itg.ie>
cc: linux-kernel@vger.kernel.org
Subject: Re: Serial Console
In-Reply-To: <Pine.LNX.4.30.0012051506030.31704-100000@rossi.itg.ie>
Message-ID: <Pine.LNX.4.21.0012051528070.2875-100000@sorbus.navaho>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 5 Dec 2000, PaulJakma wrote:

> > ATM I've found a quick workaround - I
> > use "stty -F /dev/console clocal -crtscts" to turn off the serial flow
> > control at the stawrt of /etc/rc.d/rc.sysinit - this seems to work quite
> > well... of course it doesn't stop some program turning flow control back
> > on and ballsing it all up again :)
> 
> yukkk...
> 
> /dev/console having non-blocking semantics sounds much cleaner.

Yep - having a blocking console just seems like plain stupidity :(

-- 

- Steve Hill
System Administrator         Email: steve@navaho.co.uk
Navaho Technologies Ltd.       Tel: +44-870-7034015


-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
