Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932106AbWAUKdT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932106AbWAUKdT (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 21 Jan 2006 05:33:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932105AbWAUKdT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 21 Jan 2006 05:33:19 -0500
Received: from 213-239-205-147.clients.your-server.de ([213.239.205.147]:37008
	"EHLO mail.tglx.de") by vger.kernel.org with ESMTP id S932106AbWAUKdS
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 21 Jan 2006 05:33:18 -0500
Subject: Re: [PATCH] Normalize timespec for negative values in
	ns_to_timespec
From: Thomas Gleixner <tglx@linutronix.de>
Reply-To: tglx@linutronix.de
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, george@wildturkeyranch.net
In-Reply-To: <20060121021917.1ab7787c.akpm@osdl.org>
References: <20060121094137.049533000@localhost.localdomain>
	 <20060121021917.1ab7787c.akpm@osdl.org>
Content-Type: text/plain
Date: Sat, 21 Jan 2006 11:34:00 +0100
Message-Id: <1137839641.28034.62.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.5.4 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2006-01-21 at 02:19 -0800, Andrew Morton wrote:
> Thomas Gleixner <tglx@linutronix.de> wrote:
> >
> >    Cc: George Anzinger <george@wildturkeyfarm.net>
> >  From: George Anzinger <george@wildturkeyranch.net>
> 
> How many email addresses does the man have, and which is preferred?

Sorry, my bad. I copied the wrong one into the cc-list

<george@wildturkeyranch.net> is the correct one.

> >  In case of a negative nsec value the result of the division must be
> >  normalized.
> 
> What effect did this problem have?  oopses?  Userspace misbehaviour? ...

Both

	tglx


