Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264828AbTE1SmF (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 28 May 2003 14:42:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264827AbTE1SmF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 28 May 2003 14:42:05 -0400
Received: from amsfep12-int.chello.nl ([213.46.243.18]:10333 "EHLO
	amsfep12-int.chello.nl") by vger.kernel.org with ESMTP
	id S264828AbTE1SmE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 28 May 2003 14:42:04 -0400
Message-ID: <3ED50612.40507@users.sf.net>
Date: Wed, 28 May 2003 20:55:14 +0200
From: Thomas Tonino <ttonino@users.sf.net>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.3.1) Gecko/20030428
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: 2.4.20: Proccess stuck in __lock_page ...
References: <20030527035006$5339@gated-at.bofh.it> <20030527175008$3573@gated-at.bofh.it> <20030527180016$418c@gated-at.bofh.it> <20030527182011$4acb@gated-at.bofh.it> <20030528094008$1500@gated-at.bofh.it> <20030528095014$7b21@gated-at.bofh.it>
In-Reply-To: <20030528095014$7b21@gated-at.bofh.it>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jens Axboe wrote:

> Lemme guess, hard drive on the same channel as the burner? There's
> nothing we can do about that, hardware limitation.

hmmm... most drives these days have a command to read free buffer capacity, so 
there is no need to send more than the drive can swallow - and no need to tie up 
the channel.

> The reason you see it
> during fixation is because that's one long single command, and we cannot
> preempt the channel and service requests while that is going on.

But this may be the exception that breaks the rule. Bah.


Thomas

