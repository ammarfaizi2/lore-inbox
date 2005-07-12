Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261216AbVGLGzi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261216AbVGLGzi (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 12 Jul 2005 02:55:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261222AbVGLGzh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 12 Jul 2005 02:55:37 -0400
Received: from b3162.static.pacific.net.au ([203.143.238.98]:51633 "EHLO
	cunningham.myip.net.au") by vger.kernel.org with ESMTP
	id S261216AbVGLGzf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 12 Jul 2005 02:55:35 -0400
Subject: Re: [0/48] Suspend2 2.1.9.8 for 2.6.12
From: Nigel Cunningham <ncunningham@cyclades.com>
Reply-To: ncunningham@cyclades.com
To: Andrew Morton <akpm@osdl.org>
Cc: hch@infradead.org,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <20050711234121.25d8e2f8.akpm@osdl.org>
References: <11206164393426@foobar.com> <20050710230645.GD513@infradead.org>
	 <1121150172.13869.17.camel@localhost>
	 <20050711234121.25d8e2f8.akpm@osdl.org>
Content-Type: text/plain
Organization: Cycades
Message-Id: <1121151439.13869.37.camel@localhost>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6-1mdk 
Date: Tue, 12 Jul 2005 16:57:20 +1000
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi.

On Tue, 2005-07-12 at 16:41, Andrew Morton wrote:
> Nigel Cunningham <ncunningham@cyclades.com> wrote:
> >
> > First I'll act on feedback from this round. Regarding diffing against
> >  -mm, I though Andrew wanted patches against Linus' tree. I'm happy to do
> >  both. Andrew?
> 
> Is it anywhere near being ready?

Yes. Development has almost stopped. I'm just addressing the responses
from last week's email and then will send again, so yes. Here's my todo
list (some done already):

Todo list as at 12 July 2005.

FIX.
- Check for redundant variables & functions and remove.
- Ensure driver model calls are right (Bug 45).
- NFS issue (Bug 52)

COMPLETE.
- Opteron support (Bug 1).
- Documentation cleanups.

IMPLEMENT.
- 64GB support.
- IA64 support.
- Implement remembering compression ratio acheived using another method
apart
  from LZF plugin.

HCH/Pavel Replies.
- Setting NoSave pages early.
- Amount needed parameter.
- Add underscores to variable names.
- Inline functions for image preparation (storage needed etc).
- Debugging code from extents.
- extenchain -> extent_chain

- Patch descriptions/rationales.
- Against mm.
- Remove #define XXX_C

> Am still futzing with the ongoing pm_message_t saga here.  I hope there's
> no overlap with that.

We've been using pm_message_t in Suspend2 since February, so we should
already be where you're heading.

Regards,

Nigel
-- 
Evolution.
Enumerate the requirements.
Consider the interdependencies.
Calculate the probabilities.
Be amazed that people believe it happened. 

