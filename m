Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263447AbTEVXDt (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 22 May 2003 19:03:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263448AbTEVXDt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 22 May 2003 19:03:49 -0400
Received: from natsmtp01.webmailer.de ([192.67.198.81]:40117 "EHLO
	post.webmailer.de") by vger.kernel.org with ESMTP id S263447AbTEVXDs
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 22 May 2003 19:03:48 -0400
Message-Id: <200305222316.h4MNGk8H004738@post.webmailer.de>
From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: Patch to add SysRq handling to 3270 console
To: Pete Zaitcev <zaitcev@redhat.com>, linux-kernel@vger.kernel.org,
       schwidefsky@de.ibm.com
Date: Fri, 23 May 2003 01:12:20 +0200
References: <20030522225014$1daf@gated-at.bofh.it>
User-Agent: KNode/0.7.2
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7Bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Pete Zaitcev wrote:

> Matin et. al., please consider.
> 
> I am going to look into tub sleeping with spinlocks soonish,
> but please don't hold this patch for that problem.

Martin has started a major rewrite/cleanup of this driver
recently that I believe he wanted to send in one of his next
updates for 2.5.7x. Your patch looks good, but it is probably
duplicated work. Do you have a tested backport for 2.4.2x? If
so, we could merge it for the z990 code drop.

Martin, is the new driver in a state that you can send Pete
for reference?

        Arnd <><
