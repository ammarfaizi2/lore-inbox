Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751442AbWJHUV4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751442AbWJHUV4 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 8 Oct 2006 16:21:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751440AbWJHUVz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 8 Oct 2006 16:21:55 -0400
Received: from smtp.osdl.org ([65.172.181.4]:1463 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751438AbWJHUVy (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 8 Oct 2006 16:21:54 -0400
Date: Sun, 8 Oct 2006 13:21:47 -0700
From: Andrew Morton <akpm@osdl.org>
To: Matthew Wilcox <matthew@wil.cx>
Cc: Linus Torvalds <torvalds@osdl.org>, linux-arch@vger.kernel.org,
       linux-kernel@vger.kernel.org, Matthew Wilcox <willy@parisc-linux.org>
Subject: Re: [PATCH] Consolidate check_signature
Message-Id: <20061008132147.958dc6a8.akpm@osdl.org>
In-Reply-To: <11600679552794-git-send-email-matthew@wil.cx>
References: <11600679551209-git-send-email-matthew@wil.cx>
	<11600679552794-git-send-email-matthew@wil.cx>
X-Mailer: Sylpheed version 2.2.7 (GTK+ 2.8.17; x86_64-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 05 Oct 2006 11:05:55 -0600
Matthew Wilcox <matthew@wil.cx> wrote:

> There's nothing arch-specific about check_signature(), so move it to
> <linux/io.h>.  Use a cross between the Alpha and i386 implementations
> as the generic one.

It wuld have been nice to have uninlined it too.  And to have given
it a less crappy name.
