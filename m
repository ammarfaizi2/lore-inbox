Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262785AbVG2UbF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262785AbVG2UbF (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 29 Jul 2005 16:31:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262784AbVG2UMa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 29 Jul 2005 16:12:30 -0400
Received: from smtp.osdl.org ([65.172.181.4]:42935 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S262785AbVG2UKr (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 29 Jul 2005 16:10:47 -0400
Date: Fri, 29 Jul 2005 13:10:31 -0700 (PDT)
From: Linus Torvalds <torvalds@osdl.org>
To: "Eric W. Biederman" <ebiederm@xmission.com>
cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       Andi Kleen <ak@suse.de>
Subject: Re: [PATCH] x86_64 io_apic.c: Memorize at bootup where the i8259 is
 connected
In-Reply-To: <m164ut2yx0.fsf@ebiederm.dsl.xmission.com>
Message-ID: <Pine.LNX.4.58.0507291309270.3307@g5.osdl.org>
References: <m164ut2yx0.fsf@ebiederm.dsl.xmission.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



All my comments on the x86 side also apply to this x86-64 version of the 
patch. 

I think the code would be cleaner too, if we did this inside the existing 
loop that already calculates the number of pins for the different 
IO-APICs?

		Linus
