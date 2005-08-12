Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750893AbVHLS3e@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750893AbVHLS3e (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 12 Aug 2005 14:29:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750894AbVHLS3e
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 12 Aug 2005 14:29:34 -0400
Received: from ra.tuxdriver.com ([24.172.12.4]:22535 "EHLO ra.tuxdriver.com")
	by vger.kernel.org with ESMTP id S1750893AbVHLS3d (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 12 Aug 2005 14:29:33 -0400
Date: Fri, 12 Aug 2005 14:29:28 -0400
From: "John W. Linville" <linville@tuxdriver.com>
To: KrnlUsr <kdp102@yahoo.com>
Cc: linux-kernel@vger.kernel.org, linux-net@vger.kernel.org
Subject: Re: copy_from_user, copy_to_user in kernel
Message-ID: <20050812182924.GB28072@tuxdriver.com>
Mail-Followup-To: KrnlUsr <kdp102@yahoo.com>, linux-kernel@vger.kernel.org,
	linux-net@vger.kernel.org
References: <20050812181623.6814.qmail@web80214.mail.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050812181623.6814.qmail@web80214.mail.yahoo.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 12, 2005 at 11:16:23AM -0700, KrnlUsr wrote:

> have the core routines copy processed data back to
> kernel thread or user space with copy_to_user. or do i
> have to have some check saying if called from ioctl
> call copy_to_user otherwise call memcpy?

Why wouldn't you just let the core routines deal only w/ kernel memory
and only have your ioctl handler deal w/ copy_{to,from}_user?

John
-- 
John W. Linville
linville@tuxdriver.com
