Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932228AbVL3UHl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932228AbVL3UHl (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 30 Dec 2005 15:07:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932268AbVL3UHk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 30 Dec 2005 15:07:40 -0500
Received: from [212.76.84.174] ([212.76.84.174]:25094 "EHLO raad.intranet")
	by vger.kernel.org with ESMTP id S932228AbVL3UHk (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 30 Dec 2005 15:07:40 -0500
From: Al Boldi <a1426z@gawab.com>
To: barryn@pobox.com
Subject: Re: [PATCH] strict VM overcommit accounting for 2.4.32/2.4.33-pre1
Date: Fri, 30 Dec 2005 23:06:28 +0300
User-Agent: KMail/1.5
Cc: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200512302306.28667.a1426z@gawab.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 29, 2005 at 11:44:01PM -0800, Barry K. Nathan wrote:
> This patch adds strict VM overcommit accounting to the mainline 2.4
> kernel, thus allowing overcommit to be truly disabled. This feature
> has been in 2.4-ac, Red Hat Enterprise Linux 3 (RHEL 3) vendor kernels,
> and 2.6 for a long while.

Thanks a lot!

> +3 - (NEW) paranoid overcommit The total address space commit
> +      for the system is not permitted to exceed swap. The machine
> +      will never kill a process accessing pages it has mapped
> +      except due to a bug (ie report it!)

This one isn't in 2.6, which is critical for a stable system.

Thanks!

--
Al

