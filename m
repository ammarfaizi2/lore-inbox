Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267639AbTA3V2l>; Thu, 30 Jan 2003 16:28:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267640AbTA3V2l>; Thu, 30 Jan 2003 16:28:41 -0500
Received: from pc2-cwma1-4-cust86.swan.cable.ntl.com ([213.105.254.86]:9097
	"EHLO irongate.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S267639AbTA3V2l>; Thu, 30 Jan 2003 16:28:41 -0500
Subject: Re:  frlock and barrier discussion
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Manfred Spraul <manfred@colorfullife.com>
Cc: Stephen Hemminger <shemminger@osdl.org>, Andrea Arcangeli <andrea@suse.de>,
       Richard Henderson <rth@twiddle.net>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <3E396CF1.5000300@colorfullife.com>
References: <3E396CF1.5000300@colorfullife.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Organization: 
Message-Id: <1043965965.32594.0.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.1 (1.2.1-2) 
Date: 30 Jan 2003 22:32:45 +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2003-01-30 at 18:20, Manfred Spraul wrote:
> If I understand the Intel documentation correctly, then i386 doesn't need them:
> "Writes by a single processor are observed in the same order by all processors"

See the PPro errata. There are some constraints on this in the real
world. You may need locked ops on the ppro and earlier cpus while 
being able to do it the fast way on PII and higher

