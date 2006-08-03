Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932348AbWHCVbf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932348AbWHCVbf (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 3 Aug 2006 17:31:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932373AbWHCVbf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 3 Aug 2006 17:31:35 -0400
Received: from terminus.zytor.com ([192.83.249.54]:31889 "EHLO
	terminus.zytor.com") by vger.kernel.org with ESMTP id S932348AbWHCVbf
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 3 Aug 2006 17:31:35 -0400
Message-ID: <44D26A8B.9040907@zytor.com>
Date: Thu, 03 Aug 2006 14:28:43 -0700
From: "H. Peter Anvin" <hpa@zytor.com>
User-Agent: Thunderbird 1.5.0.4 (X11/20060614)
MIME-Version: 1.0
To: Dave Jones <davej@redhat.com>, Adrian Bunk <bunk@stusta.de>,
       linux-kernel@vger.kernel.org, David Woodhouse <dwmw2@infradead.org>,
       "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: Userspace visible of 3 include/asm/ headers
References: <20060803193952.GF25692@stusta.de> <20060803194410.GC16927@redhat.com>
In-Reply-To: <20060803194410.GC16927@redhat.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dave Jones wrote:
> 
>  > Header        : setup.h
>  > Architectures : i386, ia64, x86_64
>  > Contents:
>  > - COMMAND_LINE_SIZE on ia64, x86_64
>  > - much more on i386
>  > Should COMMAND_LINE_SIZE be visible to userspace?
> 
> Bootloaders probably need to know this.
> 

COMMAND_LINE_SIZE should be moved to a different header and be made 
common between all architectures.

	-hpa
