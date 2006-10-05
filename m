Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932189AbWJERUX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932189AbWJERUX (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 5 Oct 2006 13:20:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932187AbWJERUW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 5 Oct 2006 13:20:22 -0400
Received: from srv5.dvmed.net ([207.36.208.214]:63979 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S932188AbWJERUT (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 5 Oct 2006 13:20:19 -0400
Message-ID: <45253ECF.8080709@garzik.org>
Date: Thu, 05 Oct 2006 13:20:15 -0400
From: Jeff Garzik <jeff@garzik.org>
User-Agent: Thunderbird 1.5.0.7 (X11/20060913)
MIME-Version: 1.0
To: Matthew Wilcox <matthew@wil.cx>
CC: Linus Torvalds <torvalds@osdl.org>, linux-arch@vger.kernel.org,
       linux-kernel@vger.kernel.org, Matthew Wilcox <willy@parisc-linux.org>
Subject: Re: [PATCH] Consolidate check_signature
References: <11600679551209-git-send-email-matthew@wil.cx> <11600679552794-git-send-email-matthew@wil.cx>
In-Reply-To: <11600679552794-git-send-email-matthew@wil.cx>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Score: -4.3 (----)
X-Spam-Report: SpamAssassin version 3.1.3 on srv5.dvmed.net summary:
	Content analysis details:   (-4.3 points, 5.0 required)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Matthew Wilcox wrote:
> There's nothing arch-specific about check_signature(), so move it to
> <linux/io.h>.  Use a cross between the Alpha and i386 implementations
> as the generic one.
> 
> Signed-off-by: Matthew Wilcox <willy@parisc-linux.org>

IMO this isn't 2.6.19-rc1 material.

Much more appropriate for 2.6.20, after living in -mm for a while.

	Jeff



