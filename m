Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263032AbUEWHlp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263032AbUEWHlp (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 23 May 2004 03:41:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263033AbUEWHlp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 23 May 2004 03:41:45 -0400
Received: from note.orchestra.cse.unsw.EDU.AU ([129.94.242.24]:26021 "EHLO
	note.orchestra.cse.unsw.EDU.AU") by vger.kernel.org with ESMTP
	id S263032AbUEWHll (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 23 May 2004 03:41:41 -0400
From: Neil Brown <neilb@cse.unsw.edu.au>
To: Linus Torvalds <torvalds@osdl.org>
Date: Sun, 23 May 2004 17:41:29 +1000
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16560.21929.91936.379990@cse.unsw.edu.au>
Cc: Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [RFD] Explicitly documenting patch submission
In-Reply-To: message from Linus Torvalds on Saturday May 22
References: <Pine.LNX.4.58.0405222341380.18601@ppc970.osdl.org>
X-Mailer: VM 7.18 under Emacs 21.3.1
X-face: [Gw_3E*Gng}4rRrKRYotwlE?.2|**#s9D<ml'fY1Vw+@XfR[fRCsUoP?K6bt3YD\ui5Fh?f
	LONpR';(ql)VM_TQ/<l_^D3~B:z$\YC7gUCuC=sYm/80G=$tt"98mr8(l))QzVKCk$6~gldn~*FK9x
	8`;pM{3S8679sP+MbP,72<3_PIH-$I&iaiIb|hV1d%cYg))BmI)AZ
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Saturday May 22, torvalds@osdl.org wrote:
> 
> The plan is to make this very light-weight, and to fit in with how we 
> already pass patches around - just add the sign-off to the end of the 
> explanation part of the patch. That sign-off would be just a single line 
> at the end (possibly after _other_ peoples sign-offs), saying:
> 
> 	Signed-off-by: Random J Developer <random@developer.org>
> 

Sounds straight forward enough.

I make sure the appropriate line is at the bottom  of the changelog
comment for every patch I submit.
When I get a patch from someone else that doesn't have their
Signed-off-by line, I either:
  1/ if it is a trivial patch, just add  
               From:  Random J Developer <random@developer.org>
  2/ if it is more substantial (using my own personal definition of
     substantial), I ask them to sign it off.

> 
> 	Developer's Certificate of Origin 1.0

If this is version 1.0, then presumably there might be a version X, 
 X != 1.0  one day. In that case, should the Signed-off-by: tag indicate
 the Certificate of Origin that they are asserting by reference?
e.g.
    Signed-off-by:  Random J Developer <random@developer.org> (certificate=1.0)
or maybe
    Origin-certified-1.0-by: Random J Developer <random@developer.org>

Maybe I'm being too legalistic...

NeilBrown
