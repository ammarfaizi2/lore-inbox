Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262386AbTKDRaM (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 4 Nov 2003 12:30:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262427AbTKDRaM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 4 Nov 2003 12:30:12 -0500
Received: from fw.osdl.org ([65.172.181.6]:19652 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S262386AbTKDRaK (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 4 Nov 2003 12:30:10 -0500
Date: Tue, 4 Nov 2003 09:29:49 -0800 (PST)
From: Linus Torvalds <torvalds@osdl.org>
To: John M Collins <jmc@xisl.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: Semaphores and threads anomaly and bug?
In-Reply-To: <3FA7D7A1.2030307@xisl.com>
Message-ID: <Pine.LNX.4.44.0311040928110.20373-100000@home.osdl.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Tue, 4 Nov 2003, John M Collins wrote:
> 
> I know this isn't defined anywhere but the seems to be an ambiguity and 
> discrepancy between versions of Unix and Linux over threads and semaphores.
> 
> Do the "SEM_UNDO"s get applied when a thread terminates or when the 
> "whole thing" terminates?

It's entirely up to you. That's what CLONE_SYSVSEM is supposed to 
determine.

However, CLONE_SYSVSEM is fairly recent, and I think you will need to use 
the new threading libraries to see it.

		Linus

