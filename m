Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262012AbVDLFVD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262012AbVDLFVD (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 12 Apr 2005 01:21:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262014AbVDLFUf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 12 Apr 2005 01:20:35 -0400
Received: from gate.crashing.org ([63.228.1.57]:62874 "EHLO gate.crashing.org")
	by vger.kernel.org with ESMTP id S262018AbVDLD1X (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 11 Apr 2005 23:27:23 -0400
Subject: Re: 2.6.12-rc2-mm3
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Juergen Kreileder <jk@blackdown.de>
Cc: Andrew Morton <akpm@osdl.org>,
       Linux Kernel list <linux-kernel@vger.kernel.org>
In-Reply-To: <87wtr8rdvu.fsf@blackdown.de>
References: <20050411012532.58593bc1.akpm@osdl.org>
	 <87wtr8rdvu.fsf@blackdown.de>
Content-Type: text/plain
Date: Tue, 12 Apr 2005 13:26:05 +1000
Message-Id: <1113276365.5387.39.camel@gaston>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2005-04-12 at 03:18 +0200, Juergen Kreileder wrote:
> Andrew Morton <akpm@osdl.org> writes:
> 
> > ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.12-rc2/2.6.12-rc2-mm3/
> 
> I'm getting frequent lockups on my PowerMac G5 with rc2-mm3.
> 
> 2.6.11-mm4 works fine but all 2.6.12 versions I've tried (all since
> -rc1-mm3) lock up randomly.  The easiest way to reproduce the problem
> seems to be running Azareus.  So it might be network related, but I'm
> not 100% sure about that, there was a least one deadlock with
> virtually no network usage.
> 
> BTW, what's the SysRq key on recent Apple USB keyboards?  Alt/Cmd-F13
> doesn't work for me.
> 

Hrm... I just noticed you have CONFIG_PREEMPT enabled... Can you test
without it and let me know if it makes a difference ?

Ben.


