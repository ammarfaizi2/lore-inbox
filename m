Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932091AbWAUKTg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932091AbWAUKTg (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 21 Jan 2006 05:19:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932094AbWAUKTg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 21 Jan 2006 05:19:36 -0500
Received: from smtp.osdl.org ([65.172.181.4]:43418 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S932091AbWAUKTg (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 21 Jan 2006 05:19:36 -0500
Date: Sat, 21 Jan 2006 02:19:17 -0800
From: Andrew Morton <akpm@osdl.org>
To: Thomas Gleixner <tglx@linutronix.de>
Cc: linux-kernel@vger.kernel.org, george@wildturkeyfarm.net
Subject: Re: [PATCH] Normalize timespec for negative values in
 ns_to_timespec
Message-Id: <20060121021917.1ab7787c.akpm@osdl.org>
In-Reply-To: <20060121094137.049533000@localhost.localdomain>
References: <20060121094137.049533000@localhost.localdomain>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Thomas Gleixner <tglx@linutronix.de> wrote:
>
>    Cc: George Anzinger <george@wildturkeyfarm.net>
>  From: George Anzinger <george@wildturkeyranch.net>

How many email addresses does the man have, and which is preferred?

>  In case of a negative nsec value the result of the division must be
>  normalized.

What effect did this problem have?  oopses?  Userspace misbehaviour? ...

