Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264023AbTFZWLx (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 26 Jun 2003 18:11:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264025AbTFZWLx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 26 Jun 2003 18:11:53 -0400
Received: from intranet.resilience.com ([12.36.124.2]:20403 "EHLO
	intranet.resilience.com") by vger.kernel.org with ESMTP
	id S264023AbTFZWLu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 26 Jun 2003 18:11:50 -0400
Mime-Version: 1.0
Message-Id: <p05210614bb2123032570@[207.213.214.37]>
In-Reply-To: <20030626212102.GA19056@work.bitmover.com>
References: <20030621135812.GE14404@work.bitmover.com>
 <20030621190944.GA13396@work.bitmover.com>
 <20030622002614.GA16225@work.bitmover.com>
 <20030623053713.GA6715@work.bitmover.com>
 <20030625013302.GB2525@work.bitmover.com> <20030626231752.E5633@ucw.cz>
 <20030626212102.GA19056@work.bitmover.com>
Date: Thu, 26 Jun 2003 15:25:59 -0700
To: Larry McVoy <lm@bitmover.com>, Vojtech Pavlik <vojtech@suse.cz>
From: Jonathan Lundell <linux@lundell-bros.com>
Subject: Re: bkbits.net is down
Cc: Larry McVoy <lm@bitmover.com>, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="us-ascii" ; format="flowed"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

At 2:21pm -0700 6/26/03, Larry McVoy wrote:
>  > Eek. Serverworks IDE. I don't think they ever got that bit of their
>>  chipset right.
>
>Hmm.  I could shove in a promise card and put at least the repos on that,
>would that be better?

We routinely disable DMA for ServerWorks+IDE systems. Fortunately our 
application doesn't care about disk performance. The symptom is that 
a word or so of data gets inserted into a sector (or dropped; I 
disremember right now).

A Promise card might be a good idea, though someone else will have to 
vouch for it.
-- 
/Jonathan Lundell.
