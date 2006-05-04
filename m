Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751526AbWEDXHV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751526AbWEDXHV (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 4 May 2006 19:07:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751522AbWEDXHV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 4 May 2006 19:07:21 -0400
Received: from wx-out-0102.google.com ([66.249.82.201]:46172 "EHLO
	wx-out-0102.google.com") by vger.kernel.org with ESMTP
	id S1751476AbWEDXHU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 4 May 2006 19:07:20 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:user-agent:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding;
        b=bU3/9a77tve4LYaBqBieTMQRxSXyv5hBsCWg4kBTkRvBrPRSrUDjm3B1n9Rxw2gUzmJYjoZRVB13r60hAswAoHf72Fx1Lo8Ms8qICz/4aPP6I/y2JNqob+rYU4PIU7NJUyLV9JvtWrVXxhS3ZD7L+rx0ngjpqyYO5sK0g7+5Nss=
Message-ID: <445A8917.2030905@gmail.com>
Date: Fri, 05 May 2006 07:07:03 +0800
From: "Antonino A. Daplas" <adaplas@gmail.com>
User-Agent: Thunderbird 1.5.0.2 (X11/20060420)
MIME-Version: 1.0
To: grfgguvf.29601511@bloglines.com
CC: linux-kernel@vger.kernel.org
Subject: Re: Weird framebuffer bug?
References: <1146780118.931342476.15992.sendItem@bloglines.com>
In-Reply-To: <1146780118.931342476.15992.sendItem@bloglines.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

grfgguvf.29601511@bloglines.com wrote:
> --- Antonino A. Daplas <adaplas@gmail.com> wrote:
> 
>> And if you can't specify
> the actual resolution with vesafb, try nvidiafb.
> 
> 
> 
> I have specified the actual
> resolution. Text mode with vesafb fills the whole screen (and the on-screen
> menu says 1024x768 which is the native resolution of the monitor). The screenshot
> I took when using X via fbdev (set to 1024x768 too) while the displaying was
> erroneous is 1024x768 as well. It somehow just doesn't reach the monitor in
> that form.
> 

Does the same thing happens with different color depths?

Can you try using the "vesa" driver with X?  If the same thing happens, it might
be a problem with the BIOS.

BTW, what does dmesg and fbset -i say?

Tony

PS: I'll be traveling in a few hours, so I may not be able to answer back.
