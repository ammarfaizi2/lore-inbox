Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268383AbTCCGXl>; Mon, 3 Mar 2003 01:23:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268386AbTCCGXl>; Mon, 3 Mar 2003 01:23:41 -0500
Received: from smtp1.clear.net.nz ([203.97.33.27]:56963 "EHLO
	smtp1.clear.net.nz") by vger.kernel.org with ESMTP
	id <S268383AbTCCGXk>; Mon, 3 Mar 2003 01:23:40 -0500
Date: Mon, 03 Mar 2003 19:36:49 +1300
From: Nigel Cunningham <ncunningham@clear.net.nz>
Subject: Re: Software Suspend Functionality in 2.5
In-reply-to: <20030303095824.A2312@in.ibm.com>
To: suparna@in.ibm.com
Cc: Pavel Machek <pavel@ucw.cz>, Linus Torvalds <torvalds@transmeta.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Message-id: <1046673408.27945.5.camel@laptop-linux.cunninghams>
Organization: 
MIME-version: 1.0
X-Mailer: Ximian Evolution 1.2.1
Content-type: text/plain
Content-transfer-encoding: 7bit
References: <1046238339.1699.65.camel@laptop-linux.cunninghams>
 <20030227181220.A3082@in.ibm.com>
 <1046369790.2190.9.camel@laptop-linux.cunninghams>
 <20030228121725.B2241@in.ibm.com>
 <20030228130548.GA8498@atrey.karlin.mff.cuni.cz>
 <20030228190924.A3034@in.ibm.com>
 <20030228134406.GA14927@atrey.karlin.mff.cuni.cz>
 <20030228204831.A3223@in.ibm.com>
 <20030228151744.GB14927@atrey.karlin.mff.cuni.cz>
 <1046458775.1720.5.camel@laptop-linux.cunninghams>
 <20030303095824.A2312@in.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi.

On Mon, 2003-03-03 at 17:28, Suparna Bhattacharya wrote:
> If you add to that the possibility of being able to save more 
> in less space if you have compression, would it be useful ?

I'm not sure that it would because we don't know how much compression
we're going to get ahead of time, so we don't know how many extra pages
we can save. The compression/decompression also takes extra time and
puts more drain on a potentially low battery.

I suppose it could be included as an option if it was going to already
be there for LKCD anyway, but I'm not sure it would be helpful for the
usual use of swsusp.

Regards,

Nigel

