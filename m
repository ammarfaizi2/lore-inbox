Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932076AbWF2Jay@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932076AbWF2Jay (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 29 Jun 2006 05:30:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932776AbWF2Jay
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 29 Jun 2006 05:30:54 -0400
Received: from py-out-1112.google.com ([64.233.166.181]:23769 "EHLO
	py-out-1112.google.com") by vger.kernel.org with ESMTP
	id S932076AbWF2Jax (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 29 Jun 2006 05:30:53 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:user-agent:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding;
        b=jKv981dyDkh18tvR2/gy+hhjCUDPB820j0NX5FEpy+0GZ1r/GFXRnTktG2nkJWYYRB0ni8065td5PaPFHqtKDf15043ekKGeOJ+kasWWt2hWhAP6jcnLkngBTpzJWuAcUgOxl4ZsRqHgmo2ThPNoyIP0tT8fCKrcsEiLmLYENC4=
Message-ID: <44A39DB8.6070705@gmail.com>
Date: Thu, 29 Jun 2006 17:30:32 +0800
From: "Antonino A. Daplas" <adaplas@gmail.com>
User-Agent: Thunderbird 1.5.0.4 (X11/20060516)
MIME-Version: 1.0
To: Jon Smirl <jonsmirl@gmail.com>
CC: linux-kernel@vger.kernel.org, alan@lxorguk.ukuu.org.uk,
       "Randy. Dunlap" <rdunlap@xenotime.net>
Subject: Re: [PATCH] remove include of screen_info.h from tty.h
References: <9e4733910606271352y4a9668e0n76536fc84771674@mail.gmail.com>
In-Reply-To: <9e4733910606271352y4a9668e0n76536fc84771674@mail.gmail.com>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jon Smirl wrote:
> screen_info.h doesn't have anything to do with the tty layer and
> shouldn't be included by tty.h. This patches removes the include and
> modifies all users to directly include screen_info.h. struct
> screen_info is mainly used to communicate with the console drivers in
> drivers/video/console. Note that this patch touches every arch and I
> have no way of testing it. If there is a mistake the worst thing that
> will happen is a compile error.

Can you resubmit this, even as an attachment. I think there's extra
whitespace and I couldn't get this to apply.

Tony
