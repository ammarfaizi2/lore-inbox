Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262224AbTCHVhG>; Sat, 8 Mar 2003 16:37:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262228AbTCHVhG>; Sat, 8 Mar 2003 16:37:06 -0500
Received: from 81-2-122-30.bradfords.org.uk ([81.2.122.30]:52745 "EHLO
	81-2-122-30.bradfords.org.uk") by vger.kernel.org with ESMTP
	id <S262224AbTCHVhG>; Sat, 8 Mar 2003 16:37:06 -0500
From: John Bradford <john@grabjohn.com>
Message-Id: <200303082142.h28Lgfok003005@81-2-122-30.bradfords.org.uk>
Subject: Re: 2.4.21-pre5-ac2:  kernel oops with "swapoff -a"
To: alan@lxorguk.ukuu.org.uk (Alan Cox)
Date: Sat, 8 Mar 2003 21:42:41 +0000 (GMT)
Cc: wa1ter@myrealbox.com, linux-kernel@vger.kernel.org
In-Reply-To: <1047163205.26745.1.camel@irongate.swansea.linux.org.uk> from "Alan Cox" at Mar 08, 2003 10:40:06 PM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > Plain 2.4.21-pre5 does NOT show this problem, so it seems to be a
> > patch that was specifically introduced in -pre4-ac7 and I don't
> > know enough to narrow it any further than that.  I'm not an
> > accomplished kernel debugger so I can't offer much more info than
> > that, but I'd like to help if you can give me some hints what kind
> > of information you might need to find the problem.
> 
> The patch is staying in -ac until I find out why you hit it. I've had no
> other reports so far, but it just be the way your system is calling it.

Just a thought - maybe he is using type 0 swap space?  That could
explain the lack of other reports...

John.
