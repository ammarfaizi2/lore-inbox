Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S271765AbRICSi3>; Mon, 3 Sep 2001 14:38:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S271767AbRICSiT>; Mon, 3 Sep 2001 14:38:19 -0400
Received: from ns.caldera.de ([212.34.180.1]:4265 "EHLO ns.caldera.de")
	by vger.kernel.org with ESMTP id <S271765AbRICSiN>;
	Mon, 3 Sep 2001 14:38:13 -0400
Date: Mon, 3 Sep 2001 20:38:21 +0200
From: Christoph Hellwig <hch@caldera.de>
To: Arjan van de Ven <arjanv@redhat.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] cleanup gendisk handling
Message-ID: <20010903203821.A305@caldera.de>
Mail-Followup-To: Christoph Hellwig <hch@caldera.de>,
	Arjan van de Ven <arjanv@redhat.com>, linux-kernel@vger.kernel.org
In-Reply-To: <20010903200504.A30093@caldera.de> <3B93CD9D.35ED4F1C@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <3B93CD9D.35ED4F1C@redhat.com>; from arjanv@redhat.com on Mon, Sep 03, 2001 at 02:36:13PM -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 03, 2001 at 02:36:13PM -0400, Arjan van de Ven wrote:
> Hi,
> 
> I had a patch similar to this one a while ago (and it got dropped); One
> difference is that your patch doesn't 
> seem to lock the linked list... so the operation is SMP unsafe (it was
> before, but fixing that would be a 
> good sideeffect of this patch)

I will do this once (if) this patch is in.
I'd rather avoid pushing too many changes in one diff.

	Christoph

-- 
Of course it doesn't work. We've performed a software upgrade.
