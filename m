Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1752893AbWKLTau@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752893AbWKLTau (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 12 Nov 2006 14:30:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752894AbWKLTau
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 12 Nov 2006 14:30:50 -0500
Received: from smtp.osdl.org ([65.172.181.4]:11206 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1752892AbWKLTat (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 12 Nov 2006 14:30:49 -0500
Date: Sun, 12 Nov 2006 11:30:18 -0800
From: Andrew Morton <akpm@osdl.org>
To: Ingo Molnar <mingo@elte.hu>
Cc: Mikael Pettersson <mikpe@it.uu.se>, linux-kernel@vger.kernel.org
Subject: Re: [patch] floppy: suspend/resume fix
Message-Id: <20061112113018.f95f40a6.akpm@osdl.org>
In-Reply-To: <20061112180953.GA3266@elte.hu>
References: <200611121753.kACHrDDi004283@harpo.it.uu.se>
	<20061112180953.GA3266@elte.hu>
X-Mailer: Sylpheed version 2.2.7 (GTK+ 2.8.17; x86_64-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 12 Nov 2006 19:09:53 +0100
Ingo Molnar <mingo@elte.hu> wrote:

> 
> * Mikael Pettersson <mikpe@it.uu.se> wrote:
> 
> > Sorry, no joy. The first access post-resume still fails and generates:
> 
> ok, then someone who knows the floppy driver better than me should put 
> the right stuff into the suspend/resume hooks :-)

I don't think anyone understands the floppy driver.

How about we just revert the lockdep change?
