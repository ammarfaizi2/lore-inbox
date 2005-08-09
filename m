Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932477AbVHIJOI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932477AbVHIJOI (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 9 Aug 2005 05:14:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932476AbVHIJOI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 9 Aug 2005 05:14:08 -0400
Received: from omx3-ext.sgi.com ([192.48.171.20]:20361 "EHLO omx3.sgi.com")
	by vger.kernel.org with ESMTP id S932477AbVHIJOH (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 9 Aug 2005 05:14:07 -0400
Date: Tue, 9 Aug 2005 02:13:55 -0700
From: Paul Jackson <pj@sgi.com>
To: Jan Engelhardt <jengelh@linux01.gwdg.de>
Cc: akpm@osdl.org, Simon.Derr@bull.net, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] cpuset release ABBA deadlock fix
Message-Id: <20050809021355.5a0710c9.pj@sgi.com>
In-Reply-To: <Pine.LNX.4.61.0508090902350.1805@yvahk01.tjqt.qr>
References: <20050808223722.22843.86768.sendpatchset@jackhammer.engr.sgi.com>
	<20050808232558.7173fdd7.akpm@osdl.org>
	<Pine.LNX.4.61.0508090902350.1805@yvahk01.tjqt.qr>
Organization: SGI
X-Mailer: Sylpheed version 2.0.0beta5 (GTK+ 2.4.9; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jan wrote:
> Because K&R (also the 2nd ed) does it.

I don't recall (void) being in early C.  Perhaps it was added as
part of the ANSI Standardization effort.  I doubt that the first
edition K&R [1978] has it.  But my copy is not at hand to verify
this.

I continue to use it in userspace code to document that I'm ignoring
a return value.  This habit likely began when I had to suppress lint
warnings about unused function returns at some point in my career.

-- 
                  I won't rest till it's the best ...
                  Programmer, Linux Scalability
                  Paul Jackson <pj@sgi.com> 1.925.600.0401
