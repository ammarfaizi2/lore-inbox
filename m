Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932405AbWH1IZJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932405AbWH1IZJ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 28 Aug 2006 04:25:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751412AbWH1IZJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 28 Aug 2006 04:25:09 -0400
Received: from py-out-1112.google.com ([64.233.166.177]:19092 "EHLO
	py-out-1112.google.com") by vger.kernel.org with ESMTP
	id S1751407AbWH1IZI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 28 Aug 2006 04:25:08 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=Ai5RV5Yl0dWw+CAZsplAgKWlFzy80wBlQyH7Y1AA+CrIWlblkUphwJKQFUdlNVqO4e6AI+DAfu/SEECfL0eMnp+tvdfIoT3X4oqfCXGi1fXnYNgUvjJZUFcb09CJVStLkGrC11V3peQBoQMQlfq9CkBNi27b8vMFPdB1NLQVzgk=
Message-ID: <b0943d9e0608280125g238ae81et4f2b8fa51be257a0@mail.gmail.com>
Date: Mon, 28 Aug 2006 09:25:07 +0100
From: "Catalin Marinas" <catalin.marinas@gmail.com>
To: "Andrew Morton" <akpm@osdl.org>
Subject: Re: Linux v2.6.18-rc5
Cc: "Linus Torvalds" <torvalds@osdl.org>,
       "Linux Kernel Mailing List" <linux-kernel@vger.kernel.org>
In-Reply-To: <20060827231421.f0fc9db1.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <Pine.LNX.4.64.0608272122250.27779@g5.osdl.org>
	 <20060827231421.f0fc9db1.akpm@osdl.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 28/08/06, Andrew Morton <akpm@osdl.org> wrote:
> On Sun, 27 Aug 2006 21:30:50 -0700 (PDT)
> Linus Torvalds <torvalds@osdl.org> wrote:
>
> > Linux 2.6.18-rc5 is out there now
>
> (Reporters Bcc'ed: please provide updates)
>
> Serious-looking regressions include:

Probably not as serious but it looks like a real memory leak in
drivers/usb/input/hid-core.c. I reported it about 2 weeks ago on the
linux-usb-devel list -
http://article.gmane.org/gmane.linux.usb.devel/45691.

-- 
Catalin
