Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262930AbVCDRdl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262930AbVCDRdl (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 4 Mar 2005 12:33:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262964AbVCDRck
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 4 Mar 2005 12:32:40 -0500
Received: from smtp-out.hotpop.com ([38.113.3.61]:6309 "EHLO
	smtp-out.hotpop.com") by vger.kernel.org with ESMTP id S263017AbVCDRcY
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 4 Mar 2005 12:32:24 -0500
From: "Antonino A. Daplas" <adaplas@hotpop.com>
Reply-To: adaplas@pol.net
To: linux-fbdev-devel@lists.sourceforge.net, Jesper Juhl <juhl-lkml@dif.dk>,
       Paul Mundt <lethal@chaoticdreams.org>
Subject: Re: [Linux-fbdev-devel] [PATCH][resend] drivers/video/kyro/fbdev.c ignoring return value of copy_*_user
Date: Sat, 5 Mar 2005 01:32:06 +0800
User-Agent: KMail/1.5.4
Cc: linux-fbdev-devel <linux-fbdev-devel@lists.sourceforge.net>,
       LKML <linux-kernel@vger.kernel.org>
References: <Pine.LNX.4.62.0503041514110.2794@dragon.hygekrogen.localhost>
In-Reply-To: <Pine.LNX.4.62.0503041514110.2794@dragon.hygekrogen.localhost>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200503050132.10895.adaplas@hotpop.com>
X-HotPOP: -----------------------------------------------
                   Sent By HotPOP.com FREE Email
             Get your FREE POP email at www.HotPOP.com
          -----------------------------------------------
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday 04 March 2005 22:26, Jesper Juhl wrote:
> Hi,
>
> 2.6.11 still contain these warnings :
>
> drivers/video/kyro/fbdev.c:597: warning: ignoring return value of
> `copy_from_user', declared with attribute warn_unused_result
> drivers/video/kyro/fbdev.c:607: warning: ignoring return value of
> `copy_from_user', declared with attribute warn_unused_result
> drivers/video/kyro/fbdev.c:628: warning: ignoring return value of
> `copy_to_user', declared with attribute warn_unused_result
> drivers/video/kyro/fbdev.c:631: warning: ignoring return value of
> `copy_to_user', declared with attribute warn_unused_result
> drivers/video/kyro/fbdev.c:634: warning: ignoring return value of
> `copy_to_user', declared with attribute warn_unused_result
>
> Here's a patch that has been send before but obviously didn't make it in.
> re-diff'ed against 2.6.11

Your patch is already in the mm tree along with the other fbdev patches.

Tony


