Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318714AbSHQTyb>; Sat, 17 Aug 2002 15:54:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318717AbSHQTya>; Sat, 17 Aug 2002 15:54:30 -0400
Received: from pc2-cwma1-5-cust12.swa.cable.ntl.com ([80.5.121.12]:27634 "EHLO
	irongate.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S318714AbSHQTya>; Sat, 17 Aug 2002 15:54:30 -0400
Subject: Re: IDE?
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: Anton Altaparmakov <aia21@cantab.net>, alan@lxorguk.ukuu.org,
       Andre Hedrick <andre@linux-ide.org>, axboe@suse.de, vojtech@suse.cz,
       bkz@linux-ide.org, linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.44.0208161706390.1674-100000@home.transmeta.com>
References: <Pine.LNX.4.44.0208161706390.1674-100000@home.transmeta.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.3 (1.0.3-6) 
Date: 17 Aug 2002 20:56:39 +0100
Message-Id: <1029614199.4634.32.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2002-08-17 at 01:10, Linus Torvalds wrote:
> I'd like Vojtech to be a bit involved too, he seemed to do some
> much-needed cleanups for PIIX4 IDE (now gone, since we couldn't save just
> those parts..)

If he does please co-ordinate with me. I've already done a chunk of
cleanup there (and Andre has done a load too). 

I want order to this. That means all the driver cleanup goes into 2.4-ac
(or "2.4-ide" or some suitable branch) first where we can verify we
aren't hitting 2.5 generic bugs and ide corruption is a meaningful
problem report. It means someone (not me) is the appointed 2.5 person
and handles stuff going to 2.5 (I'm happy to identify stuff that tests
ok in 2.4 as candidates). It also means random patches not going past
me.

If we can do it that way I'll do the job. If Linus applies random IDE
"cleanup" patches to his 2.5 tree that don't pass through Jens and me
then I'll just stop listening to 2.5 stuff.

Volunteers willing to run Cerberus test sets on 2.4 boxes with IDE
controllers would also be much appreciated. That way we can get good
coverage tests and catch badness immediately

Alan

