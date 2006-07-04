Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751095AbWGDHF6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751095AbWGDHF6 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 4 Jul 2006 03:05:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751107AbWGDHF6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 4 Jul 2006 03:05:58 -0400
Received: from smtp.osdl.org ([65.172.181.4]:17598 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751095AbWGDHF6 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 4 Jul 2006 03:05:58 -0400
Date: Tue, 4 Jul 2006 00:05:51 -0700
From: Andrew Morton <akpm@osdl.org>
To: Randy Dunlap <randy.dunlap@oracle.com>
Cc: linux-kernel@vger.kernel.org, James@superbug.demon.co.uk,
       Daniel T Chen <crimsun@ubuntu.com>, Ben Collins <bcollins@ubuntu.com>
Subject: Re: [Ubuntu PATCH] FIx no mpu401 interface can cause hard freeze
Message-Id: <20060704000551.be489377.akpm@osdl.org>
In-Reply-To: <44A98261.1000300@oracle.com>
References: <44A98261.1000300@oracle.com>
X-Mailer: Sylpheed version 2.2.4 (GTK+ 2.8.17; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 03 Jul 2006 13:47:29 -0700
Randy Dunlap <randy.dunlap@oracle.com> wrote:

> This patch fixes the remaining instances in our tree where a non-
> existent mpu401 interface can cause a hard freeze when i/o is issued.
> 
> This commit closes Malone #34831.
> 
> Bug: https://launchpad.net/distros/ubuntu/+source/linux-source-2.6.15/+bug/34831
> 
> patch location:
> http://www.kernel.org/git/?p=linux/kernel/git/bcollins/ubuntu-dapper.git;a=commitdiff;h=b422309cdd980cfefe99379796c04e961d3c1544

Do we know who wrote this patch?
