Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261714AbULJHHZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261714AbULJHHZ (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 10 Dec 2004 02:07:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261718AbULJHHZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 10 Dec 2004 02:07:25 -0500
Received: from linux01.gwdg.de ([134.76.13.21]:49895 "EHLO linux01.gwdg.de")
	by vger.kernel.org with ESMTP id S261714AbULJHHW (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 10 Dec 2004 02:07:22 -0500
Date: Fri, 10 Dec 2004 08:07:20 +0100 (MET)
From: Jan Engelhardt <jengelh@linux01.gwdg.de>
cc: linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH] debugfs - yet another in-kernel file system
In-Reply-To: <20041210005055.GA17822@kroah.com>
Message-ID: <Pine.LNX.4.53.0412100805440.8273@yvahk01.tjqt.qr>
References: <20041210005055.GA17822@kroah.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
To: unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>What if there was a in-kernel filesystem that was explicitly just for
>putting debugging stuff?  Some place other than proc and sysfs, and that
>was easier than both of them to use.  Yet it needed to also be able to
>handle complex stuff like seq file and raw file_ops if needed.

As for modules, they could just wrap a variable in a module_param, don't they?

I have to admit that adding another filesystem that is very like procfs or
sysfs make some kind of redundancy.


Jan Engelhardt
-- 
ENOSPC
