Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263765AbUDZJNv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263765AbUDZJNv (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 26 Apr 2004 05:13:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264442AbUDZJNv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 26 Apr 2004 05:13:51 -0400
Received: from jurassic.park.msu.ru ([195.208.223.243]:8578 "EHLO
	jurassic.park.msu.ru") by vger.kernel.org with ESMTP
	id S263765AbUDZJNu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 26 Apr 2004 05:13:50 -0400
Date: Mon, 26 Apr 2004 13:13:19 +0400
From: Ivan Kokshaysky <ink@jurassic.park.msu.ru>
To: Dru <andru@treshna.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: PROBLEM: Kernel lockup on alpha with heavy IO
Message-ID: <20040426131319.A9952@jurassic.park.msu.ru>
References: <408C75E4.50908@treshna.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <408C75E4.50908@treshna.com>; from andru@treshna.com on Mon, Apr 26, 2004 at 02:37:24PM +1200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 26, 2004 at 02:37:24PM +1200, Dru wrote:
> cpu                     : Alpha
> cpu model               : SimulateLCA4

First of all, update the firmware. Apparently, this SRM version
not only misdetects the cpu model, but also has serious problems
with cache setup leading to data corruption.
Updated image can be found at
ftp://ftp.harddata.com/pub/kernel_Nautilus/srm/

Ivan.
