Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261201AbTD1Qpo (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 28 Apr 2003 12:45:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261202AbTD1Qpo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 28 Apr 2003 12:45:44 -0400
Received: from imap.gmx.net ([213.165.64.20]:36999 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S261201AbTD1Qpn (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 28 Apr 2003 12:45:43 -0400
Message-ID: <3EAD5D90.7010101@gmx.net>
Date: Mon, 28 Apr 2003 18:57:52 +0200
From: Carl-Daniel Hailfinger <c-d.hailfinger.kernel.2003@gmx.net>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.2) Gecko/20021126
X-Accept-Language: de, en
MIME-Version: 1.0
To: Dave Hansen <haveblue@us.ibm.com>
CC: Andi Kleen <ak@suse.de>, Henti Smith <bain@tcsn.co.za>,
       linux-kernel@vger.kernel.org, lse-tech@lists.sourceforge.net,
       Riley Williams <Riley@Williams.Name>
Subject: Re: [Lse-tech] Re: maximum possible memory limit ..
References: <20030424200524.5030a86b.bain@tcsn.co.za> <3EAD27B2.9010807@gmx.net> <20030428141023.GC4525@Wotan.suse.de> <3EAD5AC1.7090003@us.ibm.com>
In-Reply-To: <3EAD5AC1.7090003@us.ibm.com>
X-Enigmail-Version: 0.71.0.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dave Hansen wrote:
> Andi Kleen wrote:
> 
>>Realistic limit currently is ~16GB with an IA32 box.  For more you need
>>an 64bit architecture.
> 
> 
> Let's say 32GB :)  It boots just fine with 2.5.68, no additional
> patches.  There's even half a gig of lowmem free.

Cool. Sorry to be pestering about the 64-bit limits, but can we really
use 2^64 bytes of memory on ia64/ppc64/x86-64 etc.? (AFAIK, 64-bit
arches don't suffer from a small ZONE_LOWMEM.)

Regards,
Carl-Daniel
-- 
http://www.hailfinger.org/

