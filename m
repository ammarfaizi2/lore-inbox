Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751696AbWJERTt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751696AbWJERTt (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 5 Oct 2006 13:19:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751701AbWJERTt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 5 Oct 2006 13:19:49 -0400
Received: from srv5.dvmed.net ([207.36.208.214]:61931 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S1751696AbWJERTs (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 5 Oct 2006 13:19:48 -0400
Message-ID: <45253EAE.2070600@garzik.org>
Date: Thu, 05 Oct 2006 13:19:42 -0400
From: Jeff Garzik <jeff@garzik.org>
User-Agent: Thunderbird 1.5.0.7 (X11/20060913)
MIME-Version: 1.0
To: Matthew Wilcox <matthew@wil.cx>
CC: Linus Torvalds <torvalds@osdl.org>, linux-arch@vger.kernel.org,
       linux-kernel@vger.kernel.org, Matthew Wilcox <willy@parisc-linux.org>
Subject: Re: [PATCH] Use linux/io.h instead of asm/io.h
References: <11600679551209-git-send-email-matthew@wil.cx>
In-Reply-To: <11600679551209-git-send-email-matthew@wil.cx>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Score: -4.3 (----)
X-Spam-Report: SpamAssassin version 3.1.3 on srv5.dvmed.net summary:
	Content analysis details:   (-4.3 points, 5.0 required)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Matthew Wilcox wrote:
> In preparation for moving check_signature, change these users from
> asm/io.h to linux/io.h
> 
> Signed-off-by: Matthew Wilcox <willy@parisc-linux.org>

The vast majority of drivers include asm/io.h.

Wouldn't it be better to move check_signature to 
include/asm-generic/io.h, and include that where needed?

	Jeff



