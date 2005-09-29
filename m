Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751382AbVI2XqJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751382AbVI2XqJ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 29 Sep 2005 19:46:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751392AbVI2XqJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 29 Sep 2005 19:46:09 -0400
Received: from zproxy.gmail.com ([64.233.162.196]:1398 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1751382AbVI2XqH (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 29 Sep 2005 19:46:07 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:user-agent:x-accept-language:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding;
        b=SWKGopIkOdlFP3JGwsXqOA9qRvUqPr3jmsUoCEcFCOLSIAut13jAJgAyCevU/P9Hn8It3qErUusCzrlG81cWxGyTlrtdk+hNXiw0ifAzrSXv/9cOP/WLjc+sKxdu3maQjl/aH73TUPPZXg4os8kwrDax+vrvTZbmrw8fT4SKf4s=
Message-ID: <433C7CAA.4080700@gmail.com>
Date: Fri, 30 Sep 2005 07:45:46 +0800
From: "Antonino A. Daplas" <adaplas@gmail.com>
User-Agent: Mozilla Thunderbird 1.0.6 (X11/20050715)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
CC: michal.k.k.piotrowski@gmail.com, linux-kernel@vger.kernel.org
Subject: Re: 2.6.14-rc2-mm2
References: <20050929143732.59d22569.akpm@osdl.org>	<6bffcb0e05092915472f8589eb@mail.gmail.com>	<433C765D.9020205@gmail.com> <20050929162507.3efb8b1a.akpm@osdl.org>
In-Reply-To: <20050929162507.3efb8b1a.akpm@osdl.org>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton wrote:
> "Antonino A. Daplas" <adaplas@gmail.com> wrote:
>> Michal Piotrowski wrote:
>>> Hi,
>>>
>>> On 29/09/05, Andrew Morton <akpm@osdl.org> wrote:
>>>> ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.14-rc2/2.6.14-rc2-mm2/
>>>>
>>>> (temp copy at http://www.zip.com.au/~akpm/linux/patches/stuff/2.6.14-rc2-mm2.gz)
>>> VESA VGA graphics support doesn't work with nvidia card (black
>>> screen). (I know there is nvidia frame buffer support, but VESA VGA
>>> works for me on current git).
>>>
>>> #
>>> # Console display driver support
>>> #
>>> CONFIG_VGA_CONSOLE=y
>>> CONFIG_DUMMY_CONSOLE=y
>>> # CONFIG_FRAMEBUFFER_CONSOLE is not set
>> Set this to y.
>>
> 
> Was this a slipup by Michal, or did we do something to fool `make oldconfig'?
> 

'make oldconfig' works for me.

Tony
