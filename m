Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261345AbTJMCaD (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 12 Oct 2003 22:30:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261347AbTJMCaD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 12 Oct 2003 22:30:03 -0400
Received: from rcum.uni-mb.si ([164.8.2.10]:39639 "EHLO rcum.uni-mb.si")
	by vger.kernel.org with ESMTP id S261345AbTJMCaB (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 12 Oct 2003 22:30:01 -0400
Date: Mon, 13 Oct 2003 04:28:21 +0200
From: Domen Puncer <domen@coderock.org>
Subject: Re: 3c59x on 2.6.0-test3->test6 slow
In-reply-to: <20031012173702.57eea934.akpm@osdl.org>
To: Andrew Morton <akpm@osdl.org>
Cc: zwane@arm.linux.org.uk, linux-kernel@vger.kernel.org
Message-id: <200310130428.21170.domen@coderock.org>
MIME-version: 1.0
Content-type: text/plain; charset=iso-8859-1
Content-transfer-encoding: 7BIT
Content-disposition: inline
User-Agent: KMail/1.5.4
References: <200310061529.56959.domen@coderock.org>
 <200310130222.03175.domen@coderock.org> <20031012173702.57eea934.akpm@osdl.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 13 of October 2003 02:37, Andrew Morton wrote:
> Domen Puncer <domen@coderock.org> wrote:
> > Tried a bunch of 2.5.x kernels... no better.
> >  Then i tried 2.4.22... and my nic still doesn't work fast.
>
> There's some stuff in Documentation/networking/vortex.txt telling you how
> to locate and run vortex-diag and mii-diag.

Should have read this before, sorry.

options=8 (autonegotiate) solves my problem. (driver could default to that?)
Sorry for wasting your time.

>
> You might need to reprogram the eeprom using 3c90xx2.exe.

