Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262070AbVADAlw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262070AbVADAlw (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 3 Jan 2005 19:41:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262005AbVADAhs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 3 Jan 2005 19:37:48 -0500
Received: from one.firstfloor.org ([213.235.205.2]:49847 "EHLO
	one.firstfloor.org") by vger.kernel.org with ESMTP id S261980AbVADAez
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 3 Jan 2005 19:34:55 -0500
To: colin@coesta.com
Cc: linux-kernel@vger.kernel.org
Subject: Re: Max CPUs on x86_64 under 2.6.x
References: <44438.202.154.120.74.1104760841.squirrel@www.coesta.com>
From: Andi Kleen <ak@muc.de>
Date: Tue, 04 Jan 2005 01:34:50 +0100
In-Reply-To: <44438.202.154.120.74.1104760841.squirrel@www.coesta.com> (Colin
 Coe's message of "Mon, 3 Jan 2005 22:00:41 +0800 (WST)")
Message-ID: <m14qhyxc9h.fsf@muc.de>
User-Agent: Gnus/5.110002 (No Gnus v0.2) Emacs/21.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Colin Coe" <colin@coesta.com> writes:

> Hi all
>
> Why is the number of CPUs on the x86_64 architecture only 8 but under i386
> it is 255?
>
> I've searched the list archives and Google but can't find an answer.

Post 2.6.10 x86-64 will support more CPUs. 2.6.10 actually does too,
but the Kconfig hadn't been changed then. Previously there was an
8 CPU APIC driver limit, however it turned out later that it doesn't
apply to some Opteron machines.

-Andi
