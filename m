Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751193AbVKJSEY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751193AbVKJSEY (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 10 Nov 2005 13:04:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751195AbVKJSEY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 10 Nov 2005 13:04:24 -0500
Received: from mail1.kontent.de ([81.88.34.36]:10943 "EHLO Mail1.KONTENT.De")
	by vger.kernel.org with ESMTP id S1751193AbVKJSEX (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 10 Nov 2005 13:04:23 -0500
From: Oliver Neukum <oliver@neukum.org>
To: Adrian Bunk <bunk@stusta.de>
Subject: Re: [PATCH 8/8] Inline 3 functions
Date: Thu, 10 Nov 2005 19:04:22 +0100
User-Agent: KMail/1.8
Cc: Matthew Dobson <colpatch@us.ibm.com>,
       Pekka J Enberg <penberg@cs.helsinki.fi>, kernel-janitors@lists.osdl.org,
       linux-kernel@vger.kernel.org
References: <436FF51D.8080509@us.ibm.com> <43737D94.2060408@us.ibm.com> <20051110173822.GD5376@stusta.de>
In-Reply-To: <20051110173822.GD5376@stusta.de>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200511101904.23114.oliver@neukum.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Am Donnerstag, 10. November 2005 18:38 schrieb Adrian Bunk:
> > So are you suggesting that we don't mark these functions 'inline', or are
> > you just pointing out that we'll need to drop the 'inline' if there is ever
> > another caller?
> 
> I'd suggest to not mark them 'inline'.

It seems you have found one more use for sparse. How about a tag
like __single_inline that will cause a warning if a function having it
is called from more than one place?

	Regards
		Oliver
