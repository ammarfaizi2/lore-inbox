Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266587AbTGKDmF (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 10 Jul 2003 23:42:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269771AbTGKDmF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 10 Jul 2003 23:42:05 -0400
Received: from hancock.siteprotect.com ([64.41.120.29]:37514 "EHLO
	hancock.siteprotect.com") by vger.kernel.org with ESMTP
	id S266587AbTGKDmD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 10 Jul 2003 23:42:03 -0400
Date: Thu, 10 Jul 2003 22:56:54 -0500
From: Dee <dfisher@uptimedevices.com>
To: linux-kernel@vger.kernel.org
Subject: Re: 2.4.22-pre3-ac1 write hang
Message-Id: <20030710225654.2f47e7e0.dfisher@uptimedevices.com>
In-Reply-To: <20030710001944.35faa96d.dfisher@uptimedevices.com>
References: <20030710001944.35faa96d.dfisher@uptimedevices.com>
Organization: Uptime Devices
X-Mailer: Sylpheed version 0.8.10claws (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 10 Jul 2003 00:19:44 -0500
Dee <dfisher@uptimedevices.com> wrote:

> 
> 	Hi,
> 
> 	I just got a new Toshiba SPro M15-S405, I have been having
> problems with writes to the disk. 

	I got it stable by switching from ordered data mode to
	journaled mode, it runs very stable now. I have Journal 
	Block Device support turned on, maybe something about
	not using journal data mode with that enabled. Do all new
	ext3 version partitions default to ordered mode ? 
	Happy it works now anyway :)
	
					Dee

