Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261774AbVFFWeo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261774AbVFFWeo (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 6 Jun 2005 18:34:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261764AbVFFWcb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 6 Jun 2005 18:32:31 -0400
Received: from fire.osdl.org ([65.172.181.4]:17819 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S261757AbVFFWaj (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 6 Jun 2005 18:30:39 -0400
Date: Mon, 6 Jun 2005 15:31:18 -0700
From: Andrew Morton <akpm@osdl.org>
To: Jeff Dike <jdike@addtoit.com>
Cc: torvalds@osdl.org, linux-kernel@vger.kernel.org,
       user-mode-linux-devel@lists.sourceforge.net
Subject: Re: [PATCH 5/5] UML - clean up error path
Message-Id: <20050606153118.1f7a413f.akpm@osdl.org>
In-Reply-To: <200506062008.j56K8BKG008967@ccure.user-mode-linux.org>
References: <200506062008.j56K8BKG008967@ccure.user-mode-linux.org>
X-Mailer: Sylpheed version 1.0.0 (GTK+ 1.2.10; i386-vine-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jeff Dike <jdike@addtoit.com> wrote:
>
> This cleans an error path which used to leak file descriptors by returning
> without trying to tidy up.

The code in 2.6.12-rc6 is quite different from whatever you've patched here.
