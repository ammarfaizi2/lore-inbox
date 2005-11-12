Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964882AbVKLXms@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964882AbVKLXms (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 12 Nov 2005 18:42:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964883AbVKLXms
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 12 Nov 2005 18:42:48 -0500
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:26828 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S964882AbVKLXmr (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 12 Nov 2005 18:42:47 -0500
Date: Sun, 13 Nov 2005 00:42:38 +0100
From: Pavel Machek <pavel@ucw.cz>
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: LKML <linux-kernel@vger.kernel.org>
Subject: Re: [RFT][PATCH 1/3] swsusp: remove encryption
Message-ID: <20051112234238.GA1708@elf.ucw.cz>
References: <200511122113.22177.rjw@sisk.pl> <200511122119.46798.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200511122119.46798.rjw@sisk.pl>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On So 12-11-05 21:19:46, Rafael J. Wysocki wrote:
> This patch removes the image encryption that is only used by swsusp instead
> of zeroing the image after resume in order to prevent someone from
> reading some confidential data from it in the future and it does not protect
> the image from being read by an unauthorized person before resume.
> The functionality it provides should really belong to the user space
> and will possibly be reimplemented after the swap-handling functionality
> of swsusp is moved to the user space.
> 
> Signed-off-by: Rafael J. Wysocki <rjw@sisk.pl>

ACK.
								Pavel
