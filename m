Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265812AbTL3Pw5 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 30 Dec 2003 10:52:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265815AbTL3Pw5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 30 Dec 2003 10:52:57 -0500
Received: from smtp1.libero.it ([193.70.192.51]:39904 "EHLO smtp1.libero.it")
	by vger.kernel.org with ESMTP id S265812AbTL3Pw4 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 30 Dec 2003 10:52:56 -0500
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16369.40927.110483.701341@gargle.gargle.HOWL>
Date: Tue, 30 Dec 2003 16:55:11 +0100
To: Duncan Sands <baldrick@free.fr>
Cc: linux-kernel@vger.kernel.org
Subject: Re: speedtouch for 2.6.0
In-Reply-To: <200312300911.02044.baldrick@free.fr>
References: <16366.61517.501828.389749@gargle.gargle.HOWL>
	<200312291804.40544.baldrick@free.fr>
	<16368.52302.736757.403219@gargle.gargle.HOWL>
	<200312300911.02044.baldrick@free.fr>
X-Mailer: VM 7.03 under Emacs 21.2.1
From: "Guldo K" <guldo@tiscali.it>
Reply-to: "Guldo K" <guldo@tiscali.it>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Duncan Sands writes:
 > You are compiling against 2.6 kernel headers.
 > (Most people have 2.4 kernel headers in
 > /usr/include/linux, even if they are running a
 > 2.6 kernel).  You will need to update the
 > firmware_loader directory.  Do the following:
 > 
 >         cvs -d:pserver:anonymous@cvs.speedtouch.sourceforge.net:/cvsroot/speedtouch login
 > 
 > (just hit return if asked for a password).

It looks like this needs a connection... it couldn't find the server.
Of course, I'm offline when doing this. :-(

This is getting too frustrating...
Maybe I'd better get an ethernet modem, shouldn't I?

Anyway, thank you very much for your answers and your patience.

Happy 2004! :-)

*Guldo*

 > Then do
 > 
 >         cvs -z 9 -d:pserver:anonymous@cvs.speedtouch.sourceforge.net:/cvsroot/speedtouch co speedtouch
 > 
 > This creates a directory called speedtouch.  Replace the contents of the
 > firmware_loader directory with the contents of this new speedtouch
 > directory.  Now rebuild: in the top level of the speedbundle do
 > 
 >         make clean
 >         make
 > (become root)
 >         make install
 > 

