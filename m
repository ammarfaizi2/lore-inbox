Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261784AbUCPXEV (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 16 Mar 2004 18:04:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261794AbUCPXEV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 16 Mar 2004 18:04:21 -0500
Received: from ginger.cmf.nrl.navy.mil ([134.207.10.161]:53127 "EHLO
	ginger.cmf.nrl.navy.mil") by vger.kernel.org with ESMTP
	id S261784AbUCPXEU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 16 Mar 2004 18:04:20 -0500
Message-Id: <200403162304.i2GN4BaD022348@ginger.cmf.nrl.navy.mil>
To: Peter Daum <gator@cs.tu-berlin.de>
cc: linux-kernel@vger.kernel.org, linux-atm-general@lists.sourceforge.net
Subject: Re: Bug in ForeRunner LE (cache line settings) (was ATM (LANE) - related Kernel-Crashes) 
In-Reply-To: Message from Peter Daum <gator@cs.tu-berlin.de> 
   of "Tue, 16 Mar 2004 23:24:13 +0100." <Pine.LNX.4.30.0403162025460.17727-100000@swamp.bayern.net> 
Date: Tue, 16 Mar 2004 18:04:13 -0500
From: "chas williams (contractor)" <chas@cmf.nrl.navy.mil>
X-Spam-Score: (*) hits=1.7
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In message <Pine.LNX.4.30.0403162025460.17727-100000@swamp.bayern.net>,Peter Da
um writes:
>Unfortunately, the patch does not fix the problem: My usual test
>case, transferring data from Mcafee's ftp server, still doesn't
>work.

and i am not surprised.  just read the manual for the card and it
doesnt support mwi (memory write invalidate) so the cache line
setting of the nicstar is meaningless.  i will need to think about
this some more.
