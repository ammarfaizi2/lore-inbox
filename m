Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268637AbUJDViX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268637AbUJDViX (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 4 Oct 2004 17:38:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268594AbUJDVhK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 4 Oct 2004 17:37:10 -0400
Received: from fw.osdl.org ([65.172.181.6]:47287 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S268637AbUJDVba (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 4 Oct 2004 17:31:30 -0400
Date: Mon, 4 Oct 2004 14:35:20 -0700
From: Andrew Morton <akpm@osdl.org>
To: Ingo Molnar <mingo@elte.hu>
Cc: annabellesgarden@yahoo.de, linux-kernel@vger.kernel.org
Subject: Re: 2.6.9-rc3-mm2
Message-Id: <20041004143520.4dd06e89.akpm@osdl.org>
In-Reply-To: <20041004212633.GA13527@elte.hu>
References: <200410041634.24937.annabellesgarden@yahoo.de>
	<20041004122304.4f545f3c.akpm@osdl.org>
	<20041004122533.0a85a1ad.akpm@osdl.org>
	<20041004212633.GA13527@elte.hu>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i586-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ingo Molnar <mingo@elte.hu> wrote:
>
> Must not put side-effects into a macro that is NOP on
> !SMP.

Doh.   I added several of those.  Thanks.
