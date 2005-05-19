Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262499AbVESNjo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262499AbVESNjo (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 19 May 2005 09:39:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262495AbVESNjo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 19 May 2005 09:39:44 -0400
Received: from users.ccur.com ([208.248.32.211]:21121 "EHLO gamx.iccur.com")
	by vger.kernel.org with ESMTP id S262499AbVESNjg (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 19 May 2005 09:39:36 -0400
Date: Thu, 19 May 2005 09:39:03 -0400
From: Joe Korty <joe.korty@ccur.com>
To: Inaky Perez-Gonzalez <inaky@linux.intel.com>
Cc: linux-kernel@vger.kernel.org, robustmutexes@lists.osdl.org,
       george@mvista.com
Subject: Re: [RFC] A more general timeout specification
Message-ID: <20050519133903.GA9473@tsunami.ccur.com>
Reply-To: joe.korty@ccur.com
References: <20050518201517.GA16193@tsunami.ccur.com> <17035.48794.636650.724153@sodium.jf.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <17035.48794.636650.724153@sodium.jf.intel.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 18, 2005 at 03:15:54PM -0700, Inaky Perez-Gonzalez wrote:

> The main reason why we are asking for this is that timeouts in POSIX
> calls are always specified in an absolute form. Because most system
> calls take it in a relative form, glibc has to call the kernel twice

Also, it is quite evil for a library to internally convert a user-specified
end time into relative time .. this causes end-time drift.

Joe
