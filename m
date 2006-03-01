Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932434AbWCAHSK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932434AbWCAHSK (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Mar 2006 02:18:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932598AbWCAHSK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Mar 2006 02:18:10 -0500
Received: from smtp.osdl.org ([65.172.181.4]:14004 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S932434AbWCAHSJ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Mar 2006 02:18:09 -0500
Date: Tue, 28 Feb 2006 23:16:46 -0800
From: Andrew Morton <akpm@osdl.org>
To: Thomas Meyer <thomas@m3y3r.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] cpufreq: fix powernow-k7 smp kernel driver on up
 machines
Message-Id: <20060228231646.1dc4105c.akpm@osdl.org>
In-Reply-To: <1141073259.9881.1.camel@hotzenplotz.treehouse>
References: <1141073259.9881.1.camel@hotzenplotz.treehouse>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Thomas Meyer <thomas@m3y3r.de> wrote:
>
> This patch fixes the powernow-k7 cpufreq driver smp kernel on an up
>  machine.

- It was wordwrapped.

- Your description doesn't describe what is being fixed, nor how it was fixed.

- That open-coded assembly-language divide should probably be converted
  to div64().  If that's not possible we'd need to see a description of
  why.

- Please cc cpufreq@www.linux.org.uk on the next submission.
