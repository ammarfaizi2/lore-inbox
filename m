Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964835AbWJOTgb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964835AbWJOTgb (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 15 Oct 2006 15:36:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964837AbWJOTgb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 15 Oct 2006 15:36:31 -0400
Received: from smtp.osdl.org ([65.172.181.4]:34794 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S964835AbWJOTga (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 15 Oct 2006 15:36:30 -0400
Date: Sun, 15 Oct 2006 12:36:15 -0700
From: Andrew Morton <akpm@osdl.org>
To: linux-kernel@vger.kernel.org
Cc: bugme-daemon@bugzilla.kernel.org
Subject: Re: [Bug 7364] nbd dead-lock/panic with 4k stack
Message-Id: <20061015123615.10cf5c97.akpm@osdl.org>
In-Reply-To: <200610151920.k9FJKosE008506@fire-2.osdl.org>
References: <200610151920.k9FJKosE008506@fire-2.osdl.org>
X-Mailer: Sylpheed version 2.2.7 (GTK+ 2.8.17; x86_64-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 15 Oct 2006 12:20:50 -0700
bugme-daemon@bugzilla.kernel.org wrote:

> http://bugzilla.kernel.org/show_bug.cgi?id=7364

We have a repeatable stack overrun with 4k stacks, XFS over NBD.

