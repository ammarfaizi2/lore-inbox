Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261712AbTICJVy (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 3 Sep 2003 05:21:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261719AbTICJVx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 3 Sep 2003 05:21:53 -0400
Received: from ns2.uk.superh.com ([193.128.105.170]:58769 "EHLO
	ns2.uk.superh.com") by vger.kernel.org with ESMTP id S261712AbTICJVw
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 3 Sep 2003 05:21:52 -0400
Date: Wed, 3 Sep 2003 10:21:43 +0100
From: Richard Curnow <Richard.Curnow@superh.com>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: kernel bug in 2.6.0-test4-mm4 when removing USB flash disc
Message-ID: <20030903092143.GA334@malvern.uk.w2k.superh.com>
Mail-Followup-To: Andrew Morton <akpm@osdl.org>,
	linux-kernel@vger.kernel.org
References: <20030902121727.GA340@malvern.uk.w2k.superh.com> <20030902102316.57d30c54.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030902102316.57d30c54.akpm@osdl.org>
X-OS: Linux 2.6.0-test4-mm4 i686
User-Agent: Mutt/1.5.4i
X-OriginalArrivalTime: 03 Sep 2003 09:22:30.0014 (UTC) FILETIME=[E5F371E0:01C371FC]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* Andrew Morton <akpm@osdl.org> [2003-09-02]:
> 
> Thanks.  This should make it happy again:
> 
> diff -puN lib/kobject.c~kobject-unlimited-name-lengths-use-after-free-fix lib/kobject.c

Thanks Andrew, that's fixed the problem.

-- 
Richard \\\ SuperH Core+Debug Architect /// .. At home ..
  P.    /// richard.curnow@superh.com  ///  rc@rc0.org.uk
Curnow  \\\ http://www.superh.com/    ///  www.rc0.org.uk
