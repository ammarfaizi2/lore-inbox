Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262420AbSLJQLX>; Tue, 10 Dec 2002 11:11:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262452AbSLJQLK>; Tue, 10 Dec 2002 11:11:10 -0500
Received: from irongate.swansea.linux.org.uk ([194.168.151.19]:7360 "EHLO
	irongate.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S262416AbSLJQKO>; Tue, 10 Dec 2002 11:10:14 -0500
Subject: Re: Why does C3 CPU downgrade in kernel 2.4.20?
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Daniel Egger <degger@fhm.edu>
Cc: Dave Jones <davej@codemonkey.org.uk>, Joseph <jospehchan@yahoo.com.tw>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <1039504941.30881.10.camel@sonja>
References: <009f01c2a000$f38885d0$3716a8c0@taipei.via.com.tw>
	<20021210055215.GA9124@suse.de>  <1039504941.30881.10.camel@sonja>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-10) 
Date: 10 Dec 2002 16:51:20 +0000
Message-Id: <1039539080.14302.29.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> Interesting. I have no clue about which C3 you're talking about here but
> a VIA Ezra has all 686 instructions including cmov and thus optimising 
> for PPro works best for me.

Well if you optimise for ppro it won't actually always work. Also the
scheduling seems to be best with 486. Remember the C3 is a single issue
risc processor.

Alan

