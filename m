Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261573AbVBTEhW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261573AbVBTEhW (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 19 Feb 2005 23:37:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261571AbVBTEhV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 19 Feb 2005 23:37:21 -0500
Received: from adsl-64-161-106-9.dsl.snfc21.pacbell.net ([64.161.106.9]:30920
	"EHLO eden.trestle.com") by vger.kernel.org with ESMTP
	id S261573AbVBTEhR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 19 Feb 2005 23:37:17 -0500
From: Scott Bronson <bronson@rinspin.com>
To: Roland Dreier <roland@topspin.com>
Subject: Re: Getting the page size of currently running kernel
Date: Sat, 19 Feb 2005 20:39:38 -0800
User-Agent: KMail/1.7.2
References: <200502191901.57425.bronson@rinspin.com> <521xbbucys.fsf@topspin.com>
In-Reply-To: <521xbbucys.fsf@topspin.com>
Cc: LKML <linux-kernel@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200502192039.38390.bronson@rinspin.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Saturday 19 February 2005 19:28, Roland Dreier wrote:
> I'm not sure exactly how to call it from perl, but from C one can use
> sysconf(3) like:
>
>  page_size = sysconf(_SC_PAGESIZE);
>
> (one can also use getpagesize(2) to do exactly the same thing)

And I was going nuts looking all over /proc and /sys for it.  :)  _SC_PAGESIZE 
is a part of Perl's POSIX module.  Thanks Roland and Jan.

    - Scott
