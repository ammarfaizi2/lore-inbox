Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S275377AbTHNRPC (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 14 Aug 2003 13:15:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S275379AbTHNRPC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 14 Aug 2003 13:15:02 -0400
Received: from fw.osdl.org ([65.172.181.6]:60544 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S275377AbTHNRO7 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 14 Aug 2003 13:14:59 -0400
Date: Thu, 14 Aug 2003 10:14:37 -0700 (PDT)
From: Linus Torvalds <torvalds@osdl.org>
To: John Levon <levon@movementarian.org>
cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, Russell King <rmk@arm.linux.org.uk>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] Make modules work in Linus' tree on ARM
In-Reply-To: <20030814165512.GA36329@compsoc.man.ac.uk>
Message-ID: <Pine.LNX.4.44.0308141011030.8148-100000@home.osdl.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Thu, 14 Aug 2003, John Levon wrote:
> 
> And then I'm stuck with no sensible way to figure out the kernel pointer
> size again...

Why not just fix the oprofile interfaces to contain that information? You 
already have to export CPU type, buffer size etc..

		Linus

