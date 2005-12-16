Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932075AbVLPHyH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932075AbVLPHyH (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 16 Dec 2005 02:54:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932169AbVLPHyH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 16 Dec 2005 02:54:07 -0500
Received: from smtpout.mac.com ([17.250.248.83]:14547 "EHLO smtpout.mac.com")
	by vger.kernel.org with ESMTP id S932075AbVLPHyG (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 16 Dec 2005 02:54:06 -0500
In-Reply-To: <20051216061605.46520.qmail@web50211.mail.yahoo.com>
References: <20051216061605.46520.qmail@web50211.mail.yahoo.com>
Mime-Version: 1.0 (Apple Message framework v746.2)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <0FBF6CD3-9E95-4A1B-8886-7DD0853679DC@mac.com>
Cc: Dave Jones <davej@redhat.com>, linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 7bit
From: Kyle Moffett <mrmacman_g4@mac.com>
Subject: Re: [2.6 patch] i386: always use 4k stacks
Date: Fri, 16 Dec 2005 02:53:56 -0500
To: Alex Davis <alex14641@yahoo.com>
X-Mailer: Apple Mail (2.746.2)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Dec 16, 2005, at 01:16, Alex Davis wrote:
> [flamewar]

Enough already!  These concerns have been raised already, and found  
to be insufficient.  There are several points:

1)	ndiswrapper is broken already, and works sheerly by luck anyways;  
NT stacks are 12kb, so you're already asking for stack overflows by  
using it.
2)	ndiswrapper encourages use of binary drivers instead of the open- 
source ones that need the testers, so you're only hurting yourselves  
in the long run.
3)	All the in-kernel problems have been fixed, and this makes a lot  
of stuff less fragmentation-prone and more reliable.

Does anybody have any _in_kernel_ bugreports which are unaddressed,  
or maybe something out-of-kernel that is not handled by the above  
points?

Cheers,
Kyle Moffett

--
There is no way to make Linux robust with unreliable memory  
subsystems, sorry.  It would be like trying to make a human more  
robust with an unreliable O2 supply. Memory just has to work.
   -- Andi Kleen


