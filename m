Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750779AbVI2XTN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750779AbVI2XTN (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 29 Sep 2005 19:19:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751274AbVI2XTN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 29 Sep 2005 19:19:13 -0400
Received: from zproxy.gmail.com ([64.233.162.204]:29630 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1750779AbVI2XTM (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 29 Sep 2005 19:19:12 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:user-agent:x-accept-language:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding;
        b=cae5zMRLZShTEHvFx9UyTrptzR55llFeSIW64oKdtFFWTPizhoph5d5MYtIXMWWYM8BKbT6b8C2sCA7De6TBQ4sCZ/vJQD5F3p+B8RQxZlH+lHyx71s0Hfe52WeCN8WrZ+zuOOKTCfhZswHcP93SwIGqHB0d2Pa/pA3+H7CT+KE=
Message-ID: <433C765D.9020205@gmail.com>
Date: Fri, 30 Sep 2005 07:18:53 +0800
From: "Antonino A. Daplas" <adaplas@gmail.com>
User-Agent: Mozilla Thunderbird 1.0.6 (X11/20050715)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Michal Piotrowski <michal.k.k.piotrowski@gmail.com>
CC: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: 2.6.14-rc2-mm2
References: <20050929143732.59d22569.akpm@osdl.org> <6bffcb0e05092915472f8589eb@mail.gmail.com>
In-Reply-To: <6bffcb0e05092915472f8589eb@mail.gmail.com>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Michal Piotrowski wrote:
> Hi,
> 
> On 29/09/05, Andrew Morton <akpm@osdl.org> wrote:
>> ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.14-rc2/2.6.14-rc2-mm2/
>>
>> (temp copy at http://www.zip.com.au/~akpm/linux/patches/stuff/2.6.14-rc2-mm2.gz)
> 
> VESA VGA graphics support doesn't work with nvidia card (black
> screen). (I know there is nvidia frame buffer support, but VESA VGA
> works for me on current git).
> 
> #
> # Console display driver support
> #
> CONFIG_VGA_CONSOLE=y
> CONFIG_DUMMY_CONSOLE=y
> # CONFIG_FRAMEBUFFER_CONSOLE is not set

Set this to y.

Tony 
