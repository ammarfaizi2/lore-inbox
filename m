Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751469AbWE3M3Q@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751469AbWE3M3Q (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 30 May 2006 08:29:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751472AbWE3M3Q
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 30 May 2006 08:29:16 -0400
Received: from pentafluge.infradead.org ([213.146.154.40]:26833 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S1751469AbWE3M3P (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 30 May 2006 08:29:15 -0400
Subject: Re: Possible MTD bug in 2.6.15
From: David Woodhouse <dwmw2@infradead.org>
To: Jim Ramsay <kernel@jimramsay.com>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <4789af9e0604190949t42677b35mcba4ee57b92ffff9@mail.gmail.com>
References: <4789af9e0604190949t42677b35mcba4ee57b92ffff9@mail.gmail.com>
Content-Type: text/plain
Date: Tue, 30 May 2006 13:30:08 +0100
Message-Id: <1148992208.2885.171.camel@hades.cambridge.redhat.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.1 (2.6.1-1.fc5.2.dwmw2.1) 
Content-Transfer-Encoding: 7bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <dwmw2@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2006-04-19 at 10:49 -0600, Jim Ramsay wrote:
> We have an interesting problem with MTD and a flash chip on an
> embedded board.  The problem stems from the fact that due to hardware
> constraints we can only access up to 32M of address space on an
> attached flash device.  However, the actual part attached to the board
> is 64M.  Yes, I know this is not likely to happen, but it points at a
> kernel bug which will happen if you ever specify a MTD map->size which
> is less than the actual size of the CFI flash chip. 

Please could you confirm this is fixed in the current MTD git tree (and
in the current -mm kernel). 

-- 
dwmw2

