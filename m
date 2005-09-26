Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751626AbVIZM2n@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751626AbVIZM2n (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 26 Sep 2005 08:28:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751616AbVIZM2n
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 26 Sep 2005 08:28:43 -0400
Received: from ra.tuxdriver.com ([24.172.12.4]:8710 "EHLO ra.tuxdriver.com")
	by vger.kernel.org with ESMTP id S1751624AbVIZM2m (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 26 Sep 2005 08:28:42 -0400
Date: Mon, 26 Sep 2005 08:28:24 -0400
From: Neil Horman <nhorman@tuxdriver.com>
To: Al Boldi <a1426z@gawab.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Resource limits
Message-ID: <20050926122824.GA2100@hmsreliant.homelinux.net>
References: <200509251712.42302.a1426z@gawab.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200509251712.42302.a1426z@gawab.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Sep 25, 2005 at 05:12:42PM +0300, Al Boldi wrote:
> 
> Resource limits in Linux, when available, are currently very limited.
> 
> i.e.:
> Too many process forks and your system may crash.
> This can be capped with threads-max, but may lead you into a lock-out.
> 
> What is needed is a soft, hard, and a special emergency limit that would 
> allow you to use the resource for a limited time to circumvent a lock-out.
> 
Whats insufficient about the per-user limits that can be imposed by the ulimit
syscall?


> Would this be difficult to implement?
> 
> Thanks!
> 
> --
> Al
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/

-- 
/***************************************************
 *Neil Horman
 *Software Engineer
 *gpg keyid: 1024D / 0x92A74FA1 - http://pgp.mit.edu
 ***************************************************/
