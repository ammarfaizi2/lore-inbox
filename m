Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964900AbVHaR15@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964900AbVHaR15 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 31 Aug 2005 13:27:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964899AbVHaR15
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 31 Aug 2005 13:27:57 -0400
Received: from a.mail.sonic.net ([64.142.16.245]:16093 "EHLO a.mail.sonic.net")
	by vger.kernel.org with ESMTP id S964898AbVHaR14 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 31 Aug 2005 13:27:56 -0400
Date: Wed, 31 Aug 2005 10:28:39 -0700
From: Jim McCloskey <mcclosk@ucsc.edu>
To: Paulo Marques <pmarques@grupopie.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: PROBLEM: 2.6.13, Inconsistent kallsyms data
Message-ID: <20050831172839.GA3694@branci40>
References: <20050829235809.GA19979@branci40> <4315C079.7000008@grupopie.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4315C079.7000008@grupopie.com>
X-Operating-System: Debian GNU/Linux/2.6.13 (i686)
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* Paulo Marques (pmarques@grupopie.com) wrote:

  |>  Jim McCloskey wrote:
  |>  >When I try to compile 2.6.13, using a complete tarball from
  |>  >kernel.org, the compilation fails with:
  |>  >
  |>  >-----------------------------------------------------------
  |>  >  SYSMAP  System.map
  |>  >  SYSMAP  .tmp_System.map
  |>  >Inconsistent kallsyms data
  |>  >Try setting CONFIG_KALLSYMS_EXTRA_PASS
  |>  >make: *** [vmlinux] Error 1
  |>  >-----------------------------------------------------------
  |>  >
  |>  >When CONFIG_KALLSYMS_EXTRA_PASS is set, the compilation completes
  |>  >successfully.
  |>  
  |>  Please try the attached patch too see if it fixes the problem for you.
  |>  
  |>  This patch is already in -mm and scheduled to go in 2.6.14 (or at least 
  |>  I hope it is ;)

Yes indeed. With the patch applied, compilation completes without a
problem. Thank you!

Jim
