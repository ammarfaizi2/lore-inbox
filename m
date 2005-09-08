Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964919AbVIHSKz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964919AbVIHSKz (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 8 Sep 2005 14:10:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964921AbVIHSKz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 8 Sep 2005 14:10:55 -0400
Received: from smtp.osdl.org ([65.172.181.4]:33497 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S964919AbVIHSKy (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 8 Sep 2005 14:10:54 -0400
Date: Thu, 8 Sep 2005 11:10:31 -0700
From: Chris Wright <chrisw@osdl.org>
To: Alexander Nyberg <alexn@telia.com>
Cc: Ludovic Drolez <ludovic.drolez@linbox.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Strange LVM2/DM data corruption with 2.6.11.12
Message-ID: <20050908181031.GC7991@shell0.pdx.osdl.net>
References: <43200B5E.90401@linbox.com> <20050908140235.GB2746@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050908140235.GB2746@localhost.localdomain>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* Alexander Nyberg (alexn@telia.com) wrote:
> Please upgrade to 2.6.12.6 (I don't remember exactly in which
> 2.6.12.x it went in), it contains a bugfix that should fix what
> you are seeing. 2.6.13 also has this.

Yep, that was 2.6.12.4, and here's the patch:

http://www.kernel.org/git/?p=linux/kernel/git/chrisw/stable-queue.git;a=blob_plain;h=6267a6b8da4b52eaf0fbddd9091a6e6ff2fe233c

thanks,
-chris
