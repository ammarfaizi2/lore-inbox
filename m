Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261870AbUKVAXg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261870AbUKVAXg (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 21 Nov 2004 19:23:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261869AbUKVAWp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 21 Nov 2004 19:22:45 -0500
Received: from smtp-out.hotpop.com ([38.113.3.61]:61656 "EHLO
	smtp-out.hotpop.com") by vger.kernel.org with ESMTP id S261870AbUKVAVo
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 21 Nov 2004 19:21:44 -0500
From: "Antonino A. Daplas" <adaplas@hotpop.com>
Reply-To: adaplas@pol.net
To: Adrian Bunk <bunk@stusta.de>, source@mvista.com
Subject: Re: 2.6: drivers/video/aty/xlinit.c unused
Date: Mon, 22 Nov 2004 08:21:22 +0800
User-Agent: KMail/1.5.4
Cc: linux-kernel@vger.kernel.org
References: <20041121020636.GH2829@stusta.de>
In-Reply-To: <20041121020636.GH2829@stusta.de>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200411220821.22620.adaplas@hotpop.com>
X-HotPOP: -----------------------------------------------
                   Sent By HotPOP.com FREE Email
             Get your FREE POP email at www.HotPOP.com
          -----------------------------------------------
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sunday 21 November 2004 10:06, Adrian Bunk wrote:
> It seems drivers/video/aty/xlinit.c should be used with
> CONFIG_FB_ATY_XL_INIT, but currently, it's under no circumstances
> compiled...

It's supposed to boot XL cards without using the BIOS. 

If nobody complains, I'll remove it.

Thanks.

Tony


