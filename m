Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261404AbTDXGmj (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 24 Apr 2003 02:42:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261706AbTDXGmj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 24 Apr 2003 02:42:39 -0400
Received: from wohnheim.fh-wedel.de ([195.37.86.122]:21466 "EHLO
	wohnheim.fh-wedel.de") by vger.kernel.org with ESMTP
	id S261404AbTDXGmi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 24 Apr 2003 02:42:38 -0400
Date: Thu, 24 Apr 2003 08:54:01 +0200
From: =?iso-8859-1?Q?J=F6rn?= Engel <joern@wohnheim.fh-wedel.de>
To: David Ford <david+cert@blue-labs.org>
Cc: Pavel Machek <pavel@ucw.cz>, "Grover, Andrew" <andrew.grover@intel.com>,
       "Martin J. Bligh" <mbligh@aracnet.com>,
       Nigel Cunningham <ncunningham@clear.net.nz>,
       Marc Giger <gigerstyle@gmx.ch>,
       Geert Uytterhoeven <geert@linux-m68k.org>,
       Linux Kernel Development <linux-kernel@vger.kernel.org>
Subject: Re: Fix SWSUSP & !SWAP
Message-ID: <20030424065401.GA1762@wohnheim.fh-wedel.de>
References: <F760B14C9561B941B89469F59BA3A847E96E0E@orsmsx401.jf.intel.com> <20030424000344.GC32577@atrey.karlin.mff.cuni.cz> <3EA75EDD.20605@blue-labs.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <3EA75EDD.20605@blue-labs.org>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 23 April 2003 23:49:49 -0400, David Ford wrote:
> 
> I honestly don't see OOMing as an acceptable practice.  If I wanted to 
> kill a bunch of stuff just to suspend, I would have simply shut the 
> system down.  That isn't my intent or desire.  I want to suspend the 
> system just as it is without OOMing a bunch of programs.

Seconded.

Joe user would see the OOM either way, sooner with a seperate suspend
partition, which would be missing as swap. But he would be seeing it
at the moment he caused it.  With suspend to swap, the OOM happens
during suspend, every time. So who is to blame?

Jörn

-- 
The cost of changing business rules is much more expensive for software
than for a secretaty.
-- unknown
