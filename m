Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1423329AbWJZMI3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1423329AbWJZMI3 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 26 Oct 2006 08:08:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1423340AbWJZMI3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 26 Oct 2006 08:08:29 -0400
Received: from mout2.freenet.de ([194.97.50.155]:38096 "EHLO mout2.freenet.de")
	by vger.kernel.org with ESMTP id S1423329AbWJZMI3 convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 26 Oct 2006 08:08:29 -0400
To: gregkh@suse.de
From: balagi@justmail.de
Subject: Re: [PATCH] 2.6.19-rc2-mm2 sysfs: sysfs_write_file() writes zero terminated data
Cc: linux-kernel@vger.kernel.org
X-Priority: 3
X-Abuse: 300631278 / unknown, unknown
User-Agent: freenetMail
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Message-Id: <E1Gd424-00054j-HE@www15.emo.freenet-rz.de>
Date: Thu, 26 Oct 2006 14:08:24 +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

> Yeah, that might happen, but writing to a sysfs file again after the
> first time is not the normal case here.  I'll add your patch to the
> queue to keep this from happening though, good catch.

If the patch is applied, the  get_zeroed_page() call can be replaced
by __get_free_pages() to save some cpu time.

-Thomas









