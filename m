Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S272332AbRHXVRI>; Fri, 24 Aug 2001 17:17:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S272333AbRHXVQ6>; Fri, 24 Aug 2001 17:16:58 -0400
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:63749 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S272332AbRHXVQv>; Fri, 24 Aug 2001 17:16:51 -0400
Subject: Re: Is it bad to have lots of sleeping tasks?
To: garloff@suse.de (Kurt Garloff)
Date: Fri, 24 Aug 2001 22:19:54 +0100 (BST)
Cc: hzhong@cisco.com (Hua Zhong), ddade@digitalstatecraft.com,
        alan@lxorguk.ukuu.org.uk (Alan Cox), linux-kernel@vger.kernel.org
In-Reply-To: <20010824223218.N8355@gum01m.etpnet.phys.tue.nl> from "Kurt Garloff" at Aug 24, 2001 10:32:18 PM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E15aOMs-0006Z9-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > scheduler with 100 lines of patch, and that fitted in the existing Linux
> > runqueue framework).  What's the resistence to scheduler changes?
> 
> Expect Larry to jump on you.

If you can implement an O(1) scheduler that is faster than Linus scheduler
for the normal case and for scalable cases I expect Larry would probably
jump up and down happily instead.

The current scheduler does make some very bad decisions
