Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267421AbTAQHiS>; Fri, 17 Jan 2003 02:38:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267424AbTAQHiS>; Fri, 17 Jan 2003 02:38:18 -0500
Received: from hauptpostamt.charite.de ([193.175.66.220]:27556 "EHLO
	hauptpostamt.charite.de") by vger.kernel.org with ESMTP
	id <S267421AbTAQHiQ>; Fri, 17 Jan 2003 02:38:16 -0500
Date: Fri, 17 Jan 2003 08:47:13 +0100
From: Ralf Hildebrandt <Ralf.Hildebrandt@charite.de>
To: linux-kernel@vger.kernel.org
Subject: Re: 2.4.21-pre3-ac4 oops in free_pages_ok
Message-ID: <20030117074713.GF12788@charite.de>
Mail-Followup-To: linux-kernel@vger.kernel.org
References: <20030116082851.A31643@ns1.theoesters.com> <3E27044C.4010308@tupshin.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3E27044C.4010308@tupshin.com>
User-Agent: Mutt/1.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* Tupshin Harper <tupshin@tupshin.com>:
> There are multiple other threads about this problem recently. One 
> started by me, as well as a few others.
> The consensus is that it's a problem in the ac tree, and is not present 
> in 2.4.21-pre3.

Yep.

> Some people seem to avoid the problem by disabling highmem, but this 
> doesn't work for me. Quota has been mentioned as a possible culprit, but 
> disabling that also doesn't help me. 

Correct. I use neither himem nor quotas, still it crashes.

> The ac changes to mm/shmem.c are 
> still a possibility, though one reporter seems to have tried that 
> without any success.

Yup, I tried that. No go.

> The remaining candidate that has been mentioned to 
> me is the buffer cache changes in the ac tree, this seems moderately 
> likely. I don't see any obvious way to break out those changes from 
> Alan's large ac4 patch, so I emailed him hoping to get a patch free of 
> those changes, but I haven't heard back yet(it's been 9 hours 
> already...how dare he ignore me ;-).

-- 
Ralf Hildebrandt (Im Auftrag des Referat V a)   Ralf.Hildebrandt@charite.de
Charite Campus Mitte                            Tel.  +49 (0)30-450 570-155
Referat V a - Kommunikationsnetze -             Fax.  +49 (0)30-450 570-916
"The report of my death was an exaggeration." 
 -Mark Twain, After reading his own obituary, June 2, 1897

