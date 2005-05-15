Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261346AbVEOXBI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261346AbVEOXBI (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 15 May 2005 19:01:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261331AbVEOXBI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 15 May 2005 19:01:08 -0400
Received: from mail.dvmed.net ([216.237.124.58]:4505 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S261329AbVEOXBG (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 15 May 2005 19:01:06 -0400
Message-ID: <4287D4AD.7020104@pobox.com>
Date: Sun, 15 May 2005 19:01:01 -0400
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.6) Gecko/20050328 Fedora/1.7.6-1.2.5
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Brett Russ <russb@emc.com>
CC: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH libata-2.6] libata: flush COMRESET set and clear
References: <20050325231907.E1D11BADC@lns1032.lss.emc.com> <20050328201027.3A50529917@lns1032.lss.emc.com>
In-Reply-To: <20050328201027.3A50529917@lns1032.lss.emc.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Score: 0.0 (/)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Brett Russ wrote:
> Updated patch to fix erroneous flush of COMRESET set and missing flush
> of COMRESET clear.  Created a new routine scr_write_flush() to try to
> prevent this in the future.  Also, this patch is based on libata-2.6
> instead of the previous libata-dev-2.6 based patch.
> 
> Signed-off-by: Brett Russ <russb@emc.com>

applied


