Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262108AbTE2KVV (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 29 May 2003 06:21:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262114AbTE2KVV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 29 May 2003 06:21:21 -0400
Received: from holomorphy.com ([66.224.33.161]:57222 "EHLO holomorphy")
	by vger.kernel.org with ESMTP id S262108AbTE2KVU (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 29 May 2003 06:21:20 -0400
Date: Thu, 29 May 2003 03:34:14 -0700
From: William Lee Irwin III <wli@holomorphy.com>
To: Arvind Kandhare <arvind.kan@wipro.com>
Cc: Manfred Spraul <manfred@colorfullife.com>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       "indou.takao" <indou.takao@jp.fujitsu.com>, rml <rml@tech9.net>,
       Dave Jones <davej@suse.de>, roystgnr@owlnet.rice.edu,
       garagan@borg.cs.dal.ca
Subject: Re: Changing SEMVMX to a tunable parameter
Message-ID: <20030529103414.GY8978@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	Arvind Kandhare <arvind.kan@wipro.com>,
	Manfred Spraul <manfred@colorfullife.com>,
	linux-kernel <linux-kernel@vger.kernel.org>,
	"indou.takao" <indou.takao@jp.fujitsu.com>, rml <rml@tech9.net>,
	Dave Jones <davej@suse.de>, roystgnr@owlnet.rice.edu,
	garagan@borg.cs.dal.ca
References: <3ED4C6B6.7050806@wipro.com> <3ED4E0BB.2080603@colorfullife.com> <3ED5DE49.5CA79049@wipro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3ED5DE49.5CA79049@wipro.com>
Organization: The Domain of Holomorphy
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 29, 2003 at 03:47:45PM +0530, Arvind Kandhare wrote:
> 1. Most of the IPC parameters (e.g. msgmni, msgmax, 
> msgmnb , shmmni, shmmax) are tunables. 
> (Please refer : 
> http://web.gnu.walfield.org/mail-archive/linux-kernel-digest/1999-November/0020.html)
> Was there any specific reason why semvmx was not made a tunable with the 
> above set??  
> 2. By having semvmx as tunable, administrator gets more flexibility 
> in controlling the resource usage on the system:
>         a. By increasing this, it is possible to allow more     
>         processes to use the system resources controlled by a
>         semaphore concurrently.
>         b. By decreasing this, the number of processes
>         using the system resources controlled by a semaphore
>         concurrently can be limited.

Why not just implement it and let us take a look at it? It shouldn't be
that far out. Nothing wrong with fully dynamic tuning in principle,
though this stuff is pretty obscure. Just hammer it out and we'll see how
it looks.

-- wli
