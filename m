Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964929AbWDGWBU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964929AbWDGWBU (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 7 Apr 2006 18:01:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964946AbWDGWBT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 7 Apr 2006 18:01:19 -0400
Received: from smtp.osdl.org ([65.172.181.4]:41404 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S964929AbWDGWBT (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 7 Apr 2006 18:01:19 -0400
Date: Fri, 7 Apr 2006 15:03:37 -0700
From: Andrew Morton <akpm@osdl.org>
To: Hirokazu Takata <takata@linux-m32r.org>
Cc: linux-kernel@vger.kernel.org, fujiwara@linux-m32r.org,
       takata@linux-m32r.org
Subject: Re: [PATCH 2.6.17-rc1-mm1] m32r: Fix cpu_possible_map and
 cpu_present_map initialization for SMP kernel
Message-Id: <20060407150337.7cc0c462.akpm@osdl.org>
In-Reply-To: <20060407.194745.233672521.takata.hirokazu@renesas.com>
References: <20060407.194745.233672521.takata.hirokazu@renesas.com>
X-Mailer: Sylpheed version 1.0.0 (GTK+ 1.2.10; i386-vine-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hirokazu Takata <takata@linux-m32r.org> wrote:
>
> This patch fixes a boot problem of the m32r SMP kernel
> 2.6.16-rc1-mm3 or later.

This sounds like something which needs to be backported into 2.6.16.x,
correct?

Also, should "m32r: security fix of {get,put}_user macros" go into 2.6.16.x?
