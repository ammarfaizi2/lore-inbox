Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750751AbVJWUkX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750751AbVJWUkX (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 23 Oct 2005 16:40:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750763AbVJWUkW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 23 Oct 2005 16:40:22 -0400
Received: from mta10.adelphia.net ([68.168.78.202]:7311 "EHLO
	mta10.adelphia.net") by vger.kernel.org with ESMTP id S1750751AbVJWUkV
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 23 Oct 2005 16:40:21 -0400
Date: Sun, 23 Oct 2005 13:40:20 -0700
From: Matt Zimmerman <mdz@ubuntu.com>
To: ubuntu-devel@lists.ubuntu.com, linux-kernel@vger.kernel.org
Subject: Re: Keep initrd tasks running?
Message-ID: <20051023204020.GN10501@alcor.net>
Mail-Followup-To: ubuntu-devel@lists.ubuntu.com,
	linux-kernel@vger.kernel.org
References: <4355494C.5090707@comcast.net> <1129663759.18784.98.camel@localhost.localdomain> <4355BEF4.8000800@cfl.rr.com> <4355C9F3.40004@comcast.net> <435695EE.4090704@cfl.rr.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <435695EE.4090704@cfl.rr.com>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 19, 2005 at 02:52:30PM -0400, Phillip Susi wrote:
> thought that with initramfs, init actually exited and the kernel unmounted
> the initramfs, and mounted the real root and ran the real init.

This is not what happens; look at run-init in klibc if you want to
understand how it does work.

-- 
 - mdz
