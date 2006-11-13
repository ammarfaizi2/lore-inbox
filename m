Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1754372AbWKMJxP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754372AbWKMJxP (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Nov 2006 04:53:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754373AbWKMJxP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Nov 2006 04:53:15 -0500
Received: from ug-out-1314.google.com ([66.249.92.172]:43758 "EHLO
	ug-out-1314.google.com") by vger.kernel.org with ESMTP
	id S1754368AbWKMJxO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Nov 2006 04:53:14 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=HXMzZirj/Zt3Sd+DIa3Rl4EnZtXxzwpTbqlyrOYSm9wBnmOfUOsVkSMu4P7+ono0ixzg70RB0BjFyvBfV92vj/Mce3eWzRDXCniAm9Oy+gjZupq0kfo3o+p/Kdl/mZyHP40zcHh+OqH6/bCXITGcaFwGO1vrPnc5aR9t+rPyKl0=
Message-ID: <cda58cb80611130153n60579de0w2ebb59b050595b3b@mail.gmail.com>
Date: Mon, 13 Nov 2006 10:53:12 +0100
From: "Franck Bui-Huu" <vagabon.xyz@gmail.com>
To: "James Simmons" <jsimmons@infradead.org>
Subject: Re: [Linux-fbdev-devel] fbmem: is bootup logo broken for monochrome LCD ?
Cc: "Linux Fbdev development list" 
	<linux-fbdev-devel@lists.sourceforge.net>,
       "Linux Kernel Mailing List" <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.64.0611122138030.9472@pentafluge.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <45535C08.5020607@innova-card.com>
	 <Pine.LNX.4.64.0611122138030.9472@pentafluge.infradead.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/12/06, James Simmons <jsimmons@infradead.org> wrote:
>
> > I'm trying to display the bootup logo on a monochrome LCD (1 bit per
> > pixel). I had to hack fbmem.c in a couple of place to make it
> > works. I'm wondering now if these changes are correct since I'm not
> > familiar with this code. Could anybody take a look and tell me ?
>
> There are quite a few bugs in the code. I have a patch I have been working
> on for some time. The patch does the following:
>

I'd like to give your patch a try but have some trouble to apply it
cleanly. Care to resend it ?

> I.
>         Merge slow_imageblit and color_imageblit into one function.
> II.
>         The same code works on both big endian and little endian machines

Does this suppose to fix this issue I encountered:

http://marc.theaimsgroup.com/?l=linux-kernel&m=116315548626875&w=2

Thanks
-- 
               Franck
