Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135773AbRDTB1m>; Thu, 19 Apr 2001 21:27:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135774AbRDTB1U>; Thu, 19 Apr 2001 21:27:20 -0400
Received: from panic.ohr.gatech.edu ([130.207.47.194]:16836 "HELO
	havoc.gtf.org") by vger.kernel.org with SMTP id <S135773AbRDTB1L>;
	Thu, 19 Apr 2001 21:27:11 -0400
Message-ID: <3ADF9065.25E4F92C@mandrakesoft.com>
Date: Thu, 19 Apr 2001 21:27:01 -0400
From: Jeff Garzik <jgarzik@mandrakesoft.com>
Organization: MandrakeSoft
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.4-pre4 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Ion Badulescu <ionut@moisil.cs.columbia.edu>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, linux-kernel@vger.kernel.org
Subject: Re: Linux 2.4.3-ac10
In-Reply-To: <200104200050.f3K0oOt01719@moisil.dev.hydraweb.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ion wrote:
> On Thu, 19 Apr 2001 21:14:32 +0100 (BST), Alan Cox <alan@lxorguk.ukuu.org.uk> wrote:
> 
> > 2.4.3-ac10
> > o       Merge Linus 2.4.4pre4
> 
> Well, it seems you have backed out my starfire changes when you merged
> Jeff Garzik's changes from 2.4.4pre4. So here's a new version, diff'ed
> against 2.4.3-ac10, which includes all of Jeff's changes from 2.4.3pre[45].
> 
> BTW Jeff, do you want me to send these updates to you instead of Alan,
> diff'ed against 2.4.x-pre_latest? Right now we're just wasting each
> other's time by making conflicting changes to different trees.

I should have gotten off my butt and mentioned this...  I would prefer a
patch without the 2.2.x compat stuff.  So instead of all that compat
code, have
	#include "starfire-2.2.h"
or similar...

And then starfire-2.2.h would only exist on 2.2.x.

-- 
Jeff Garzik       | "The universe is like a safe to which there is a
Building 1024     |  combination -- but the combination is locked up
MandrakeSoft      |  in the safe."    -- Peter DeVries
