Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261886AbUJZAcO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261886AbUJZAcO (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 25 Oct 2004 20:32:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261882AbUJZAcF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 25 Oct 2004 20:32:05 -0400
Received: from phoenix.infradead.org ([81.187.226.98]:55820 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id S261894AbUJYPB3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 25 Oct 2004 11:01:29 -0400
Date: Mon, 25 Oct 2004 16:01:28 +0100
From: Christoph Hellwig <hch@infradead.org>
To: Mike Waychison <michael.waychison@sun.com>
Cc: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
       raven@themaw.net
Subject: Re: [PATCH 27/28] Testing syscall for expiry
Message-ID: <20041025150128.GA1538@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Mike Waychison <michael.waychison@sun.com>,
	linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
	raven@themaw.net
References: <1098715902968@sun.com> <1098715932358@sun.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1098715932358@sun.com>
User-Agent: Mutt/1.4.1i
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by phoenix.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 25, 2004 at 10:52:12AM -0400, Mike Waychison wrote:
> This patch adds a temporary syscall (to x86 only) that allows for quick
> testing to make sure that mnt_expire works properly.  Tests can be found in
> the autofsng userspace package.

> +/* TESTING PURPOSES ONLY:  THIS IS NOT A REAL SYSCALL!! - IT WILL GO AWAY */
> +asmlinkage int sys_mnt_expire(char __user *_path, int ticks)

so don't submit it..

