Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263847AbUFBTUr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263847AbUFBTUr (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 2 Jun 2004 15:20:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263864AbUFBTUr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 2 Jun 2004 15:20:47 -0400
Received: from colin2.muc.de ([193.149.48.15]:23315 "HELO colin2.muc.de")
	by vger.kernel.org with SMTP id S263847AbUFBTUq (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 2 Jun 2004 15:20:46 -0400
Date: 2 Jun 2004 21:20:45 +0200
Date: Wed, 2 Jun 2004 21:20:45 +0200
From: Andi Kleen <ak@muc.de>
To: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] 3/5: Device-mapper: snapshots
Message-ID: <20040602192045.GA87771@colin2.muc.de>
References: <22Gkd-1AX-17@gated-at.bofh.it> <m3r7sx6dip.fsf@averell.firstfloor.org> <20040602185924.GS6302@agk.surrey.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040602185924.GS6302@agk.surrey.redhat.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > Is this target supposed to be crash safe? What happens when
> > the computer crashes while writing to such a volume?
>  
> The intention is for snapshot & origin still to be consistent with each other
> on disk.  (No barriers yet, but some synchronous writes.)

So it's supposed to be crash safe? 

How about documenting this somewhere in the source?

-Andi
