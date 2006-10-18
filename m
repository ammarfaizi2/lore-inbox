Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422658AbWJRQ2u@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422658AbWJRQ2u (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 18 Oct 2006 12:28:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422660AbWJRQ2t
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 18 Oct 2006 12:28:49 -0400
Received: from ns2.suse.de ([195.135.220.15]:61895 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S1422658AbWJRQ2s (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 18 Oct 2006 12:28:48 -0400
From: Andi Kleen <ak@suse.de>
To: Cal Peake <cp@absolutedigital.net>
Subject: Re: [PATCHv2] Undeprecate the sysctl system call
Date: Wed, 18 Oct 2006 18:28:43 +0200
User-Agent: KMail/1.9.3
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, Andrew Morton <akpm@osdl.org>,
       Randy Dunlap <rdunlap@xenotime.net>, Jan Beulich <jbeulich@novell.com>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <453519EE.76E4.0078.0@novell.com> <200610181508.54237.ak@suse.de> <Pine.LNX.4.64.0610181214060.7303@lancer.cnet.absolutedigital.net>
In-Reply-To: <Pine.LNX.4.64.0610181214060.7303@lancer.cnet.absolutedigital.net>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200610181828.43814.ak@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 18 October 2006 18:20, Cal Peake wrote:

> -What:	sys_sysctl
> -When:	January 2007
> -Why:	The same information is available through /proc/sys and that is the
> -	interface user space prefers to use. And there do not appear to be
> -	any existing user in user space of sys_sysctl.  The additional
> -	maintenance overhead of keeping a set of binary names gets
> -	in the way of doing a good job of maintaining this interface.
> -
> -Who:	Eric Biederman <ebiederm@xmission.com>

I think the deprecation should stay.

-Andi
