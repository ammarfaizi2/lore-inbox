Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261934AbVCUX7L@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261934AbVCUX7L (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 21 Mar 2005 18:59:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262192AbVCUX5O
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 21 Mar 2005 18:57:14 -0500
Received: from smtp-out.hotpop.com ([38.113.3.61]:11666 "EHLO
	smtp-out.hotpop.com") by vger.kernel.org with ESMTP id S261934AbVCUXhH
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 21 Mar 2005 18:37:07 -0500
From: "Antonino A. Daplas" <adaplas@hotpop.com>
Reply-To: adaplas@pol.net
To: linux-fbdev-devel@lists.sourceforge.net, Andrew Morton <akpm@osdl.org>,
       Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Subject: Re: [Linux-fbdev-devel] Re: [2.6.11 Permedia-2 Framebuffer] driver broken (?).
Date: Tue, 22 Mar 2005 07:37:08 +0800
User-Agent: KMail/1.5.4
Cc: linux-kernel@vger.kernel.org, jim.hague@acm.org,
       linux-fbdev-devel@lists.sourceforge.net
References: <Pine.LNX.4.60.0503052355320.12643@poirot.grange> <20050321145936.6f742d89.akpm@osdl.org>
In-Reply-To: <20050321145936.6f742d89.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200503220737.08763.adaplas@hotpop.com>
X-HotPOP: -----------------------------------------------
                   Sent By HotPOP.com FREE Email
             Get your FREE POP email at www.HotPOP.com
          -----------------------------------------------
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 22 March 2005 06:59, Andrew Morton wrote:
> Guennadi Liakhovetski <g.liakhovetski@gmx.de> wrote:
> > Hi
> >
> > Worked on 2.6.10-rc2. With 2.6.11 during boot upon switching to fb, text
> > becomes orange, penguins look sick (not sharp). X starts and runs normal
> > (doesn't use fb), switching to vt not possible any more. Disabling
> > fb-console in kernel config fixes VTs. Reverting pm2fb.c fixes the
> > problem.
>
> Guennadi, could you please confirm that
>
> ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.12-rc1/2.
>6.12-rc1-mm1/broken-out/pm2fb-x-and-vt-switching-crash-fix.patch
>
> fixes this one?
>

Actually, he was the one that confirmed that the above patch fixes this
problem.

Tony


