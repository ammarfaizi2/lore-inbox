Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261307AbVFAV7p@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261307AbVFAV7p (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Jun 2005 17:59:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261312AbVFAV5N
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Jun 2005 17:57:13 -0400
Received: from rproxy.gmail.com ([64.233.170.203]:11886 "EHLO rproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261324AbVFAVx4 convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Jun 2005 17:53:56 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=BkCvP1L6w5hMuQPPSkJw76cxL7BPA7QqA9gVToHiIhzBXiQM3HIaTq0yAHvTA4fONAsYXEoFBpNY0RptGkJds1yZNBxZ9ohCGYchTEh2UkWLLwIprK1vnyFNmFxb7TpMFNfYylvxlAusDkvJcHgKEJRrH/wwYD8Hii29Jb0io0w=
Message-ID: <21d7e997050601145355174821@mail.gmail.com>
Date: Thu, 2 Jun 2005 07:53:55 +1000
From: Dave Airlie <airlied@gmail.com>
Reply-To: Dave Airlie <airlied@gmail.com>
To: Stefano Rivoir <s.rivoir@gts.it>
Subject: Re: 2.6.12-rc5-mm2
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
In-Reply-To: <200506011422.37147.s.rivoir@gts.it>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <20050601022824.33c8206e.akpm@osdl.org>
	 <200506011422.37147.s.rivoir@gts.it>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> This made my asus-acpi work again.
> 
> DRM/DRI seems to have stopped working since -rc5-mm1.
> -mm1 reported a badness in syslog (see my previous report int rc5-mm1
> announcement thread), while now something is silently failing: glxinfo
> reports

Can you look in dmesg for where it loads the drm and radeon drivers?
and agp? attach a dmesg from Linus tree and from -mm if you could..

Dave.
