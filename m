Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263637AbTFCTcv (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 3 Jun 2003 15:32:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263743AbTFCTcv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 3 Jun 2003 15:32:51 -0400
Received: from diesel.grid4.com ([208.49.116.17]:44929 "EHLO diesel.grid4.com")
	by vger.kernel.org with ESMTP id S263637AbTFCTcu (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 3 Jun 2003 15:32:50 -0400
Date: Tue, 3 Jun 2003 15:45:37 -0400
From: Paul <set@pobox.com>
To: Marcelo Tosatti <marcelo@conectiva.com.br>
Cc: lkml <linux-kernel@vger.kernel.org>
Subject: Config issue (CONFIG_X86_TSC) Re: Linux 2.4.21-rc6
Message-ID: <20030603194537.GO22874@squish.home.loc>
Mail-Followup-To: Paul <set@pobox.com>,
	Marcelo Tosatti <marcelo@conectiva.com.br>,
	lkml <linux-kernel@vger.kernel.org>
References: <Pine.LNX.4.55L.0305282019160.321@freak.distro.conectiva>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.55L.0305282019160.321@freak.distro.conectiva>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Marcelo Tosatti <marcelo@conectiva.com.br>, on Wed May 28, 2003 [09:55:39 PM] said:
> 
> Hi,
> 
> Here goes -rc6. I've decided to delay 2.4.21 a bit and try Andrew's fix
> for the IO stalls/deadlocks.
> 
> Please test it.
> 
	Hi;

	It seems if I run 'make menuconfig', and the only change
I make is to change the processor type from its default to
486, "CONFIG_X86_TSC=y", remains in the .config, which results
in a kernel that wont boot on a 486.
	Running 'make oldconfig' seems to fix it up, though...

Paul
set@pobox.com
