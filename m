Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262034AbVD0VfF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262034AbVD0VfF (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 27 Apr 2005 17:35:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262040AbVD0VfE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 27 Apr 2005 17:35:04 -0400
Received: from mail.dif.dk ([193.138.115.101]:40861 "EHLO saerimmer.dif.dk")
	by vger.kernel.org with ESMTP id S262034AbVD0Vev (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 27 Apr 2005 17:34:51 -0400
Date: Wed, 27 Apr 2005 23:38:11 +0200 (CEST)
From: Jesper Juhl <juhl-lkml@dif.dk>
To: Stefan Richter <stefanr@s5r6.in-berlin.de>
Cc: linux1394-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: Re: [2.6 patch] drivers/ieee1394/: remove unneeded EXPORT_SYMBOL's
In-Reply-To: <4270001F.8020504@s5r6.in-berlin.de>
Message-ID: <Pine.LNX.4.62.0504272337130.2481@dragon.hyggekrogen.localhost>
References: <20050417195706.GD3625@stusta.de>  <20050419191328.GJ1111@conscoop.ottawa.on.ca>
  <1113939827.6277.86.camel@laptopd505.fenrus.org>  <42657F7C.8060305@s5r6.in-berlin.de>
  <1113981989.6238.30.camel@laptopd505.fenrus.org>  <426683E9.4080708@s5r6.in-berlin.de>
 <1114029144.5085.20.camel@kino.dennedy.org> <4270001F.8020504@s5r6.in-berlin.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 27 Apr 2005, Stefan Richter wrote:

> Dan Dennedy wrote on 2005-04-20:
> > There are technical
> > merits for removal of the external symbols that I accept. I also accept
> > that we have no way of maintaining any sort of stable subsystem for
> > external projects we are not aware of or who are not communicating with
> > us about their requirements (it goes beyond just a stable interface).
> ...
> > I vote to remove external symbols not used by the Linux1394.org modules
> > or the module at http://sourceforge.net/projects/video-2-1394/
> 
> Nobody else posted specific requirements so far. So let's clean up the API.
> How about this:
<snip>
>  - Add warning comments next to obsolete EXPORT_SYMBOLs. Add warning
>    printks to obsolete functions? (If there are any.)

how about just adding __deprecated to them?

-- 
Jesper Juhl

