Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265406AbTGCVuB (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 3 Jul 2003 17:50:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265413AbTGCVuA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 3 Jul 2003 17:50:00 -0400
Received: from electric-eye.fr.zoreil.com ([213.41.134.224]:53007 "EHLO
	fr.zoreil.com") by vger.kernel.org with ESMTP id S265406AbTGCVt7
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 3 Jul 2003 17:49:59 -0400
Date: Fri, 4 Jul 2003 00:02:36 +0200
From: Francois Romieu <romieu@fr.zoreil.com>
To: Charles-Edouard Ruault <ce@ruault.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: kernel 2.4.21 , large disk write => system crawls
Message-ID: <20030704000236.A23027@electric-eye.fr.zoreil.com>
References: <3F04A172.5020204@ruault.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <3F04A172.5020204@ruault.com>; from ce@ruault.com on Thu, Jul 03, 2003 at 11:34:42PM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Charles-Edouard Ruault <ce@ruault.com> :
[...]
> when i do a large disk write operation ( copy a big file for example ), 
> the whole system becomes very busy ( system goes into 99% cpu 
> utilization in kernel mode ), other tasks are stopped ( for example 

Please add:
- 'vmstat 1' output before/after/during slowdown;
- dmesg output after boot.

--
Ueimor
