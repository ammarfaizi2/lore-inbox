Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S273355AbTG3T1G (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 30 Jul 2003 15:27:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S273358AbTG3T1G
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 30 Jul 2003 15:27:06 -0400
Received: from lindsey.linux-systeme.com ([80.190.48.67]:1808 "EHLO
	mx00.linux-systeme.com") by vger.kernel.org with ESMTP
	id S273355AbTG3TZh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 30 Jul 2003 15:25:37 -0400
From: Marc-Christian Petersen <m.c.p@wolk-project.de>
Organization: Working Overloaded Linux Kernel
To: Shawn <core@enodev.com>,
       "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: Buffer I/O error on device hde3, logical block 4429
Date: Wed, 30 Jul 2003 21:25:27 +0200
User-Agent: KMail/1.5.2
References: <1059585712.11341.24.camel@localhost> <1059592520.11341.47.camel@localhost>
In-Reply-To: <1059592520.11341.47.camel@localhost>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200307302125.27898.m.c.p@wolk-project.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 30 July 2003 21:15, Shawn wrote:

Hi,

> It appears Mike Galbraith has seen something similar in -vanilla.
> http://www.ussg.iu.edu/hypermail/linux/kernel/0307.3/1987.html
> Does anyone have any interest at all in pursuing this? Hopefully? I'm
> glad to try and be the pig of Guinea. Kill piggy!

> > I am running 2.6.0-test2-mm1, and upon boot have received a gift of many
> > "Buffer I/O error on device hde3" messages in my log. After they quit,
> > they never seem to come back.
hmm, I had the same errors yesterday and the culprit was a "data=writeback" 
for a reiserfs partition. 2.6 don't know about data= for reiserfs.

Could it be your problem too?

ciao, Marc

