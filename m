Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262838AbTKHUR6 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 8 Nov 2003 15:17:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262839AbTKHUR6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 8 Nov 2003 15:17:58 -0500
Received: from dp.samba.org ([66.70.73.150]:41613 "EHLO lists.samba.org")
	by vger.kernel.org with ESMTP id S262838AbTKHUR5 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 8 Nov 2003 15:17:57 -0500
Date: Sun, 9 Nov 2003 07:15:18 +1100
From: Anton Blanchard <anton@samba.org>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Denis <vda@port.imtp.ilyichevsk.odessa.ua>, linux-kernel@vger.kernel.org
Subject: Re: 2.6-test6: nanosleep+SIGCONT weirdness
Message-ID: <20031108201518.GH3440@krispykreme>
References: <20031108184305.GF3440@krispykreme> <Pine.LNX.4.44.0311081053350.7319-100000@home.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44.0311081053350.7319-100000@home.osdl.org>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

 
> No, the restart code is fine. But the posix timer code looks fundamentally 
> broken. Try the patch I just sent, I bet it fixes it.

Yep, things work fine with your patch.

Anton
