Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262606AbUCEO1Z (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 5 Mar 2004 09:27:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262602AbUCEO1Z
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 5 Mar 2004 09:27:25 -0500
Received: from mx1.redhat.com ([66.187.233.31]:1740 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S262606AbUCEO1G (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 5 Mar 2004 09:27:06 -0500
Subject: Re: Is there some bug in ext3 in 2.4.25?
From: "Stephen C. Tweedie" <sct@redhat.com>
To: Michael Frank <mhf@linuxmail.org>
Cc: Marcelo Tosatti <marcelo.tosatti@cyclades.com>,
       Daniel Fenert <daniel@fenert.net>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       Michelle Konzack <linux4michelle@freenet.de>,
       Stephen Tweedie <sct@redhat.com>
In-Reply-To: <opr4d66wct4evsfm@smtp.pacific.net.th>
References: <Pine.LNX.4.44.0403051048160.2678-100000@dmt.cyclades>
	 <opr4d66wct4evsfm@smtp.pacific.net.th>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Organization: 
Message-Id: <1078496816.14033.56.camel@sisko.scot.redhat.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 (1.2.2-5) 
Date: 05 Mar 2004 14:26:56 +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Fri, 2004-03-05 at 14:14, Michael Frank wrote:

> Although I have nt received a reply from LKML, it is definitively
> a real kernel bug in 2.4.22 which has been fixed in 2.4.24.
> 
> Ein weiterer Fehler trat mehrfach in 'exit.c' auf, der ebenfals
> nach der Installation von Linux 2.4.24 verschwunden war.
> 
> Further bug occuring several times in 'exit.c' has also vanished
> after installation of 2.4.24.

Sounds like bad memory.  It's quite impossible for a bad memory module
to show up a problem in one kernel but not in another, simply because
kernels are storing their active data in slightly different memory
locations from one release to another (or even from one compiler, or one
set of config options, to another.)

I'd definitely be running memtest86 as the next step here.

Cheers,
 Stephen

