Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262337AbUKDTPo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262337AbUKDTPo (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 4 Nov 2004 14:15:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262369AbUKDTPo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 4 Nov 2004 14:15:44 -0500
Received: from sd291.sivit.org ([194.146.225.122]:28909 "EHLO sd291.sivit.org")
	by vger.kernel.org with ESMTP id S262337AbUKDTPM (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 4 Nov 2004 14:15:12 -0500
Date: Thu, 4 Nov 2004 20:15:30 +0100
From: Stelian Pop <stelian@popies.net>
To: linux-kernel@vger.kernel.org
Cc: Linus Torvalds <torvalds@osdl.org>
Subject: Re: [PATCH] kfifo_alloc buffer
Message-ID: <20041104191530.GA3996@deep-space-9.dsnet>
Reply-To: Stelian Pop <stelian@popies.net>
Mail-Followup-To: Stelian Pop <stelian@popies.net>,
	linux-kernel@vger.kernel.org, Linus Torvalds <torvalds@osdl.org>
References: <20041104170632.GX3618@admingilde.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20041104170632.GX3618@admingilde.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 04, 2004 at 06:06:32PM +0100, Martin Waitz wrote:

> hi :)
> 
> kfifo_alloc tries to round up the buffer size to the next power of two.
> But it accidently uses the original size when calling kfifo_init,
> which will BUG.

Good catch, thanks.

Linus, please apply.

Stelian.
-- 
Stelian Pop <stelian@popies.net>
