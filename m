Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281370AbRKLJzN>; Mon, 12 Nov 2001 04:55:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281371AbRKLJzD>; Mon, 12 Nov 2001 04:55:03 -0500
Received: from wallext.webflex.nl ([212.115.150.250]:29369 "EHLO
	palm.webflex.nl") by vger.kernel.org with ESMTP id <S281370AbRKLJyy>;
	Mon, 12 Nov 2001 04:54:54 -0500
Message-ID: <XFMail.20011112105421.mathijs@knoware.nl>
X-Mailer: XFMail 1.5.1 on Linux
X-Priority: 3 (Normal)
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
In-Reply-To: <87d72ojphq.fsf@fadata.bg>
Date: Mon, 12 Nov 2001 10:54:21 +0100 (CET)
From: Mathijs Mohlmann <mathijs@knoware.nl>
To: Momchil Velikov <velco@fadata.bg>
Subject: Re: [PATCH] fix loop with disabled tasklets
Cc: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On 12-Nov-2001 Momchil Velikov wrote:
> Hmm, if it isn't scheduled, there is not much sense in disabling it at
> all.
DECLARE_TASKLET_DISABLED
tasklet_enable
 
> Hmm, if TASKLET_STATE_SCHED is not set tasklet_kill will not deadlock.
> And tasklet_kill yields (?). Doesn't that mean that tasklet_action
> will be called eventually ?

oops, i misread tasklet_unlock_wait. So sorry.

        me


-- 
        me
