Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268762AbUIBT5I@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268762AbUIBT5I (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 2 Sep 2004 15:57:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268928AbUIBT5H
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 2 Sep 2004 15:57:07 -0400
Received: from smtp-out.hotpop.com ([38.113.3.71]:13699 "EHLO
	smtp-out.hotpop.com") by vger.kernel.org with ESMTP id S268767AbUIBTwc
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 2 Sep 2004 15:52:32 -0400
From: "Antonino A. Daplas" <adaplas@hotpop.com>
Reply-To: adaplas@pol.net
To: Paolo Ornati <ornati@fastwebnet.it>, adaplas@pol.net
Subject: Re: 2.6.9-rc1: scrolling with tdfxfb 5 times slower
Date: Fri, 3 Sep 2004 03:52:19 +0800
User-Agent: KMail/1.5.4
Cc: linux-kernel@vger.kernel.org
References: <200408312133.40039.ornati@fastwebnet.it> <200409022020.19062.adaplas@hotpop.com> <200409021910.58511.ornati@fastwebnet.it>
In-Reply-To: <200409021910.58511.ornati@fastwebnet.it>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200409030352.19973.adaplas@hotpop.com>
X-HotPOP: -----------------------------------------------
                   Sent By HotPOP.com FREE Email
             Get your FREE POP email at www.HotPOP.com
          -----------------------------------------------
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday 03 September 2004 01:10, Paolo Ornati wrote:
> On Thursday 02 September 2004 14:20, Antonino A. Daplas wrote:
> > Just to finalize everything, 2 more things:
> >
> > 1. Does changing the resolution affect the vyres upper limit?
>
> I have tried with 640x480, 800x600 and 1024x768 and the upper limit seems
> the same (I've also tried some combinations of resolution / BPP)
>
> > 2. What happens if you comment out banshee_wait_idle in tdfxfb_fillrect,
> > tdfxfb_copyarea and tdfxfb_imageblit?  Scrolling should go faster but
> > will removing it cause additional screen corruption?
>
> scrolling is a bit faster and I don't notice any additional screen
> corruption
>
> time cat MAINTAINERS (2.6.9-rc1 + your patch / 800x600 8bpp / YRES 3200)
>
> normal: ~0.19
> without banshee_wait_idle in the three functions: ~0.12

Thanks for all the help.  I'll finalize a patch soon.

Tony


