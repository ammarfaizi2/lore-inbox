Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932526AbVKWJr0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932526AbVKWJr0 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 23 Nov 2005 04:47:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932528AbVKWJrZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 23 Nov 2005 04:47:25 -0500
Received: from smtp.osdl.org ([65.172.181.4]:48324 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S932526AbVKWJrZ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 23 Nov 2005 04:47:25 -0500
Date: Wed, 23 Nov 2005 01:46:56 -0800
From: Andrew Morton <akpm@osdl.org>
To: Alexander Clouter <alex@digriz.org.uk>
Cc: linux-kernel@vger.kernel.org, blaisorblade@yahoo.it,
       davej@codemonkey.org.uk, davej@redhat.com
Subject: Re: [patch 1/1] cpufreq_conservative/ondemand: invert meaning of
 'ignore nice'
Message-Id: <20051123014656.4fd13287.akpm@osdl.org>
In-Reply-To: <20051121181722.GA2599@inskipp.digriz.org.uk>
References: <20051121181722.GA2599@inskipp.digriz.org.uk>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alexander Clouter <alex@digriz.org.uk> wrote:
>
> The use of the 'ignore_nice' sysfs file is confusing to anyone using it. This 
>  removes the sysfs file 'ignore_nice' and in its place creates a 
>  'ignore_nice_load' entry which defaults to '1'; meaning nice'd processes are 
>  not counted towards the 'business' calculation.

drivers/cpufreq/cpufreq_ondemand.c:226: error: 'store_ignore_nice_load' undeclared here (not in a function)

