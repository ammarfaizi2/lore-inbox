Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262373AbVCCUnI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262373AbVCCUnI (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 3 Mar 2005 15:43:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262526AbVCCUjB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 3 Mar 2005 15:39:01 -0500
Received: from smtp-out.hotpop.com ([38.113.3.61]:12755 "EHLO
	smtp-out.hotpop.com") by vger.kernel.org with ESMTP id S262373AbVCCUhx
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 3 Mar 2005 15:37:53 -0500
From: "Antonino A. Daplas" <adaplas@hotpop.com>
Reply-To: adaplas@pol.net
To: Adrian Bunk <bunk@stusta.de>, adaplas@pol.net
Subject: Re: RFC: disallow modular framebuffers
Date: Fri, 4 Mar 2005 04:37:43 +0800
User-Agent: KMail/1.5.4
Cc: linux-fbdev-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
References: <20050301024118.GF4021@stusta.de> <200503040350.51163.adaplas@hotpop.com> <20050303202039.GH4608@stusta.de>
In-Reply-To: <20050303202039.GH4608@stusta.de>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200503040437.43495.adaplas@hotpop.com>
X-HotPOP: -----------------------------------------------
                   Sent By HotPOP.com FREE Email
             Get your FREE POP email at www.HotPOP.com
          -----------------------------------------------
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday 04 March 2005 04:20, Adrian Bunk wrote:
> On Fri, Mar 04, 2005 at 03:50:42AM +0800, Antonino A. Daplas wrote:
> >...
> >
> > > Is there any reason for these being three modules?
> > > It seems the best solution would be to make this one module composed of
> > > up to three object files?
> >
> > Yes.
>
> Two possible solutions:
> - rename savagefb.c and link the three files into savagefb.o
> - merge the other two files into savagefb.c
>
> I'd slightly prefer the first choice, but I can send patches for
> whichever you prefer.

I also prefer the first one even if it results into a big patch because
of the rename.

Tony



