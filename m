Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264595AbUG0L0m@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264595AbUG0L0m (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 Jul 2004 07:26:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264633AbUG0L0m
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 Jul 2004 07:26:42 -0400
Received: from cantor.suse.de ([195.135.220.2]:24010 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id S264595AbUG0L0l (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 Jul 2004 07:26:41 -0400
Date: Tue, 27 Jul 2004 13:26:38 +0200
From: Andi Kleen <ak@suse.de>
To: Zwane Mwaikambo <zwane@linuxpower.ca>
Cc: linux-kernel@vger.kernel.org, akpm@osdl.org
Subject: Re: [PATCH][2.6] Allow x86_64 to reenable interrupts on contention
Message-Id: <20040727132638.7d26e825.ak@suse.de>
In-Reply-To: <Pine.LNX.4.58.0407270432470.23989@montezuma.fsmlabs.com>
References: <Pine.LNX.4.58.0407270432470.23989@montezuma.fsmlabs.com>
X-Mailer: Sylpheed version 0.9.11 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 27 Jul 2004 05:29:10 -0400 (EDT)
Zwane Mwaikambo <zwane@linuxpower.ca> wrote:

> This is a follow up to the previous patches for ia64 and i386, it will
> allow x86_64 to reenable interrupts during contested locks depending on
> previous interrupt enable status. It has been runtime and compile tested
> on UP and 2x SMP Linux-tiny/x86_64.

This will likely increase code size. Do you have numbers by how much? And is it 
really worth it?

-Andi

