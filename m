Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267359AbUHSURp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267359AbUHSURp (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 19 Aug 2004 16:17:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267361AbUHSURp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 19 Aug 2004 16:17:45 -0400
Received: from [12.177.129.25] ([12.177.129.25]:16580 "EHLO
	ccure.user-mode-linux.org") by vger.kernel.org with ESMTP
	id S267359AbUHSURo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 19 Aug 2004 16:17:44 -0400
Message-Id: <200408192119.i7JLJNdW004190@ccure.user-mode-linux.org>
X-Mailer: exmh version 2.4 06/23/2000 with nmh-1.1-RC1
To: Sam Ravnborg <sam@ravnborg.org>
cc: Chris Wedgwood <cw@f00f.org>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] 2.6.8.1-mm2 --- UML build fixes 
In-Reply-To: Your message of "Thu, 19 Aug 2004 22:55:06 +0200."
             <20040819205506.GA7440@mars.ravnborg.org> 
References: <20040819014204.2d412e9b.akpm@osdl.org> <20040819122915.GA2085@taniwha.stupidest.org>  <20040819205506.GA7440@mars.ravnborg.org> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Thu, 19 Aug 2004 17:19:23 -0400
From: Jeff Dike <jdike@addtoit.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

sam@ravnborg.org said:
> What makes um so speciel that it cannot handle .lds files in arch/um/
> kernel like all other architectures? That would allow um to utilise
> the kbuild infrastructure, and no need for duplication. 

Beats me, as the comment says, I could not get the kbuild .lds.S : .lds rule
to fire for uml.lds.S.  make kept sending it to the asm .S.o rule.

> Code located in arch/um/ is an error. No code should stay there. 

OK, that's easily fixed.

> In general they seems too complicated for the task solved - but it may
> be needed. 

Yeah, they are.  They desperately need a reaming.

				Jeff
