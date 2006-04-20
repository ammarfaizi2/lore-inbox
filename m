Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751361AbWDTV4x@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751361AbWDTV4x (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 20 Apr 2006 17:56:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751354AbWDTV4w
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 20 Apr 2006 17:56:52 -0400
Received: from zeniv.linux.org.uk ([195.92.253.2]:61647 "EHLO
	ZenIV.linux.org.uk") by vger.kernel.org with ESMTP id S1751352AbWDTV4v
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 20 Apr 2006 17:56:51 -0400
Date: Thu, 20 Apr 2006 22:56:46 +0100
From: Al Viro <viro@ftp.linux.org.uk>
To: Linda Walsh <lkml@tlinx.org>
Cc: Stephen Smalley <sds@tycho.nsa.gov>, Tony Jones <tonyj@suse.de>,
       linux-kernel@vger.kernel.org, chrisw@sous-sol.org,
       linux-security-module@vger.kernel.org
Subject: Re: [RFC][PATCH 11/11] security: AppArmor - Export namespace	semaphore
Message-ID: <20060420215646.GB27946@ftp.linux.org.uk>
References: <20060419174905.29149.67649.sendpatchset@ermintrude.int.wirex.com> <20060419175034.29149.94306.sendpatchset@ermintrude.int.wirex.com> <1145536742.16456.35.camel@moss-spartans.epoch.ncsc.mil> <44480228.3060009@tlinx.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <44480228.3060009@tlinx.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 20, 2006 at 02:50:32PM -0700, Linda Walsh wrote:
> any access control scheme to be implemented?  I've seen complaints
> before on either here or the LSM list that one of the hurdles for
> "legitimacy" was whether or not it fit on top of the current set of
> LSM hooks.  I also saw it asked whether or not LSM had been
> designed

... and the answer is obviously "no".  AFAICS, that was a way to get
around Linus' "at least decide on a common set of core kernel modifications"
without any kind of thinking being involved.
