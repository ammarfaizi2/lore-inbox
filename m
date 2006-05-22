Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932604AbWEVIFu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932604AbWEVIFu (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 22 May 2006 04:05:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751562AbWEVIFu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 22 May 2006 04:05:50 -0400
Received: from smtp.osdl.org ([65.172.181.4]:36532 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751241AbWEVIFt (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 22 May 2006 04:05:49 -0400
Date: Mon, 22 May 2006 01:04:14 -0700
From: Andrew Morton <akpm@osdl.org>
To: Sam Vilain <sam@vilain.net>
Cc: linux-kernel@vger.kernel.org, dev@sw.ru, herbert@13thfloor.at,
       devel@openvz.org, sam@vilain.net, ebiederm@xmission.com, xemul@sw.ru,
       haveblue@us.ibm.com, clg@fr.ibm.com, serue@us.ibm.com
Subject: Re: [PATCH] namespaces: uts_ns: make information visible via
 /proc/PID/uts directory
Message-Id: <20060522010414.6dfb4f71.akpm@osdl.org>
In-Reply-To: <20060522052425.27715.94562.stgit@localhost.localdomain>
References: <20060522052425.27715.94562.stgit@localhost.localdomain>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Sam Vilain <sam@vilain.net> wrote:
>
> Export the UTS information to a per-process directory /proc/PID/uts,
>  that has individual nodes for hostname, ostype, etc - similar to
>  those in /proc/sys/kernel

umm, why?

>  This duplicates the approach used for /proc/PID/attr, which involves a
>  lot of duplication of similar functions.  Much room for maintenance
>  optimisation of both implementations remains.
> 
> ...
>
>   fs/proc/base.c |  236 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++

ouch.
