Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261196AbVEZE32@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261196AbVEZE32 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 26 May 2005 00:29:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261198AbVEZE32
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 26 May 2005 00:29:28 -0400
Received: from mail.dvmed.net ([216.237.124.58]:61143 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S261195AbVEZE3U (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 26 May 2005 00:29:20 -0400
Message-ID: <42955099.1020808@pobox.com>
Date: Thu, 26 May 2005 00:29:13 -0400
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.6) Gecko/20050328 Fedora/1.7.6-1.2.5
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Tyler Eaves <tyler@cg2.org>
CC: linux-kernel@vger.kernel.org
Subject: Re: IDE DMA with SATA, 2.6 kernels
References: <1117080313.4446.12.camel@localhost.localdomain>
In-Reply-To: <1117080313.4446.12.camel@localhost.localdomain>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Score: 0.0 (/)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Tyler Eaves wrote:
> However, it appears that the generic IDE driver grabs the IDE drives
> before the Via driver can get them. This prevents me from using DMA on
> those drivers, so, for instance, ripping CDs is really painful. I can
> rip at about 2x on a good day, versus 40x+ ripping in Exact Audio Copy
> under XP.

Disable CONFIG_IDE_GENERIC and CONFIG_BLK_DEV_GENERIC in .config ?

	Jeff


