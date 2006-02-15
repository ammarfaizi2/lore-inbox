Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751154AbWBOLx6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751154AbWBOLx6 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 15 Feb 2006 06:53:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751169AbWBOLx6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 15 Feb 2006 06:53:58 -0500
Received: from smtp.osdl.org ([65.172.181.4]:14242 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751154AbWBOLx5 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 15 Feb 2006 06:53:57 -0500
Date: Wed, 15 Feb 2006 03:52:51 -0800
From: Andrew Morton <akpm@osdl.org>
To: Pekka J Enberg <penberg@cs.Helsinki.FI>
Cc: linux-kernel@vger.kernel.org, netdev@vger.kernel.org
Subject: Re: [RFT/PATCH] 3c509: use proper suspend/resume API
Message-Id: <20060215035251.624a7273.akpm@osdl.org>
In-Reply-To: <Pine.LNX.4.58.0602151256580.14223@sbz-30.cs.Helsinki.FI>
References: <1139935173.22151.2.camel@localhost>
	<20060215022523.1d21b9c9.akpm@osdl.org>
	<Pine.LNX.4.58.0602151256580.14223@sbz-30.cs.Helsinki.FI>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Pekka J Enberg <penberg@cs.Helsinki.FI> wrote:
>
> On Wed, 15 Feb 2006, Andrew Morton wrote:
> > I have a 3c509, and I'm not afraid to use it!
> > 
> > Problem is, it doesn't resume correctly either with or without the patch:
> > it needs rmmod+modprobe to get it going again.  (Which is better than the
> > aic7xxx driver, which has a coronary and panics the kernel on post-resume
> > reboot).
> 
> Is there anything in the logs to give us a clue what's going on? I can't 
> see anything obvious looking at the code, but then again I don't have 
> datasheets for 3c509 either.
> 

eeprom reads 0xffff, that's all I noticed.
