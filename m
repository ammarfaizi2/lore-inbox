Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265236AbUELVgM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265236AbUELVgM (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 12 May 2004 17:36:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265233AbUELVgE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 12 May 2004 17:36:04 -0400
Received: from d61.wireless.hilander.com ([216.241.32.61]:8583 "EHLO
	ramirez.hilander.com") by vger.kernel.org with ESMTP
	id S265226AbUELVfk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 12 May 2004 17:35:40 -0400
Date: Wed, 12 May 2004 15:35:36 -0600
From: "Alec H. Peterson" <ahp@hilander.com>
To: Manfred Spraul <manfred@colorfullife.com>
cc: linux-kernel@vger.kernel.org, Dominik Brodowski <linux@brodo.de>,
       netdev@oss.sgi.com
Subject: Re: PCI memory reservation failure - 2.4/2.6
Message-ID: <9C9F57570B19C8A682D96940@[192.168.0.100]>
In-Reply-To: <40A29211.2010707@colorfullife.com>
References: <BDD74A21E0B47FEAC3AB8A10@[192.168.0.100]>
 <40A29211.2010707@colorfullife.com>
X-Mailer: Mulberry/3.1.3 (Mac OS X)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
X-Spam-Score: 0.0 (/)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--On Wednesday, May 12, 2004 11:07 PM +0200 Manfred Spraul 
<manfred@colorfullife.com> wrote:

>
> I'm not sure if this is the right approach - what if a bios intentionally
> assigns a small area? It's dangerous to override the BIOS setting.
> I'd prefer a kernel command line parameter / module parameter / dmi based
> override instead of an unconditional override based on the minimum size.
> I'll think about it.

A module parameter sounds like a grand idea.  I'd be happy to take a stab 
at it if others feel it is the way to go.

Alec

